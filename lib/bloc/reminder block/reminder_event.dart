abstract class ReminderEvent {
  const ReminderEvent();
}

class LoadReminders extends ReminderEvent {}

class NavigateToScreen extends ReminderEvent {
  final int selectedIndex;

  const NavigateToScreen(this.selectedIndex);
}
