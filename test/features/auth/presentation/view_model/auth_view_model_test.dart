// import 'dart:io';
// import 'package:dartz/dartz.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:hamro_bhagaicha_batch35d/features/auth/presentation/view_model/auth_view_model.dart';
// import 'package:mocktail/mocktail.dart';
// import 'package:hamro_bhagaicha_batch35d/core/error/failure.dart';
// import 'package:hamro_bhagaicha_batch35d/features/auth/domain/entities/auth_entity.dart';
// import 'package:hamro_bhagaicha_batch35d/features/auth/domain/usecase/get_current_usecase.dart';
// import 'package:hamro_bhagaicha_batch35d/features/auth/domain/usecase/login_usecase.dart';
// import 'package:hamro_bhagaicha_batch35d/features/auth/domain/usecase/logout_usecase.dart';
// import 'package:hamro_bhagaicha_batch35d/features/auth/domain/usecase/register_usecase.dart';
// import 'package:hamro_bhagaicha_batch35d/features/auth/domain/usecase/update_profile_image_usecase.dart';
// import 'package:hamro_bhagaicha_batch35d/features/auth/presentation/state/auth_state.dart';

// class MockLoginUsecase extends Mock implements LoginUsecase {}

// class MockRegisterUsecase extends Mock implements RegisterUsecase {}

// class MockLogoutUsecase extends Mock implements LogoutUsecase {}

// class MockGetCurrentUserUsecase extends Mock
//     implements GetCurrentUserUsecase {}

// class MockUpdateProfileImageUsecase extends Mock
//     implements UpdateProfileImageUseCase {}

// void main() {
//   late ProviderContainer container;

//   late MockLoginUsecase mockLoginUsecase;
//   late MockRegisterUsecase mockRegisterUsecase;
//   late MockLogoutUsecase mockLogoutUsecase;
//   late MockGetCurrentUserUsecase mockGetCurrentUserUsecase;
//   late MockUpdateProfileImageUsecase mockUpdateProfileImageUsecase;

//   final user = AuthEntity(
//     fullname: 'Test User',
//     email: 'test@test.com',
//     password: '123456',
//     address: 'Kathmandu',
//     phoneNumber: '9800000000',
//   );

//   setUpAll(() {
//     registerFallbackValue(
//       LoginUsecaseParams(
//         email: 'fallback@test.com',
//         password: 'fallback',
//       ),
//     );

//     registerFallbackValue(
//       RegisterUsecaseParams(
//         fullName: 'fallback',
//         email: 'fallback@test.com',
//         password: 'fallback',
//         address: 'fallback',
//         phoneNumber: '0000000000',
//       ),
//     );

//     registerFallbackValue(
//       GetCurrentUsecaseParams(userId: 'fallback'),
//     );

//     registerFallbackValue(File('fallback.png'));
//   });

//   setUp(() {
//     mockLoginUsecase = MockLoginUsecase();
//     mockRegisterUsecase = MockRegisterUsecase();
//     mockLogoutUsecase = MockLogoutUsecase();
//     mockGetCurrentUserUsecase = MockGetCurrentUserUsecase();
//     mockUpdateProfileImageUsecase = MockUpdateProfileImageUsecase();

//     container = ProviderContainer(
//       overrides: [
//         loginUsecaseProvider.overrideWithValue(mockLoginUsecase),
//         registerUsecaseProvider.overrideWithValue(mockRegisterUsecase),
//         logoutUsecaseProvider.overrideWithValue(mockLogoutUsecase),
//         getCurrentUserUsecaseProvider
//             .overrideWithValue(mockGetCurrentUserUsecase),
//         updateProfileImageUsecaseProvider
//             .overrideWithValue(mockUpdateProfileImageUsecase),
//       ],
//     );
//   });

//   tearDown(() {
//     container.dispose();
//   });

//  //login
//   group('AuthViewModel - Login', () {
//     test('login success → authenticated', () async {
//       when(() => mockLoginUsecase(any()))
//           .thenAnswer((_) async => Right(user));

//       final notifier =
//           container.read(authViewModelProvider.notifier);

//       await notifier.login(
//         email: 'test@test.com',
//         password: '123456',
//       );

//       final state = container.read(authViewModelProvider);

//       expect(state.status, AuthStatus.authenticated);
//       expect(state.authEntity, user);
//     });

//     test('login failure → error', () async {
//       when(() => mockLoginUsecase(any())).thenAnswer(
//         (_) async => Left(ApiFailure(message: 'Invalid credentials')),
//       );

