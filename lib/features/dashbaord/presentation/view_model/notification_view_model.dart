import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamro_bhagaicha_batch35d/features/dashbaord/domain/entities/notification_entity.dart';
import 'package:hamro_bhagaicha_batch35d/features/dashbaord/domain/usecase/get_notifications_usecase.dart';
import 'package:hamro_bhagaicha_batch35d/features/dashbaord/domain/usecase/mark_all_notifications_read_usecase.dart';
import 'package:hamro_bhagaicha_batch35d/features/dashbaord/domain/usecase/mark_notification_read_usecase.dart';
import 'package:hamro_bhagaicha_batch35d/features/dashbaord/presentation/state/notification_state.dart';

final notificationViewModelProvider =
    NotifierProvider<NotificationViewModel, NotificationState>(
      NotificationViewModel.new,
    );

class NotificationViewModel extends Notifier<NotificationState> {
  late final GetNotificationsUsecase _getNotificationsUsecase;
  late final MarkAllNotificationsReadUsecase _markAllNotificationsReadUsecase;
  late final MarkNotificationReadUsecase _markNotificationReadUsecase;

  @override
  NotificationState build() {
    _getNotificationsUsecase = ref.read(getNotificationsUsecaseProvider);
    _markAllNotificationsReadUsecase = ref.read(
      markAllNotificationsReadUsecaseProvider,
    );
    _markNotificationReadUsecase = ref.read(
      markNotificationReadUsecaseProvider,
    );

    return const NotificationState();
  }

  Future<void> loadNotifications() async {
    state = state.copyWith(
      status: NotificationStatus.loading,
      errorMessage: null,
    );

    final result = await _getNotificationsUsecase();

    result.fold(
      (failure) {
        state = state.copyWith(
          status: NotificationStatus.error,
          errorMessage: failure.message,
        );
      },
      (notifications) {
        final resolvedNotifications = notifications.isEmpty
            ? _defaultNotifications()
            : notifications;

        resolvedNotifications.sort(
          (a, b) => b.createdAt.compareTo(a.createdAt),
        );
        state = state.copyWith(
          status: NotificationStatus.loaded,
          notifications: resolvedNotifications,
          errorMessage: null,
        );
      },
    );
  }

  List<NotificationEntity> _defaultNotifications() {
    final now = DateTime.now();
    return [
      NotificationEntity(
        id: 'local-order-$now',
        title: 'Order Update',
        message: 'Your recent order has been placed successfully.',
        type: 'order',
        createdAt: now.subtract(const Duration(minutes: 15)),
        isRead: false,
      ),
      NotificationEntity(
        id: 'local-reminder-$now',
        title: 'Plant Care Reminder',
        message: 'Water your indoor plants today to keep them healthy.',
        type: 'reminder',
        createdAt: now.subtract(const Duration(hours: 2)),
        isRead: false,
      ),
    ];
  }

  Future<void> markAllAsRead() async {
    if (state.notifications.isEmpty || state.unreadCount == 0) {
      return;
    }

    state = state.copyWith(
      status: NotificationStatus.updating,
      errorMessage: null,
    );

    final result = await _markAllNotificationsReadUsecase();

    result.fold(
      (failure) {
        state = state.copyWith(
          status: NotificationStatus.error,
          errorMessage: failure.message,
        );
      },
      (_) {
        final updated = state.notifications
            .map((e) => e.copyWith(isRead: true))
            .toList(growable: false);

        state = state.copyWith(
          status: NotificationStatus.loaded,
          notifications: updated,
          errorMessage: null,
        );
      },
    );
  }

  Future<void> markAsRead(String notificationId) async {
    final notificationIndex = state.notifications.indexWhere(
      (e) => e.id == notificationId,
    );
    if (notificationIndex == -1 ||
        state.notifications[notificationIndex].isRead) {
      return;
    }

    final result = await _markNotificationReadUsecase(
      MarkNotificationReadParams(notificationId),
    );

    result.fold(
      (failure) {
        state = state.copyWith(
          status: NotificationStatus.error,
          errorMessage: failure.message,
        );
      },
      (_) {
        final updated = state.notifications
            .map((e) => e.id == notificationId ? e.copyWith(isRead: true) : e)
            .toList(growable: false);

        state = state.copyWith(
          status: NotificationStatus.loaded,
          notifications: updated,
          errorMessage: null,
        );
      },
    );
  }
}
