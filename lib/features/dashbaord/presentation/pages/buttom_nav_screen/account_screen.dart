// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';

// class AccountScreen extends StatefulWidget {
//   const AccountScreen({super.key});

//   @override
//   State<AccountScreen> createState() => _AccountScreenState();
// }

// class _AccountScreenState extends State<AccountScreen> {
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
//                   'Aarati Chettri',
//                   style: TextStyle(
//                     fontSize: isTablet ? 28 : 18,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 Text(
//                   'aaratichettri46@gmail.com',
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
//                     color: Color.fromARGB(180, 233, 247, 219),
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
//                 Container(
//                   width: double.infinity,
//                   padding: EdgeInsets.symmetric(
//                     vertical: isTablet ? 20 : 12,
//                   ),
//                   decoration: BoxDecoration(
//                     color: Color.fromARGB(180, 233, 247, 219),
//                     borderRadius: BorderRadius.circular(isTablet ? 30 : 20),
//                   ),
//                   child: Center(
//                     child: Text(
//                       'LogOut',
//                       style: TextStyle(
//                         fontSize: isTablet ? 24 : 16,
//                         fontWeight: FontWeight.bold,
//                         color: Color.fromARGB(255, 189, 114, 1),
//                       ),
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
// import 'package:hamro_bhagaicha_batch35d/features/auth/presentation/view_model/auth_view_model.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:hamro_bhagaicha_batch35d/features/auth/presentation/state/auth_state.dart';

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

//     // Listen for logout state changes
//     ref.listen<AuthState>(authviewModelProvider, (previous, state) {
//       if (state.status == AuthStatus.unauthenticated) {
//         Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
//       } else if (state.status == AuthStatus.error && state.errorMessage != null) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text(state.errorMessage!)),
//         );
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
//                     color: Color.fromARGB(180, 233, 247, 219),
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
//                   onTap: () {
//                     // Trigger logout
//                     ref.read(authviewModelProvider.notifier).logout();
//                   },
//                   child: Container(
//                     width: double.infinity,
//                     padding: EdgeInsets.symmetric(
//                       vertical: isTablet ? 20 : 12,
//                     ),
//                     decoration: BoxDecoration(
//                       color: Color.fromARGB(180, 233, 247, 219),
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
//                                 color: Color.fromARGB(255, 189, 114, 1),
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
import 'package:hamro_bhagaicha_batch35d/core/utils/snackbar_utils.dart';
import 'package:hamro_bhagaicha_batch35d/features/auth/presentation/view_model/auth_view_model.dart';
import 'package:hamro_bhagaicha_batch35d/features/auth/presentation/state/auth_state.dart';
import 'package:image_picker/image_picker.dart';

class AccountScreen extends ConsumerStatefulWidget {
  const AccountScreen({super.key});

  @override
  ConsumerState<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends ConsumerState<AccountScreen> {
  File? _profileImage;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickProfileImage() async {
    final XFile? pickedImage =
        await _picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _profileImage = File(pickedImage.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;

    // Watch the AuthState
    final authState = ref.watch(authviewModelProvider);

    // Listen for error messages
    ref.listen<AuthState>(authviewModelProvider, (previous, state) {
      if (state.status == AuthStatus.error && state.errorMessage != null) {
        SnackbarUtils.showError(context, state.errorMessage!);
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
                            : const NetworkImage(
                                'https://i.pravatar.cc/150?img=3',
                              ) as ImageProvider,
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
                    // Show confirmation dialog
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
                      // Trigger logout
                      await ref.read(authviewModelProvider.notifier).logout();

                      // Show success snackbar
                      SnackbarUtils.showSuccess(context, 'Logout successful');

                      // Navigate to login screen after a short delay
                      Future.delayed(const Duration(seconds: 0), () {
                        Navigator.pushNamedAndRemoveUntil(
                            context, '/login', (route) => false);
                      });
                    }
                  },
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                      vertical: isTablet ? 20 : 12,
                    ),
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
