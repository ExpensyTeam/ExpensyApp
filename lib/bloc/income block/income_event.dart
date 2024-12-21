abstract class IncomeEvent {
  const IncomeEvent();
}

class LoadIncomes extends IncomeEvent {}

class ToggleView extends IncomeEvent {
  final bool isSpendView;

  const ToggleView(this.isSpendView);
}
