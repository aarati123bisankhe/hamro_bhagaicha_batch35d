import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamro_bhagaicha_batch35d/core/error/failure.dart';
import 'package:hamro_bhagaicha_batch35d/core/usecases/app.usecase.dart';
import 'package:hamro_bhagaicha_batch35d/features/dashbaord/data/repositories/notification_repository_impl.dart';
import 'package:hamro_bhagaicha_batch35d/features/dashbaord/domain/repositories/notification_repository.dart';

class MarkNotificationReadParams extends Equatable {
  final String notificationId;

  const MarkNotificationReadParams(this.notificationId);

  @override
  List<Object?> get props => [notificationId];
}

final markNotificationReadUsecaseProvider =
    Provider<MarkNotificationReadUsecase>((ref) {
      final repository = ref.read(notificationRepositoryProvider);
      return MarkNotificationReadUsecase(repository);
    });

class MarkNotificationReadUsecase
    implements UsecaseWithParams<bool, MarkNotificationReadParams> {
  final INotificationRepository _repository;

  MarkNotificationReadUsecase(this._repository);

  @override
  Future<Either<Failure, bool>> call(MarkNotificationReadParams params) {
    return _repository.markAsRead(params.notificationId);
  }
}
