import 'package:expensy/utils/reminder_item.dart';

abstract class ReminderState {
  const ReminderState();
}

class ReminderInitial extends ReminderState {}

class ReminderLoading extends ReminderState {}

class ReminderLoaded extends ReminderState {
  final List<ReminderItem> reminders;
  final int selectedIndex;

  const ReminderLoaded({
    required this.reminders,
    required this.selectedIndex,
  });
}

class ReminderError extends ReminderState {
  final String message;

  const ReminderError(this.message);
}
