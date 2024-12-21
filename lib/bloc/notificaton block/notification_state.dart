import 'package:expensy/utils/notification_item.dart';

abstract class NotificationState {
  const NotificationState();
}

class NotificationInitial extends NotificationState {}

class NotificationLoading extends NotificationState {}

class NotificationLoaded extends NotificationState {
  final List<NotificationItem> notifications;
  final int selectedIndex;

  const NotificationLoaded({
    required this.notifications,
    required this.selectedIndex,
  });
}

class NotificationError extends NotificationState {
  final String message;

  const NotificationError(this.message);
}
