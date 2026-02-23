import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamro_bhagaicha_batch35d/core/error/failure.dart';
import 'package:hamro_bhagaicha_batch35d/core/usecases/app.usecase.dart';
import 'package:hamro_bhagaicha_batch35d/features/dashbaord/data/repositories/notification_repository_impl.dart';
import 'package:hamro_bhagaicha_batch35d/features/dashbaord/domain/entities/notification_entity.dart';
import 'package:hamro_bhagaicha_batch35d/features/dashbaord/domain/repositories/notification_repository.dart';

final getNotificationsUsecaseProvider = Provider<GetNotificationsUsecase>((
  ref,
) {
  final repository = ref.read(notificationRepositoryProvider);
  return GetNotificationsUsecase(repository);
});

class GetNotificationsUsecase
    implements UsecaseWithoutParams<List<NotificationEntity>> {
  final INotificationRepository _repository;

  GetNotificationsUsecase(this._repository);

  @override
  Future<Either<Failure, List<NotificationEntity>>> call() {
    return _repository.getNotifications();
  }
}
