// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:hamro_bhagaicha_batch35d/core/utils/snackbar_utils.dart';
// import 'package:hamro_bhagaicha_batch35d/features/auth/presentation/view_model/auth_view_model.dart';
// import 'package:hamro_bhagaicha_batch35d/features/auth/presentation/state/auth_state.dart';
// import 'package:image_picker/image_picker.dart';

// class AccountScreen extends ConsumerStatefulWidget {
//   const AccountScreen({super.key});

//   @override
//   ConsumerState<AccountScreen> createState() => _AccountScreenState();
// }

// class _AccountScreenState extends ConsumerState<AccountScreen> {
//   File? _profileImage;
//   final ImagePicker _picker = ImagePicker();

//   Future<void> _pickProfileImage() async {
//     final XFile? pickedImage =
//         await _picker.pickImage(source: ImageSource.gallery);

//     if (pickedImage != null) {
//       setState(() {
//         _profileImage = File(pickedImage.path);
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final isTablet = screenWidth > 600;

//     // Watch the AuthState
//     final authState = ref.watch(authviewModelProvider);

//     // Listen for error messages
//     ref.listen<AuthState>(authviewModelProvider, (previous, state) {
//       if (state.status == AuthStatus.error && state.errorMessage != null) {
//         SnackbarUtils.showError(context, state.errorMessage!);
//       }
//     });

//     return Scaffold(
//       extendBodyBehindAppBar: true,
//       backgroundColor: Colors.transparent,
//       body: Container(
//         width: double.infinity,
//         height: double.infinity,
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//             colors: [Color(0xFFD8F3DC), Color(0xFF475E4F)],
//           ),
//         ),
//         child: SafeArea(
//           child: Padding(
//             padding: EdgeInsets.symmetric(horizontal: isTablet ? 50 : 20),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 // Header
//                 SizedBox(height: isTablet ? 30 : 15),
//                 Stack(
//                   children: [
//                     Align(
//                       alignment: Alignment.center,
//                       child: Column(
//                         children: [
//                           Text(
//                             'My Account',
//                             style: TextStyle(
//                               fontSize: isTablet ? 40 : 24,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.black87,
//                             ),
//                           ),
//                           SizedBox(height: isTablet ? 5 : 2),
//                           Text(
//                             'मेरो खाता',
//                             style: TextStyle(
//                               fontSize: isTablet ? 24 : 14,
//                               color: Colors.black54,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Positioned(
//                       right: 0,
//                       child: IconButton(
//                         icon: Icon(
//                           Icons.settings,
//                           size: isTablet ? 36 : 24,
//                           color: Colors.black87,
//                         ),
//                         onPressed: () {},
//                       ),
//                     ),
//                   ],
//                 ),

//                 SizedBox(height: isTablet ? 40 : 50),

//                 // Profile Section (CLICKABLE)
//                 GestureDetector(
//                   onTap: _pickProfileImage,
//                   child: Stack(
//                     children: [
//                       CircleAvatar(
//                         radius: isTablet ? 60 : 40,
//                         backgroundImage: _profileImage != null
//                             ? FileImage(_profileImage!)
//                             : const NetworkImage(
//                                 'https://i.pravatar.cc/150?img=3',
//                               ) as ImageProvider,
//                       ),
//                       Positioned(
//                         bottom: 0,
//                         right: 0,
//                         child: CircleAvatar(
//                           radius: 14,
//                           backgroundColor: Colors.green,
//                           child: Icon(
//                             Icons.camera_alt,
//                             size: 14,
//                             color: Colors.white,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),

//                 SizedBox(height: isTablet ? 20 : 10),
//                 Text(
//                   authState.authEntity?.fullname ?? 'Aarati Chettri',
//                   style: TextStyle(
//                     fontSize: isTablet ? 28 : 18,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 Text(
//                   authState.authEntity?.email ?? 'aaratichettri46@gmail.com',
//                   style: TextStyle(
//                     fontSize: isTablet ? 20 : 14,
//                     color: Colors.black54,
//                   ),
//                 ),
//                 SizedBox(height: isTablet ? 30 : 20),

//                 // Activity Section
//                 Container(
//                   padding: EdgeInsets.all(isTablet ? 20 : 12),
//                   decoration: BoxDecoration(
//                     color: const Color.fromARGB(180, 233, 247, 219),
//                     borderRadius: BorderRadius.circular(isTablet ? 30 : 20),
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'My Activity',
//                         style: TextStyle(
//                           fontSize: isTablet ? 24 : 16,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       SizedBox(height: isTablet ? 20 : 10),
//                       _activityRow('📦', 'My Orders'),
//                       _activityRow('🌱', 'Plants'),
//                       _activityRow('💡', 'Saved Tips'),
//                       _activityRow('👥', 'Community Contributed'),
//                       _activityRow('✉️', 'Chat'),
//                     ],
//                   ),
//                 ),

