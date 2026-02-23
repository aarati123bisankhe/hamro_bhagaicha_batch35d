import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamro_bhagaicha_batch35d/app/routes/app_routes.dart';
import 'package:hamro_bhagaicha_batch35d/core/api/api_endpoint.dart';
import 'package:hamro_bhagaicha_batch35d/features/auth/domain/entities/auth_entity.dart';
import 'package:hamro_bhagaicha_batch35d/features/auth/presentation/pages/login_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:hamro_bhagaicha_batch35d/core/utils/snackbar_utils.dart';
import 'package:hamro_bhagaicha_batch35d/features/auth/presentation/view_model/auth_view_model.dart';
import 'package:hamro_bhagaicha_batch35d/features/auth/presentation/state/auth_state.dart';
import 'package:hamro_bhagaicha_batch35d/features/dashbaord/presentation/view_model/saved_tip_view_model.dart';

class AccountScreen extends ConsumerStatefulWidget {
  final AuthEntity userEntity;
  const AccountScreen({super.key, required this.userEntity});

  @override
  ConsumerState<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends ConsumerState<AccountScreen> {
  File? _profileImage;
  final ImagePicker _picker = ImagePicker();
  bool _showSavedTips = false;

  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: source,
        maxWidth: 1000,
        maxHeight: 1000,
        imageQuality: 85,
      );

      if (pickedFile == null) return;

      final imageFile = File(pickedFile.path);

      setState(() {
        _profileImage = imageFile;
      });

      // Upload to backend
      if (!mounted) return;
      SnackbarUtils.showInfo(context, 'Uploading image...');

