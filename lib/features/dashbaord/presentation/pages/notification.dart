import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamro_bhagaicha_batch35d/core/utils/snackbar_utils.dart';
import 'package:hamro_bhagaicha_batch35d/features/dashbaord/domain/entities/notification_entity.dart';
import 'package:hamro_bhagaicha_batch35d/features/dashbaord/presentation/state/notification_state.dart';
import 'package:hamro_bhagaicha_batch35d/features/dashbaord/presentation/view_model/notification_view_model.dart';

class NotificationScreen extends ConsumerStatefulWidget {
  const NotificationScreen({super.key});

  @override
  ConsumerState<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends ConsumerState<NotificationScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(notificationViewModelProvider.notifier).loadNotifications();
    });
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<NotificationState>(notificationViewModelProvider, (prev, next) {
      if (next.status == NotificationStatus.error &&
          next.errorMessage != null) {
        SnackbarUtils.showError(context, next.errorMessage!);
      }
    });

    final state = ref.watch(notificationViewModelProvider);
    final notifier = ref.read(notificationViewModelProvider.notifier);
    final bool isTablet = MediaQuery.of(context).size.width >= 600;

    final grouped = _groupNotifications(state.notifications);
    final todayNotifications = grouped.$1;
    final earlierNotifications = grouped.$2;

    return Scaffold(
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
            padding: EdgeInsets.symmetric(horizontal: isTablet ? 28 : 16),
            child: Column(
              children: [
                SizedBox(height: isTablet ? 20 : 12),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Image.asset(
                        'assets/icons/arrow icon.png',
                        height: isTablet ? 34 : 28,
                        width: isTablet ? 34 : 28,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Notifications',
                        style: TextStyle(
                          fontSize: isTablet ? 34 : 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    if (state.unreadCount > 0)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1B4332),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text(
                          '${state.unreadCount} new',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: isTablet ? 14 : 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 8),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: state.unreadCount == 0
                        ? null
                        : () => notifier.markAllAsRead(),
                    child: Text(
                      'Mark all as read',
                      style: TextStyle(
                        fontSize: isTablet ? 15 : 13,
                        color: const Color(0xFF0B3D2E),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: state.status == NotificationStatus.loading
                      ? const Center(child: CircularProgressIndicator())
                      : RefreshIndicator(
                          onRefresh: () => notifier.loadNotifications(),
                          child: state.notifications.isEmpty
                              ? ListView(
                                  children: [
                                    SizedBox(height: isTablet ? 180 : 140),
                                    _buildEmptyState(isTablet),
                                  ],
                                )
                              : ListView(
                                  children: [
                                    if (todayNotifications.isNotEmpty)
                                      _buildSectionTitle('Today', isTablet),
                                    ...todayNotifications.map(
                                      (item) => _NotificationCard(
                                        item: item,
                                        isTablet: isTablet,
                                        onTap: () =>
                                            notifier.markAsRead(item.id),
                                      ),
                                    ),
                                    if (earlierNotifications.isNotEmpty) ...[
                                      const SizedBox(height: 14),
                                      _buildSectionTitle('Earlier', isTablet),
                                      ...earlierNotifications.map(
                                        (item) => _NotificationCard(
                                          item: item,
                                          isTablet: isTablet,
                                          onTap: () =>
                                              notifier.markAsRead(item.id),
                                        ),
                                      ),
                                    ],
                                    const SizedBox(height: 20),
                                  ],
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

  (List<NotificationEntity>, List<NotificationEntity>) _groupNotifications(
    List<NotificationEntity> notifications,
  ) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    final todayItems = <NotificationEntity>[];
    final earlierItems = <NotificationEntity>[];

    for (final item in notifications) {
      final itemDate = DateTime(
        item.createdAt.year,
        item.createdAt.month,
        item.createdAt.day,
      );

      if (itemDate == today) {
        todayItems.add(item);
      } else {
        earlierItems.add(item);
      }
    }

    return (todayItems, earlierItems);
  }

  Widget _buildSectionTitle(String title, bool isTablet) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: TextStyle(
            fontSize: isTablet ? 19 : 16,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF0F2A1E),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState(bool isTablet) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.7),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.notifications_none_rounded,
            size: isTablet ? 64 : 54,
            color: const Color(0xFF1B4332),
          ),
          const SizedBox(height: 12),
          Text(
            'No notifications yet',
            style: TextStyle(
              fontSize: isTablet ? 20 : 17,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF0F2A1E),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'We will notify you about orders, reminders and updates.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: isTablet ? 15 : 13,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}

class _NotificationCard extends StatelessWidget {
  final NotificationEntity item;
  final bool isTablet;
  final VoidCallback onTap;

  const _NotificationCard({
    required this.item,
    required this.isTablet,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: EdgeInsets.all(isTablet ? 16 : 12),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: item.isRead ? 0.82 : 0.95),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: item.isRead
                ? const Color(0xFFD8E4D2)
                : const Color(0xFF2D6A4F),
            width: item.isRead ? 1 : 1.3,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xFFD8F3DC),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                _iconForType(item.type),
                color: const Color(0xFF1B4332),
                size: 22,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          item.title,
                          style: TextStyle(
                            fontSize: isTablet ? 18 : 15,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF081C15),
                          ),
                        ),
                      ),
                      if (!item.isRead)
                        Container(
                          width: 9,
                          height: 9,
                          decoration: const BoxDecoration(
                            color: Color(0xFF2D6A4F),
                            shape: BoxShape.circle,
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item.message,
                    style: TextStyle(
                      fontSize: isTablet ? 15 : 13,
                      color: Colors.black87,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _timeAgo(item.createdAt),
                    style: TextStyle(
                      fontSize: isTablet ? 13 : 11,
                      color: const Color(0xFF3A5A40),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _iconForType(String type) {
    switch (type.toLowerCase()) {
      case 'order':
        return Icons.shopping_bag_outlined;
      case 'delivery':
        return Icons.local_shipping_outlined;
      case 'security':
        return Icons.lock_outline;
      case 'reminder':
        return Icons.spa_outlined;
      default:
        return Icons.notifications_outlined;
    }
  }

  String _timeAgo(DateTime dateTime) {
    final difference = DateTime.now().difference(dateTime);

    if (difference.inMinutes < 1) return 'Just now';
    if (difference.inMinutes < 60) return '${difference.inMinutes} min ago';
    if (difference.inHours < 24) return '${difference.inHours} hr ago';
    if (difference.inDays == 1) return 'Yesterday';
    return '${difference.inDays} days ago';
  }
}
