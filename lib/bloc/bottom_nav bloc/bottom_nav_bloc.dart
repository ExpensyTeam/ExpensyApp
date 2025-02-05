import 'package:expensy/bloc/bottom_nav%20bloc/bottom_nav_event.dart';
import 'package:expensy/bloc/bottom_nav%20bloc/bottom_nav_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:expensy/bloc/bottom_nav%20bloc/bottom_nav_state.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class BottomNavBloc extends Bloc<BottomNavEvent, BottomNavState> {
//   BottomNavBloc() : super(BottomNavState(0)) {
//     on<ChangeBottomNavIndex>((event, emit) {
//       emit(BottomNavState(event.index));
//     });
//   }
// }

class BottomNavBloc extends Bloc<BottomNavEvent, BottomNavState> {
  BottomNavBloc() : super(BottomNavState(selectedIndex: 0)) {
    on<ChangeBottomNavIndex>((event, emit) {
      List<int> updatedStack = List.from(state.navigationStack);

      if (event.addToStack) {
        // Avoid duplicating consecutive indices
        if (updatedStack.isEmpty || updatedStack.last != event.index) {
          updatedStack.add(event.index);
        }
      }

      emit(BottomNavState(
          selectedIndex: event.index, navigationStack: updatedStack));
    });

    on<PopNavigationStack>((event, emit) {
      if (state.navigationStack.length > 1) {
        List<int> updatedStack = List.from(state.navigationStack)..removeLast();
        emit(BottomNavState(
            selectedIndex: updatedStack.last, navigationStack: updatedStack));
      }
    });
  }
}
