abstract class SavingState {
  const SavingState();
}

class SavingInitial extends SavingState {}

class SavingLoading extends SavingState {}

class SavingLoaded extends SavingState {
  final List<Map<String, dynamic>> goals;

  const SavingLoaded({required this.goals});
}

class SavingError extends SavingState {
  final String message;

  const SavingError(this.message);
}