//                 SizedBox(height: 20),

//                 // Logout Button
//                 GestureDetector(
//                   onTap: () async {
//                     // Show confirmation dialog
//                     final shouldLogout = await showDialog<bool>(
//                       context: context,
//                       builder: (context) => AlertDialog(
//                         title: const Text('Logout'),
//                         content: const Text('Are you sure you want to logout?'),
//                         actions: [
//                           TextButton(
//                             onPressed: () => Navigator.of(context).pop(false),
//                             child: const Text('No'),
//                           ),
//                           TextButton(
//                             onPressed: () => Navigator.of(context).pop(true),
//                             child: const Text('Yes'),
//                           ),
//                         ],
//                       ),
//                     );

//                     if (shouldLogout != null && shouldLogout) {
//                       // Trigger logout
//                       await ref.read(authviewModelProvider.notifier).logout();

//                       // Show success snackbar
//                       SnackbarUtils.showSuccess(context, 'Logout successful');

//                       // Navigate to login screen after a short delay
//                       Future.delayed(const Duration(seconds: 0), () {
//                         Navigator.pushNamedAndRemoveUntil(
//                             context, '/login', (route) => false);
//                       });
//                     }
//                   },
//                   child: Container(
//                     width: double.infinity,
//                     padding: EdgeInsets.symmetric(
//                       vertical: isTablet ? 20 : 12,
//                     ),
//                     decoration: BoxDecoration(
//                       color: const Color.fromARGB(180, 233, 247, 219),
//                       borderRadius: BorderRadius.circular(isTablet ? 30 : 20),
//                     ),
//                     child: Center(
//                       child: authState.status == AuthStatus.loading
//                           ? const CircularProgressIndicator()
//                           : Text(
//                               'LogOut',
//                               style: TextStyle(
//                                 fontSize: isTablet ? 24 : 16,
//                                 fontWeight: FontWeight.bold,
//                                 color: const Color.fromARGB(255, 189, 114, 1),
//                               ),
//                             ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _activityRow(String icon, String title) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8),
//       child: Row(
//         children: [
//           Text(icon, style: const TextStyle(fontSize: 20)),
//           const SizedBox(width: 12),
//           Text(title, style: const TextStyle(fontSize: 16)),
//         ],
//       ),
//     );
//   }
// }


// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:hamro_bhagaicha_batch35d/core/utils/snackbar_utils.dart';
// import 'package:hamro_bhagaicha_batch35d/features/auth/presentation/view_model/auth_view_model.dart';
// import 'package:hamro_bhagaicha_batch35d/features/auth/presentation/state/auth_state.dart';
// import 'package:image_picker/image_picker.dart';

// class AccountScreen extends ConsumerStatefulWidget {
//   const AccountScreen({super.key});

//   @override
//   ConsumerState<AccountScreen> createState() => _AccountScreenState();
// }

// class _AccountScreenState extends ConsumerState<AccountScreen> {
//   File? _profileImage;
//   final ImagePicker _picker = ImagePicker();

//   Future<void> _pickProfileImage() async {
//     final XFile? pickedImage =
//         await _picker.pickImage(source: ImageSource.gallery);

//     if (pickedImage != null) {
//       final imageFile = File(pickedImage.path);

//       // 1️⃣ Show instant preview
//       setState(() {
//         _profileImage = imageFile;
//       });

//       // 2️⃣ Call notifier to upload image
//       final authNotifier = ref.read(authviewModelProvider.notifier);

//       // Show uploading snackbar
//       SnackbarUtils.showInfo(context, 'Uploading image...');

//       await authNotifier.updateProfileImage(imageFile);

//       // 3️⃣ Listen to updated state
//       final authState = ref.read(authviewModelProvider);
//       if (authState.status == AuthStatus.error && authState.errorMessage != null) {
//         SnackbarUtils.showError(context, authState.errorMessage!);
//       } else if (authState.status == AuthStatus.authenticated) {
//         SnackbarUtils.showSuccess(context, 'Profile image updated successfully!');
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final isTablet = screenWidth > 600;

//     // Watch the AuthState
//     final authState = ref.watch(authviewModelProvider);

//     // Listen for error messages
//     ref.listen<AuthState>(authviewModelProvider, (previous, state) {
//       if (state.status == AuthStatus.error && state.errorMessage != null) {
//         SnackbarUtils.showError(context, state.errorMessage!);
//       }
//     });

//     // Determine profile image: backend first, then picked, else placeholder
//     ImageProvider profileImageProvider;
//     if (_profileImage != null) {
//       profileImageProvider = FileImage(_profileImage!);
//     } else if (authState.authEntity?.profilePicture != null &&
//         authState.authEntity!.profilePicture!.isNotEmpty) {
//       profileImageProvider = NetworkImage(authState.authEntity!.profilePicture!);
//     } else {
//       profileImageProvider = const NetworkImage('https://i.pravatar.cc/150?img=3');
//     }

