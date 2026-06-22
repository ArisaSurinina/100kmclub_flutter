import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import '../services/api_client.dart';
import '../services/auth_storage.dart';

import '../widgets/app_snack_bar.dart';

class AccountSettingsScreen extends StatefulWidget {
  final String name;
  final String email;
  final String? avatarUrl;

  const AccountSettingsScreen({
    super.key,
    required this.name,
    required this.email,
    this.avatarUrl,
  });

  @override
  State<AccountSettingsScreen> createState() => _AccountSettingsScreenState();
}

class _AccountSettingsScreenState extends State<AccountSettingsScreen> {
  bool _isEditingName = false;
  bool _isEditingPassword = false;
  bool _isUploadingAvatar = false;
  bool _isUpdatingPassword = false;
  String? _avatarUrl;
  int _avatarCacheKey = 0;
  bool _isSavingName = false;
  String _displayName = '';

  late final TextEditingController _nameController;
  final TextEditingController _currentPasswordController =
      TextEditingController();
  final TextEditingController _newPasswordController =
      TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

      @override
void initState() {
  super.initState();
  _displayName = widget.name;
  _nameController = TextEditingController(text: widget.name);
  _avatarUrl = widget.avatarUrl;
}

  @override
  void dispose() {
    _nameController.dispose();
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _cancelNameEdit() {
    setState(() {
      _isEditingName = false;
      _nameController.text = _displayName;
    });
  }

  void _cancelPasswordEdit() {
    setState(() {
      _isEditingPassword = false;
      _currentPasswordController.clear();
      _newPasswordController.clear();
      _confirmPasswordController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
  width: double.infinity,
  height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF1A1A1F),
              Color(0xFF16161A),
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 120),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 512),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _header(),
                    const SizedBox(height: 24),
                    _avatarSection(),
                    const SizedBox(height: 24),
                    _accountCard(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _header() {
    return Row(
      children: [
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.arrow_back,
              size: 24,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(width: 16),
        const Text(
          'Account Settings',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.2,
          ),
        ),
      ],
    );
  }

  String? _fullAvatarUrl() {
  final avatarUrl = _avatarUrl;

  if (avatarUrl == null || avatarUrl.isEmpty) {
    return null;
  }

  final separator = avatarUrl.contains('?') ? '&' : '?';

  if (avatarUrl.startsWith('http://') || avatarUrl.startsWith('https://')) {
    return '$avatarUrl${separator}v=$_avatarCacheKey';
  }

  return '${ApiClient.backendBaseUrl}$avatarUrl${separator}v=$_avatarCacheKey';
}

Future<void> _pickAndUploadAvatar() async {
  if (_isUploadingAvatar) return;

  final picker = ImagePicker();

  final file = await picker.pickImage(
    source: ImageSource.gallery,
    imageQuality: 90,
  );

  if (file == null) return;

  final token = await AuthStorage.readToken();

  if (token == null) {
    debugPrint('AVATAR UPLOAD FAILED: no auth token');
    return;
  }

  setState(() {
    _isUploadingAvatar = true;
  });

  try {
    final request = http.MultipartRequest(
      'POST',
      ApiClient.uri('/users/me/avatar'),
    );

    request.headers['Authorization'] = 'Bearer $token';

    request.files.add(
  await http.MultipartFile.fromPath(
    'file',
    file.path,
    contentType: MediaType('image', 'jpeg'),
  ),
);

    final streamedResponse = await request.send();
    final responseBody = await streamedResponse.stream.bytesToString();

    dynamic body;
    try {
      body = jsonDecode(responseBody);
    } catch (_) {
      throw Exception(
        'Server returned ${streamedResponse.statusCode}: $responseBody',
      );
    }

    if (streamedResponse.statusCode == 200 &&
        body is Map &&
        body['avatar_url'] is String) {
      final newAvatarUrl = body['avatar_url'] as String;

      setState(() {
         _avatarUrl = newAvatarUrl;
         _avatarCacheKey++;
    });

      debugPrint('AVATAR UPLOAD SUCCESS: $newAvatarUrl');
      return;
    }

    if (body is Map && body['detail'] is String) {
      throw Exception(body['detail']);
    }

    throw Exception('Failed to upload avatar.');
  } catch (error) {
    debugPrint('AVATAR UPLOAD ERROR: $error');
  } finally {
    if (mounted) {
      setState(() {
        _isUploadingAvatar = false;
      });
    }
  }
}

Future<void> _saveDisplayName() async {
  if (_isSavingName) return;

  final newName = _nameController.text.trim();

  if (newName.isEmpty) {
    debugPrint('NAME SAVE FAILED: empty name');
    return;
  }

  final token = await AuthStorage.readToken();

  if (token == null) {
    debugPrint('NAME SAVE FAILED: no auth token');
    return;
  }

  setState(() {
    _isSavingName = true;
  });

  try {
    final response = await http.patch(
      ApiClient.uri('/users/me/name'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'name': newName,
      }),
    );

    final body = jsonDecode(response.body);

    if (response.statusCode == 200 &&
        body is Map &&
        body['name'] is String) {
      final savedName = body['name'] as String;

setState(() {
  _displayName = savedName;
  _nameController.text = savedName;
  _isEditingName = false;
});

final storedUser = await AuthStorage.readUser();

if (storedUser != null) {
  storedUser['name'] = savedName;
  await AuthStorage.saveAuth(
    token: token,
    user: storedUser,
  );
}

debugPrint('NAME SAVE SUCCESS: ${body['name']}');
return;
    }

    throw Exception(body.toString());
  } catch (error) {
    debugPrint('NAME SAVE ERROR: $error');
  } finally {
    if (mounted) {
      setState(() {
        _isSavingName = false;
      });
    }
  }
}

Future<void> _changePassword() async {
  if (_isUpdatingPassword) return;

  final currentPassword = _currentPasswordController.text;
  final newPassword = _newPasswordController.text;
  final confirmPassword = _confirmPasswordController.text;

  if (currentPassword.isEmpty || newPassword.isEmpty || confirmPassword.isEmpty) {
    debugPrint('PASSWORD CHANGE FAILED: missing fields');
    return;
  }

  if (newPassword != confirmPassword) {
    debugPrint('PASSWORD CHANGE FAILED: new passwords do not match');
    return;
  }

  final token = await AuthStorage.readToken();

  if (token == null) {
    debugPrint('PASSWORD CHANGE FAILED: no auth token');
    return;
  }

  setState(() {
    _isUpdatingPassword = true;
  });

  try {
    final response = await http.post(
      ApiClient.uri('/auth/change-password'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'current_password': currentPassword,
        'new_password': newPassword,
      }),
    );

    final body = jsonDecode(response.body);

    if (response.statusCode == 200) {
      _currentPasswordController.clear();
      _newPasswordController.clear();
      _confirmPasswordController.clear();

      setState(() {
        _isEditingPassword = false;
      });

      AppSnackBar.success(context, 'Password updated successfully.');
debugPrint('PASSWORD CHANGE SUCCESS');
return;
    }

    if (body is Map && body['detail'] is String) {
      throw Exception(body['detail']);
    }

    throw Exception('Failed to update password.');
  } catch (error) {
    AppSnackBar.error(
  context,
  error.toString().replaceFirst('Exception: ', ''),
);
debugPrint('PASSWORD CHANGE ERROR: $error');
  } finally {
    if (mounted) {
      setState(() {
        _isUpdatingPassword = false;
      });
    }
  }
}

