// abstract class BottomNavEvent {}

// class ChangeBottomNavIndex extends BottomNavEvent {
//   final int index;
//   ChangeBottomNavIndex(this.index);
// }

abstract class BottomNavEvent {}

class ChangeBottomNavIndex extends BottomNavEvent {
  final int index;
  final bool addToStack;

  ChangeBottomNavIndex(this.index, {this.addToStack = true});
}

class PopNavigationStack extends BottomNavEvent {}
