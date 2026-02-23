import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamro_bhagaicha_batch35d/core/error/failure.dart';
import 'package:hamro_bhagaicha_batch35d/core/services/connectivity/network_info.dart';
import 'package:hamro_bhagaicha_batch35d/features/dashbaord/data/datasource/notification_remote_datasource.dart';
import 'package:hamro_bhagaicha_batch35d/features/dashbaord/domain/entities/notification_entity.dart';
import 'package:hamro_bhagaicha_batch35d/features/dashbaord/domain/repositories/notification_repository.dart';

final notificationRepositoryProvider = Provider<INotificationRepository>((ref) {
  final remote = ref.read(notificationRemoteDatasourceProvider);
  final networkInfo = ref.read(networkInfoProvider);

  return NotificationRepositoryImpl(remote, networkInfo);
});

class NotificationRepositoryImpl implements INotificationRepository {
  final INotificationRemoteDatasource _remoteDatasource;
  final NetworkInfo _networkInfo;

  NotificationRepositoryImpl(this._remoteDatasource, this._networkInfo);

  @override
  Future<Either<Failure, List<NotificationEntity>>> getNotifications() async {
    if (!await _networkInfo.isConnected) {
      return const Left(ApiFailure(message: 'No internet connection'));
    }

    try {
      final result = await _remoteDatasource.getNotifications();
      return Right(result.map((e) => e.toEntity()).toList());
    } on DioException catch (e) {
      return Left(
        ApiFailure(
          message:
              e.response?.data?['message']?.toString() ??
              'Failed to fetch notifications',
          statusCode: e.response?.statusCode,
        ),
      );
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> markAllAsRead() async {
    if (!await _networkInfo.isConnected) {
      return const Left(ApiFailure(message: 'No internet connection'));
    }

    try {
      await _remoteDatasource.markAllAsRead();
      return const Right(true);
    } on DioException catch (e) {
      return Left(
        ApiFailure(
          message:
              e.response?.data?['message']?.toString() ??
              'Failed to mark notifications as read',
          statusCode: e.response?.statusCode,
        ),
      );
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> markAsRead(String notificationId) async {
    if (!await _networkInfo.isConnected) {
      return const Left(ApiFailure(message: 'No internet connection'));
    }

    try {
      await _remoteDatasource.markAsRead(notificationId);
      return const Right(true);
    } on DioException catch (e) {
      return Left(
        ApiFailure(
          message:
              e.response?.data?['message']?.toString() ??
              'Failed to update notification',
          statusCode: e.response?.statusCode,
        ),
      );
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }
}