//     return Scaffold(
//       extendBodyBehindAppBar: true,
//       backgroundColor: Colors.transparent,
//       body: Container(
//         width: double.infinity,
//         height: double.infinity,
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//             colors: [Color(0xFFD8F3DC), Color(0xFF475E4F)],
//           ),
//         ),
//         child: SafeArea(
//           child: Padding(
//             padding: EdgeInsets.symmetric(horizontal: isTablet ? 50 : 20),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 // Header
//                 SizedBox(height: isTablet ? 30 : 15),
//                 Stack(
//                   children: [
//                     Align(
//                       alignment: Alignment.center,
//                       child: Column(
//                         children: [
//                           Text(
//                             'My Account',
//                             style: TextStyle(
//                               fontSize: isTablet ? 40 : 24,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.black87,
//                             ),
//                           ),
//                           SizedBox(height: isTablet ? 5 : 2),
//                           Text(
//                             'मेरो खाता',
//                             style: TextStyle(
//                               fontSize: isTablet ? 24 : 14,
//                               color: Colors.black54,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Positioned(
//                       right: 0,
//                       child: IconButton(
//                         icon: Icon(
//                           Icons.settings,
//                           size: isTablet ? 36 : 24,
//                           color: Colors.black87,
//                         ),
//                         onPressed: () {},
//                       ),
//                     ),
//                   ],
//                 ),

//                 SizedBox(height: isTablet ? 40 : 50),

//                 // Profile Section (CLICKABLE)
//                 GestureDetector(
//                   onTap: _pickProfileImage,
//                   child: Stack(
//                     children: [
//                       CircleAvatar(
//                         radius: isTablet ? 60 : 40,
//                         backgroundImage: profileImageProvider,
//                       ),
//                       Positioned(
//                         bottom: 0,
//                         right: 0,
//                         child: CircleAvatar(
//                           radius: 14,
//                           backgroundColor: Colors.green,
//                           child: Icon(
//                             Icons.camera_alt,
//                             size: 14,
//                             color: Colors.white,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),

//                 SizedBox(height: isTablet ? 20 : 10),
//                 Text(
//                   authState.authEntity?.fullname ?? 'Aarati Chettri',
//                   style: TextStyle(
//                     fontSize: isTablet ? 28 : 18,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 Text(
//                   authState.authEntity?.email ?? 'aaratichettri46@gmail.com',
//                   style: TextStyle(
//                     fontSize: isTablet ? 20 : 14,
//                     color: Colors.black54,
//                   ),
//                 ),
//                 SizedBox(height: isTablet ? 30 : 20),

//                 // Activity Section
//                 Container(
//                   padding: EdgeInsets.all(isTablet ? 20 : 12),
//                   decoration: BoxDecoration(
//                     color: const Color.fromARGB(180, 233, 247, 219),
//                     borderRadius: BorderRadius.circular(isTablet ? 30 : 20),
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'My Activity',
//                         style: TextStyle(
//                           fontSize: isTablet ? 24 : 16,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       SizedBox(height: isTablet ? 20 : 10),
//                       _activityRow('📦', 'My Orders'),
//                       _activityRow('🌱', 'Plants'),
//                       _activityRow('💡', 'Saved Tips'),
//                       _activityRow('👥', 'Community Contributed'),
//                       _activityRow('✉️', 'Chat'),
//                     ],
//                   ),
//                 ),

//                 SizedBox(height: 20),

//                 // Logout Button
//                 GestureDetector(
//                   onTap: () async {
//                     final shouldLogout = await showDialog<bool>(
//                       context: context,
//                       builder: (context) => AlertDialog(
//                         title: const Text('Logout'),
//                         content: const Text('Are you sure you want to logout?'),
//                         actions: [
//                           TextButton(
//                             onPressed: () => Navigator.of(context).pop(false),
//                             child: const Text('No'),
//                           ),
//                           TextButton(
//                             onPressed: () => Navigator.of(context).pop(true),
//                             child: const Text('Yes'),
//                           ),
//                         ],
//                       ),
//                     );

