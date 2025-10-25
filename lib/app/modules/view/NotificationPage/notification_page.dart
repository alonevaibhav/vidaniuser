import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../apputils/services/Notification/notification_service.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notification Service Demo'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildNotificationButton(
              'Simple Notification',
              () => NotificationService.instance.showNotification(
                title: 'Simple Notification',
                body: 'This is a simple notification!',
              ),
              Colors.blue,
            ),
            SizedBox(height: 12),
            _buildNotificationButton(
              'High Priority Notification',
              () => NotificationService.instance.showNotification(
                title: 'Important!',
                body: 'This is a high priority notification!',
                priority: NotificationPriority.high,
              ),
              Colors.red,
            ),
            SizedBox(height: 12),
            _buildNotificationButton(
              'Low Priority Notification',
              () => NotificationService.instance.showNotification(
                title: 'Low Priority',
                body: 'This is a low priority notification.',
                priority: NotificationPriority.low,
              ),
              Colors.grey,
            ),
            SizedBox(height: 12),
            _buildNotificationButton(
              'Big Text Notification',
              () => NotificationService.instance.showBigTextNotification(
                title: 'Big Text',
                body: 'Tap to expand...',
                bigText:
                    'This is a very long text that will be displayed in an expanded notification. '
                    'You can put a lot of content here and it will be properly formatted in the notification panel.',
              ),
              Colors.green,
            ),
            SizedBox(height: 12),
            _buildNotificationButton(
              'Progress Notification',
              () => NotificationService.instance.showProgressNotification(
                title: 'Downloading...',
                progress: 65,
              ),
              Colors.orange,
            ),
            SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: _buildNotificationButton(
                    'Cancel All',
                    () => NotificationService.instance.cancelAllNotifications(),
                    Colors.red[300]!,
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: _buildNotificationButton('Check Pending', () async {
                    final pending = await NotificationService.instance
                        .getPendingNotifications();
                    Get.snackbar(
                      'Pending Notifications',
                      '${pending.length} notifications pending',
                      snackPosition: SnackPosition.BOTTOM,
                    );
                  }, Colors.blue[300]!),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationButton(
    String title,
    VoidCallback onPressed,
    Color color,
  ) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
        padding: EdgeInsets.symmetric(vertical: 12),
      ),
      child: Text(title, style: TextStyle(fontSize: 16)),
    );
  }
}
