abstract class ExpenseEvent {
  const ExpenseEvent();
}

class LoadExpenses extends ExpenseEvent {}

class ToggleView extends ExpenseEvent {
  final bool isSpendView;

  const ToggleView(this.isSpendView);
}
