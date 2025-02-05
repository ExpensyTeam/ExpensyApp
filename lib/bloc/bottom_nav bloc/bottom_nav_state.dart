// class BottomNavState {
//   final int selectedIndex;
//   BottomNavState(this.selectedIndex);
// }

class BottomNavState {
  final int selectedIndex;
  final List<int> navigationStack;

  BottomNavState({required this.selectedIndex, List<int>? navigationStack})
      : navigationStack = navigationStack ?? [0];
}
