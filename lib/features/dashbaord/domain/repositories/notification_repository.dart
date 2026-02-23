import 'package:dartz/dartz.dart';
import 'package:hamro_bhagaicha_batch35d/core/error/failure.dart';
import 'package:hamro_bhagaicha_batch35d/features/dashbaord/domain/entities/notification_entity.dart';

abstract interface class INotificationRepository {
  Future<Either<Failure, List<NotificationEntity>>> getNotifications();
  Future<Either<Failure, bool>> markAllAsRead();
  Future<Either<Failure, bool>> markAsRead(String notificationId);
}
