import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamro_bhagaicha_batch35d/core/error/failure.dart';
import 'package:hamro_bhagaicha_batch35d/core/usecases/app.usecase.dart';
import 'package:hamro_bhagaicha_batch35d/features/dashbaord/data/repositories/notification_repository_impl.dart';
import 'package:hamro_bhagaicha_batch35d/features/dashbaord/domain/repositories/notification_repository.dart';

final markAllNotificationsReadUsecaseProvider =
    Provider<MarkAllNotificationsReadUsecase>((ref) {
      final repository = ref.read(notificationRepositoryProvider);
      return MarkAllNotificationsReadUsecase(repository);
    });

class MarkAllNotificationsReadUsecase implements UsecaseWithoutParams<bool> {
  final INotificationRepository _repository;

  MarkAllNotificationsReadUsecase(this._repository);

  @override
  Future<Either<Failure, bool>> call() {
    return _repository.markAllAsRead();
  }
}
