abstract class NotificationEvent {
  const NotificationEvent();
}

class LoadNotifications extends NotificationEvent {}

class UpdateSelectedIndex extends NotificationEvent {
  final int selectedIndex;

  const UpdateSelectedIndex(this.selectedIndex);
}