Widget _avatarSection() {
    return Center(
      child: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: 96,
                height: 96,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFF00FF94),
                ),
                child: ClipOval(
  child: _fullAvatarUrl() != null
    ? Image.network(
        _fullAvatarUrl()!,
          width: 96,
          height: 96,
          fit: BoxFit.cover,
        )
      : Center(
          child: Text(
  _displayName.isNotEmpty
      ? _displayName[0].toUpperCase()
      : '?',
  style: const TextStyle(
              color: Colors.black,
              fontSize: 36,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    ),
              Positioned(
                right: -4,
                bottom: -4,
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFF1A1A1A),
                    border: Border.all(
                      color: const Color(0xFF050505),
                      width: 2,
                    ),
                  ),
                  child: const Icon(
                    Icons.camera_alt_outlined,
                    size: 14,
                    color: Color.fromRGBO(255, 255, 255, 0.7),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          GestureDetector(
  onTap: _isUploadingAvatar ? null : _pickAndUploadAvatar,
  child: Text(
  _isUploadingAvatar ? 'Uploading...' : 'Change photo',
  style: const TextStyle(
    color: Color(0xFF00FF94),
    fontSize: 14,
    fontWeight: FontWeight.w400,
  ),
),
),
        ],
      ),
    );
  }

  Widget _accountCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(255, 255, 255, 0.02),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color.fromRGBO(255, 255, 255, 0.04),
        ),
      ),
      child: Column(
        children: [
          _displayNameRow(),
          _divider(),
          _changePasswordRow(),
          _divider(),
          _changeEmailRow(),
        ],
      ),
    );
  }

  Widget _displayNameRow() {
    if (_isEditingName) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _label('Display Name'),
            const SizedBox(height: 8),
            _textField(
              controller: _nameController,
              hint: 'Your name',
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                _smallPrimaryButton(
  _isSavingName ? '...' : 'Save',
  _saveDisplayName,
),
                const SizedBox(width: 8),
                _smallGhostButton('Cancel', _cancelNameEdit),
              ],
            ),
          ],
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
           Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Display Name',
                  style: TextStyle(
                    color: Color.fromRGBO(255, 255, 255, 0.4),
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
  _displayName,
  style: const TextStyle(
    color: Colors.white,
    fontSize: 14,
  ),
),
              ],
            ),
          ),
          _editIcon(() {
            setState(() {
              _isEditingName = true;
            });
          }),
        ],
      ),
    );
  }

  Widget _changePasswordRow() {
    if (_isEditingPassword) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: const [
                Icon(
                  Icons.lock_outline,
                  size: 14,
                  color: Color.fromRGBO(255, 255, 255, 0.4),
                ),
                SizedBox(width: 8),
                Text(
                  'Change password',
                  style: TextStyle(
                    color: Color.fromRGBO(255, 255, 255, 0.4),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            _passwordField(_currentPasswordController, 'Current password'),
            const SizedBox(height: 12),
            _passwordField(_newPasswordController, 'New password'),
            const SizedBox(height: 12),
            _passwordField(_confirmPasswordController, 'Confirm new password'),
            const SizedBox(height: 12),
            Row(
              children: [
                _smallPrimaryButton(
  _isUpdatingPassword ? '...' : 'Update',
  _changePassword,
),
                const SizedBox(width: 8),
                _smallGhostButton('Cancel', _cancelPasswordEdit),
              ],
            ),
          ],
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          const Icon(
            Icons.lock_outline,
            size: 14,
            color: Color.fromRGBO(255, 255, 255, 0.4),
          ),
          const SizedBox(width: 8),
          const Expanded(
            child: Text(
              'Change password',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            ),
          ),
          _editIcon(() {
            setState(() {
              _isEditingPassword = true;
            });
          }),
        ],
      ),
    );
  }

  Widget _changeEmailRow() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Icon(
            Icons.mail_outline,
            size: 14,
            color: Color.fromRGBO(255, 255, 255, 0.3),
          ),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              'Change email',
              style: TextStyle(
                color: Color.fromRGBO(255, 255, 255, 0.4),
                fontSize: 14,
              ),
            ),
          ),
          Text(
            'Coming soon',
            style: TextStyle(
              color: Color.fromRGBO(255, 255, 255, 0.25),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _divider() {
    return Container(
      height: 1,
      color: const Color.fromRGBO(255, 255, 255, 0.08),
    );
  }

  Widget _editIcon(VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Icon(
          Icons.edit_outlined,
          size: 14,
          color: Color.fromRGBO(255, 255, 255, 0.4),
        ),
      ),
    );
  }

  Widget _label(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: Color.fromRGBO(255, 255, 255, 0.4),
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _textField({
    required TextEditingController controller,
    required String hint,
  }) {
    return TextField(
      controller: controller,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 16,
      ),
      decoration: _inputDecoration(hint),
    );
  }

  Widget _passwordField(TextEditingController controller, String hint) {
    return TextField(
      controller: controller,
      obscureText: true,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 16,
      ),
      decoration: _inputDecoration(hint),
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(
        color: Color.fromRGBO(255, 255, 255, 0.25),
      ),
      filled: true,
      fillColor: const Color.fromRGBO(255, 255, 255, 0.03),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 12,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: Color.fromRGBO(255, 255, 255, 0.06),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: Color.fromRGBO(46, 230, 166, 0.3),
        ),
      ),
    );
  }

  Widget _smallPrimaryButton(
  String text,
  VoidCallback onTap,
) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      height: 36,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: const LinearGradient(
          colors: [
            Color.fromRGBO(46, 230, 166, 0.9),
            Color.fromRGBO(30, 200, 140, 0.9),
          ],
        ),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(46, 230, 166, 0.2),
            blurRadius: 16,
          ),
        ],
      ),
      child: Center(
        child: Text(
          text,
          style: const TextStyle(
            color: Color.fromRGBO(0, 0, 0, 0.85),
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    ),
  );
}

  Widget _smallGhostButton(String text, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        height: 36,
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              color: Color.fromRGBO(255, 255, 255, 0.5),
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }
}