abstract class SavingEvent {
  const SavingEvent();
}

class LoadGoals extends SavingEvent {}

class AddGoal extends SavingEvent {
  final Map<String, dynamic> goal;

  const AddGoal(this.goal);
}

class UpdateGoalProgress extends SavingEvent {
  final String goalTitle;
  final double progress;

  const UpdateGoalProgress(this.goalTitle, this.progress);
}