//       final notifier =
//           container.read(authViewModelProvider.notifier);

//       await notifier.login(
//         email: 'wrong@test.com',
//         password: 'wrong',
//       );

//       final state = container.read(authViewModelProvider);

//       expect(state.status, AuthStatus.error);
//       expect(state.errorMessage, 'Invalid credentials');
//     });
//   });

//   //register
//   group('AuthViewModel - Register', () {
//     test('register success → registered', () async {
//       when(() => mockRegisterUsecase(any()))
//           .thenAnswer((_) async => Right(user));

//       final notifier =
//           container.read(authViewModelProvider.notifier);

//       await notifier.register(
//         fullName: 'Test User',
//         email: 'test@test.com',
//         password: '123456',
//         address: 'Kathmandu',
//         phoneNumber: '9800000000',
//       );

//       final state = container.read(authViewModelProvider);

//       expect(state.status, AuthStatus.registered);
//       expect(state.authEntity, user);
//     });

//     test('register failure → error', () async {
//       when(() => mockRegisterUsecase(any())).thenAnswer(
//         (_) async => Left(ApiFailure(message: 'Register failed')),
//       );

//       final notifier =
//           container.read(authViewModelProvider.notifier);

//       await notifier.register(
//         fullName: 'Test',
//         email: 'test@test.com',
//         password: '123456',
//         address: 'KTm',
//         phoneNumber: '98',
//       );

//       final state = container.read(authViewModelProvider);

//       expect(state.status, AuthStatus.error);
//       expect(state.errorMessage, 'Register failed');
//     });
//   });

//   //get current user
//   group('AuthViewModel - Get Current User', () {
//     test('get current user success', () async {
//       when(() => mockGetCurrentUserUsecase(any()))
//           .thenAnswer((_) async => Right(user));

//       final notifier =
//           container.read(authViewModelProvider.notifier);

//       await notifier.getCurrentUser(userId: '1');

//       final state = container.read(authViewModelProvider);

//       expect(state.status, AuthStatus.currentUserLoaded);
//       expect(state.authEntity, user);
//     });
//   });

//   //update profile
//   group('AuthViewModel - Update Profile Image', () {
//     test('update profile image success', () async {
//       when(() => mockUpdateProfileImageUsecase(any()))
//           .thenAnswer((_) async => const Right('profile.png'));

//       final notifier =
//           container.read(authViewModelProvider.notifier);

//       await notifier.updateProfileImage(File('test.png'));

//       final state = container.read(authViewModelProvider);

//       expect(state.status, AuthStatus.loaded);
//       expect(state.uploadProfilePhotoName, 'profile.png');
//     });
//   });
// }



import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hamro_bhagaicha_batch35d/core/error/failure.dart';
import 'package:hamro_bhagaicha_batch35d/features/auth/domain/entities/auth_entity.dart';
import 'package:hamro_bhagaicha_batch35d/features/auth/domain/usecase/get_current_usecase.dart';
import 'package:hamro_bhagaicha_batch35d/features/auth/domain/usecase/login_usecase.dart';
import 'package:hamro_bhagaicha_batch35d/features/auth/domain/usecase/logout_usecase.dart';
import 'package:hamro_bhagaicha_batch35d/features/auth/domain/usecase/register_usecase.dart';
import 'package:hamro_bhagaicha_batch35d/features/auth/domain/usecase/update_profile_image_usecase.dart';
import 'package:hamro_bhagaicha_batch35d/features/auth/presentation/state/auth_state.dart';
import 'package:hamro_bhagaicha_batch35d/features/auth/presentation/view_model/auth_view_model.dart';
import 'package:mocktail/mocktail.dart';

class MockLoginUsecase extends Mock implements LoginUsecase {}

class MockRegisterUsecase extends Mock implements RegisterUsecase {}

class MockLogoutUsecase extends Mock implements LogoutUsecase {}

class MockGetCurrentUserUsecase extends Mock implements GetCurrentUserUsecase {}

class MockUpdateProfileImageUsecase extends Mock implements UpdateProfileImageUseCase {}