      await ref
          .read(authViewModelProvider.notifier)
          .updateProfileImage(imageFile);
    } catch (e) {
      if (!mounted) return;
      SnackbarUtils.showError(context, "Failed to pick image: ${e.toString()}");
    }
  }

  void _showImageSourceDialog() {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Take Photo'),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Choose from Gallery'),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.gallery);
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _handleLogout() async {
    await ref.read(authViewModelProvider.notifier).logout();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;

    final authState = ref.watch(authViewModelProvider);
    final currentUser = authState.authEntity ?? widget.userEntity;
    final savedTips = ref.watch(savedTipViewModelProvider);

    ref.listen<AuthState>(authViewModelProvider, (previous, next) {
      if (next.status == AuthStatus.unauthenticated) {
        SnackbarUtils.showSuccess(context, "Loggedout successfully");
        AppRoutes.pushReplacement(context, const LoginScreen());
      } else if (next.status == AuthStatus.error && next.errorMessage != null) {
        SnackbarUtils.showError(context, next.errorMessage!);
      }
    });

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFD8F3DC), Color(0xFF475E4F)],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: isTablet ? 50 : 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: isTablet ? 30 : 15),
                Stack(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          Text(
                            'My Account',
                            style: TextStyle(
                              fontSize: isTablet ? 40 : 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          SizedBox(height: isTablet ? 5 : 2),
                          Text(
                            'मेरो खाता',
                            style: TextStyle(
                              fontSize: isTablet ? 24 : 14,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      right: 0,
                      child: IconButton(
                        icon: Icon(
                          Icons.settings,
                          size: isTablet ? 36 : 24,
                          color: Colors.black87,
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),

                SizedBox(height: isTablet ? 40 : 50),

                GestureDetector(
                  onTap: _showImageSourceDialog,
                  child: Container(
                    height: 140,
                    width: 140,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFFE3E3E3),
                      image: _profileImage != null
                          ? DecorationImage(
                              image: FileImage(_profileImage!),
                              fit: BoxFit.cover,
                            )
                          : (currentUser.profilePicture != null &&
                                currentUser.profilePicture!.isNotEmpty)
                          ? DecorationImage(
                              image: NetworkImage(
                                ApiEndpoints.profileImageUrl(
                                  currentUser.profilePicture!,
                                ),
                              ),
                              fit: BoxFit.cover,
                            )
                          : null,
                    ),
                    child:
                        _profileImage == null &&
                            (currentUser.profilePicture == null ||
                                currentUser.profilePicture!.isEmpty)
                        ? const Icon(Icons.person, size: 50)
                        : null,
                  ),
                ),

                SizedBox(height: isTablet ? 20 : 10),
                Text(
                  currentUser.fullname,
                  style: TextStyle(
                    fontSize: isTablet ? 28 : 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  currentUser.email,
                  style: TextStyle(
                    fontSize: isTablet ? 20 : 14,
                    color: Colors.black54,
                  ),
                ),
                SizedBox(height: isTablet ? 30 : 20),

                Container(
                  padding: EdgeInsets.all(isTablet ? 20 : 12),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(180, 233, 247, 219),
                    borderRadius: BorderRadius.circular(isTablet ? 30 : 20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'My Activity',
                        style: TextStyle(
                          fontSize: isTablet ? 24 : 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: isTablet ? 20 : 10),
                      _activityRow('📦', 'My Orders'),
                      _activityRow('🌱', 'Plants'),
                      _activityRow(
                        '💡',
                        'Saved Tips',
                        trailing: '${savedTips.length}',
                        onTap: () {
                          setState(() {
                            _showSavedTips = !_showSavedTips;
                          });
                        },
                      ),
                      _activityRow('👥', 'Community Contributed'),
                      _activityRow('✉️', 'Chat'),
                      AnimatedCrossFade(
                        duration: const Duration(milliseconds: 220),
                        crossFadeState: _showSavedTips
                            ? CrossFadeState.showFirst
                            : CrossFadeState.showSecond,
                        firstChild: Container(
                          width: double.infinity,
                          margin: const EdgeInsets.only(top: 8),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.7),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: savedTips.isEmpty
                              ? const Text(
                                  'No saved tips yet.',
                                  style: TextStyle(color: Colors.black54),
                                )
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    for (final tip in savedTips)
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 4,
                                        ),
                                        child: Text(
                                          '• ${tip.title}',
                                          style: TextStyle(
                                            fontSize: isTablet ? 18 : 14,
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                        ),
                        secondChild: const SizedBox.shrink(),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 20),

                // Logout Button
                // GestureDetector(
                //   onTap: () async {
                //     final shouldLogout = await showDialog<bool>(
                //       context: context,
                //       builder: (context) => AlertDialog(
                //         title: const Text('Logout'),
                //         content: const Text('Are you sure you want to logout?'),
                //         actions: [
                //           TextButton(
                //             onPressed: () => Navigator.of(context).pop(false),
                //             child: const Text('No'),
                //           ),
                //           TextButton(
                //             onPressed: () => Navigator.of(context).pop(true),
                //             child: const Text('Yes'),
                //           ),
                //         ],
                //       ),
                //     );

                //     if (shouldLogout != null && shouldLogout) {
                //       await ref.read(authViewModelProvider.notifier).logout();
                //       SnackbarUtils.showSuccess(context, 'Logout successful');
                //       Future.delayed(const Duration(seconds: 0), () {
                //         Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
                //       });
                //     }
                //   },
                //   child: Container(
                //     width: double.infinity,
                //     padding: EdgeInsets.symmetric(vertical: isTablet ? 20 : 12),
                //     decoration: BoxDecoration(
                //       color: const Color.fromARGB(180, 233, 247, 219),
                //       borderRadius: BorderRadius.circular(isTablet ? 30 : 20),
                //     ),
                //     child: Center(
                //       child: authState.status == AuthStatus.loading
                //           ? const CircularProgressIndicator()
                //           : Text(
                //               'LogOut',
                //               style: TextStyle(
                //                 fontSize: isTablet ? 24 : 16,
                //                 fontWeight: FontWeight.bold,
                //                 color: const Color.fromARGB(255, 189, 114, 1),
                //               ),
                //             ),
                //     ),
                //   ),
                // ),
                ElevatedButton(
                  onPressed: _handleLogout,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(isTablet ? 30 : 20),
                    ),
                  ),
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: isTablet ? 20 : 12),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(180, 233, 247, 219),
                      borderRadius: BorderRadius.circular(isTablet ? 30 : 20),
                    ),
                    child: Center(
                      child: Text(
                        'LogOut',
                        style: TextStyle(
                          fontSize: isTablet ? 24 : 16,
                          fontWeight: FontWeight.bold,
                          color: const Color.fromARGB(255, 189, 114, 1),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _activityRow(
    String icon,
    String title, {
    VoidCallback? onTap,
    String? trailing,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            Text(icon, style: const TextStyle(fontSize: 20)),
            const SizedBox(width: 12),
            Text(title, style: const TextStyle(fontSize: 16)),
            const Spacer(),
            if (trailing != null)
              Text(
                trailing,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.black54,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
