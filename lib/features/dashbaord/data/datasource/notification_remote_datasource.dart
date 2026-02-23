import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamro_bhagaicha_batch35d/core/api/api_client.dart';
import 'package:hamro_bhagaicha_batch35d/core/api/api_endpoint.dart';
import 'package:hamro_bhagaicha_batch35d/features/dashbaord/data/model/notification_api_model.dart';

abstract interface class INotificationRemoteDatasource {
  Future<List<NotificationApiModel>> getNotifications();
  Future<void> markAllAsRead();
  Future<void> markAsRead(String notificationId);
}

final notificationRemoteDatasourceProvider =
    Provider<INotificationRemoteDatasource>((ref) {
      final apiClient = ref.read(apiClientProvider);
      return NotificationRemoteDatasource(apiClient);
    });

class NotificationRemoteDatasource implements INotificationRemoteDatasource {
  final ApiClient _apiClient;

  NotificationRemoteDatasource(this._apiClient);

  @override
  Future<List<NotificationApiModel>> getNotifications() async {
    final response = await _apiClient.get(ApiEndpoints.notifications);
    final dynamic responseData = response.data;

    final dynamic listData = responseData is Map<String, dynamic>
        ? responseData['data']
        : responseData;

    if (listData is! List) {
      return [];
    }

    return listData
        .whereType<Map<String, dynamic>>()
        .map(NotificationApiModel.fromJson)
        .toList();
  }

  @override
  Future<void> markAllAsRead() async {
    await _apiClient.put(ApiEndpoints.markAllNotificationsRead);
  }

  @override
  Future<void> markAsRead(String notificationId) async {
    await _apiClient.put(ApiEndpoints.markNotificationRead(notificationId));
  }
}