//                     if (shouldLogout != null && shouldLogout) {
//                       await ref.read(authviewModelProvider.notifier).logout();
//                       SnackbarUtils.showSuccess(context, 'Logout successful');
//                       Future.delayed(const Duration(seconds: 0), () {
//                         Navigator.pushNamedAndRemoveUntil(
//                             context, '/login', (route) => false);
//                       });
//                     }
//                   },
//                   child: Container(
//                     width: double.infinity,
//                     padding: EdgeInsets.symmetric(
//                       vertical: isTablet ? 20 : 12,
//                     ),
//                     decoration: BoxDecoration(
//                       color: const Color.fromARGB(180, 233, 247, 219),
//                       borderRadius: BorderRadius.circular(isTablet ? 30 : 20),
//                     ),
//                     child: Center(
//                       child: authState.status == AuthStatus.loading
//                           ? const CircularProgressIndicator()
//                           : Text(
//                               'LogOut',
//                               style: TextStyle(
//                                 fontSize: isTablet ? 24 : 16,
//                                 fontWeight: FontWeight.bold,
//                                 color: const Color.fromARGB(255, 189, 114, 1),
//                               ),
//                             ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _activityRow(String icon, String title) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8),
//       child: Row(
//         children: [
//           Text(icon, style: const TextStyle(fontSize: 20)),
//           const SizedBox(width: 12),
//           Text(title, style: const TextStyle(fontSize: 16)),
//         ],
//       ),
//     );
//   }
// }


import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:hamro_bhagaicha_batch35d/core/utils/snackbar_utils.dart';
import 'package:hamro_bhagaicha_batch35d/features/auth/presentation/view_model/auth_view_model.dart';
import 'package:hamro_bhagaicha_batch35d/features/auth/presentation/state/auth_state.dart';

class AccountScreen extends ConsumerStatefulWidget {
  const AccountScreen({super.key});

  @override
  ConsumerState<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends ConsumerState<AccountScreen> {
  File? _profileImage;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickProfileImage() async {
    final XFile? pickedImage = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _profileImage = File(pickedImage.path);
      });

      // Call the ViewModel to upload image
      await _uploadProfileImage(File(pickedImage.path));
    }
  }

  Future<void> _uploadProfileImage(File imageFile) async {
    final authViewModel = ref.read(authviewModelProvider.notifier);

    await authViewModel.updateProfileImage(imageFile);

    // Listen for updated state
    final state = ref.read(authviewModelProvider);
    if (state.status == AuthStatus.authenticated) {
      SnackbarUtils.showSuccess(context, 'Profile image uploaded successfully!');
    } else if (state.status == AuthStatus.error && state.errorMessage != null) {
      SnackbarUtils.showError(context, state.errorMessage!);
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;

    // Watch AuthState
    final authState = ref.watch(authviewModelProvider);

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
                // Header
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

                // Profile Section (CLICKABLE)
                GestureDetector(
                  onTap: _pickProfileImage,
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: isTablet ? 60 : 40,
                        backgroundImage: _profileImage != null
                            ? FileImage(_profileImage!)
                            : authState.authEntity?.profilePicture != null
                                ? NetworkImage(authState.authEntity!.profilePicture!)
                                : const NetworkImage('https://i.pravatar.cc/150?img=3')
                                    as ImageProvider,
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: CircleAvatar(
                          radius: 14,
                          backgroundColor: Colors.green,
                          child: Icon(
                            Icons.camera_alt,
                            size: 14,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: isTablet ? 20 : 10),
                Text(
                  authState.authEntity?.fullname ?? 'Aarati Chettri',
                  style: TextStyle(
                    fontSize: isTablet ? 28 : 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  authState.authEntity?.email ?? 'aaratichettri46@gmail.com',
                  style: TextStyle(
                    fontSize: isTablet ? 20 : 14,
                    color: Colors.black54,
                  ),
                ),
                SizedBox(height: isTablet ? 30 : 20),

                // Activity Section
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
                      _activityRow('💡', 'Saved Tips'),
                      _activityRow('👥', 'Community Contributed'),
                      _activityRow('✉️', 'Chat'),
                    ],
                  ),
                ),

                SizedBox(height: 20),

                // Logout Button
                GestureDetector(
                  onTap: () async {
                    final shouldLogout = await showDialog<bool>(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Logout'),
                        content: const Text('Are you sure you want to logout?'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(false),
                            child: const Text('No'),
                          ),
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(true),
                            child: const Text('Yes'),
                          ),
                        ],
                      ),
                    );

                    if (shouldLogout != null && shouldLogout) {
                      await ref.read(authviewModelProvider.notifier).logout();
                      SnackbarUtils.showSuccess(context, 'Logout successful');
                      Future.delayed(const Duration(seconds: 0), () {
                        Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
                      });
                    }
                  },
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: isTablet ? 20 : 12),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(180, 233, 247, 219),
                      borderRadius: BorderRadius.circular(isTablet ? 30 : 20),
                    ),
                    child: Center(
                      child: authState.status == AuthStatus.loading
                          ? const CircularProgressIndicator()
                          : Text(
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

  Widget _activityRow(String icon, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Text(icon, style: const TextStyle(fontSize: 20)),
          const SizedBox(width: 12),
          Text(title, style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}
