import 'package:expensy/Data/notifications.dart';
import 'package:expensy/bloc/notificaton%20block/notification_event.dart';
import 'package:expensy/bloc/notificaton%20block/notification_state.dart';
import 'package:expensy/utils/notification_item.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final List<NotificationItem> _allNotifications = notifications_data;

  NotificationBloc() : super(NotificationInitial()) {
    on<LoadNotifications>(_onLoadNotifications);
    on<UpdateSelectedIndex>(_onUpdateSelectedIndex);
  }

  Future<void> _onLoadNotifications(
    LoadNotifications event,
    Emitter<NotificationState> emit,
  ) async {
    emit(NotificationLoading());
    try {
      emit(NotificationLoaded(
          notifications: _allNotifications, selectedIndex: 2));
    } catch (e) {
      emit(NotificationError(e.toString()));
    }
  }

  Future<void> _onUpdateSelectedIndex(
    UpdateSelectedIndex event,
    Emitter<NotificationState> emit,
  ) async {
    final currentState = state;
    if (currentState is NotificationLoaded) {
      emit(NotificationLoaded(
        notifications: currentState.notifications,
        selectedIndex: event.selectedIndex,
      ));
    }
  }
}
