import 'package:bloc/bloc.dart';
import 'package:expensy/Data/reminders.dart';
import 'package:expensy/bloc/reminder%20block/reminder_event.dart';
import 'package:expensy/bloc/reminder%20block/reminder_state.dart';
import 'package:expensy/utils/reminder_item.dart';

class ReminderBloc extends Bloc<ReminderEvent, ReminderState> {
  final List<ReminderItem> _reminders = reminders_data;

  ReminderBloc() : super(ReminderInitial()) {
    on<LoadReminders>(_onLoadReminders);
    on<NavigateToScreen>(_onNavigateToScreen);
  }

  Future<void> _onLoadReminders(
    LoadReminders event,
    Emitter<ReminderState> emit,
  ) async {
    emit(ReminderLoading());
    try {
      emit(ReminderLoaded(reminders: _reminders, selectedIndex: 3));
    } catch (e) {
      emit(ReminderError(e.toString()));
    }
  }

  Future<void> _onNavigateToScreen(
    NavigateToScreen event,
    Emitter<ReminderState> emit,
  ) async {
    final currentState = state;
    if (currentState is ReminderLoaded) {
      emit(ReminderLoaded(
        reminders: currentState.reminders,
        selectedIndex: event.selectedIndex,
      ));
    }
  }
}