void main() {
  late ProviderContainer container;
  late MockLoginUsecase mockLoginUsecase;
  late MockRegisterUsecase mockRegisterUsecase;
  late MockLogoutUsecase mockLogoutUsecase;
  late MockGetCurrentUserUsecase mockGetCurrentUserUsecase;
  late MockUpdateProfileImageUsecase mockUpdateProfileImageUsecase;

  final testUser = AuthEntity(
    fullname: 'Test User',
    email: 'test@test.com',
    password: '123456',
    address: 'Kathmandu',
    phoneNumber: '9800000000',
  );

  setUpAll(() {
    registerFallbackValue(LoginUsecaseParams(email: 'fallback@test.com', password: 'fallback'));
    registerFallbackValue(RegisterUsecaseParams(
      fullName: 'fallback',
      email: 'fallback@test.com',
      password: 'fallback',
      address: 'fallback',
      phoneNumber: '0000000000',
    ));
    registerFallbackValue(GetCurrentUsecaseParams(userId: 'fallback'));
    registerFallbackValue(File('fallback.png'));
  });

  setUp(() {
    mockLoginUsecase = MockLoginUsecase();
    mockRegisterUsecase = MockRegisterUsecase();
    mockLogoutUsecase = MockLogoutUsecase();
    mockGetCurrentUserUsecase = MockGetCurrentUserUsecase();
    mockUpdateProfileImageUsecase = MockUpdateProfileImageUsecase();

    container = ProviderContainer(
      overrides: [
        loginUsecaseProvider.overrideWithValue(mockLoginUsecase),
        registerUsecaseProvider.overrideWithValue(mockRegisterUsecase),
        logoutUsecaseProvider.overrideWithValue(mockLogoutUsecase),
        getCurrentUserUsecaseProvider.overrideWithValue(mockGetCurrentUserUsecase),
        updateProfileImageUsecaseProvider.overrideWithValue(mockUpdateProfileImageUsecase),
      ],
    );
  });

  tearDown(() => container.dispose());

 //login
  group('AuthViewModel - Login', () {
    test('login success → authenticated', () async {
      when(() => mockLoginUsecase(any())).thenAnswer((_) async => Right(testUser));

      final notifier = container.read(authViewModelProvider.notifier);

      await notifier.login(email: 'test@test.com', password: '123456');

      final state = container.read(authViewModelProvider);

      expect(state.status, AuthStatus.authenticated);
      expect(state.authEntity, testUser);
    });

    test('login failure → error', () async {
      when(() => mockLoginUsecase(any())).thenAnswer(
        (_) async => Left(ApiFailure(message: 'Invalid credentials')),
      );

      final notifier = container.read(authViewModelProvider.notifier);

      await notifier.login(email: 'wrong@test.com', password: 'wrong');

      final state = container.read(authViewModelProvider);

      expect(state.status, AuthStatus.error);
      expect(state.errorMessage, 'Invalid credentials');
    });
  });

  //register
  group('AuthViewModel - Register', () {
    test('register success → registered', () async {
      when(() => mockRegisterUsecase(any())).thenAnswer((_) async => Right(testUser));

      final notifier = container.read(authViewModelProvider.notifier);

      await notifier.register(
        fullName: 'Test User',
        email: 'test@test.com',
        password: '123456',
        address: 'Kathmandu',
        phoneNumber: '9800000000',
      );

      final state = container.read(authViewModelProvider);

      expect(state.status, AuthStatus.registered);
      expect(state.authEntity, testUser);
    });

    test('register failure → error', () async {
      when(() => mockRegisterUsecase(any())).thenAnswer(
        (_) async => Left(ApiFailure(message: 'Register failed')),
      );

      final notifier = container.read(authViewModelProvider.notifier);

      await notifier.register(
        fullName: 'Test',
        email: 'test@test.com',
        password: '123456',
        address: 'KTm',
        phoneNumber: '98',
      );

      final state = container.read(authViewModelProvider);

      expect(state.status, AuthStatus.error);
      expect(state.errorMessage, 'Register failed');
    });
  });

  //get current user
  group('AuthViewModel - Get Current User', () {
    test('get current user success', () async {
      when(() => mockGetCurrentUserUsecase(any())).thenAnswer((_) async => Right(testUser));

      final notifier = container.read(authViewModelProvider.notifier);

      await notifier.getCurrentUser(userId: '1');

      final state = container.read(authViewModelProvider);

      expect(state.status, AuthStatus.currentUserLoaded);
      expect(state.authEntity, testUser);
    });
  });

  //update profile
  group('AuthViewModel - Update Profile Image', () {
    test('update profile image success', () async {
      when(() => mockUpdateProfileImageUsecase(any()))
          .thenAnswer((_) async => const Right('profile.png'));

      final notifier = container.read(authViewModelProvider.notifier);

      await notifier.updateProfileImage(File('test.png'));

      final state = container.read(authViewModelProvider);

      expect(state.status, AuthStatus.loaded);
      expect(state.uploadProfilePhotoName, 'profile.png');
    });
  });
}
