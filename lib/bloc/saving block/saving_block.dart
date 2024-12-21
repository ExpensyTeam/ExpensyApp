import 'package:bloc/bloc.dart';
import 'package:expensy/Data/goals_data.dart';
import 'package:expensy/bloc/saving%20block/saving_event.dart';
import 'package:expensy/bloc/saving%20block/saving_state.dart';

class SavingBloc extends Bloc<SavingEvent, SavingState> {
  List<Map<String, dynamic>> _goals = goals_data;

  SavingBloc() : super(SavingInitial()) {
    on<LoadGoals>(_onLoadGoals);
    on<AddGoal>(_onAddGoal);
    on<UpdateGoalProgress>(_onUpdateGoalProgress);
  }

  Future<void> _onLoadGoals(LoadGoals event, Emitter<SavingState> emit) async {
    emit(SavingLoading());
    try {
      emit(SavingLoaded(goals: _goals));
    } catch (e) {
      emit(SavingError(e.toString()));
    }
  }

  Future<void> _onAddGoal(AddGoal event, Emitter<SavingState> emit) async {
    _goals.add(event.goal);
    emit(SavingLoaded(goals: _goals));
  }

  Future<void> _onUpdateGoalProgress(
    UpdateGoalProgress event,
    Emitter<SavingState> emit,
  ) async {
    final goal = _goals.firstWhere((g) => g["title"] == event.goalTitle);
    goal["current"] = event.progress;
    emit(SavingLoaded(goals: _goals));
  }
}
