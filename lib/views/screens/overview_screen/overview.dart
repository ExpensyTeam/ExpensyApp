import 'package:expensy/bloc/bottom_nav%20bloc/bottom_nav_bloc.dart';
import 'package:expensy/bloc/bottom_nav%20bloc/bottom_nav_event.dart';
import 'package:expensy/bloc/bottom_nav%20bloc/bottom_nav_state.dart';
import 'package:expensy/views/screens/overview_screen/add.dart';
import 'package:expensy/views/themes/colors.dart';
import 'package:expensy/views/widgets/app_bar.dart';
import 'package:expensy/views/widgets/bottom_navigation_bar.dart';
import 'package:expensy/views/widgets/floating_action_button.dart';
import 'package:expensy/views/widgets/overview_screen_widgets/main_widget_overview.dart';
import 'package:expensy/views/widgets/overview_screen_widgets/top_widget_overview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Overview extends StatefulWidget {
  const Overview({Key? key}) : super(key: key);

  @override
  State<Overview> createState() => _OverviewState();
}

class _OverviewState extends State<Overview> {
  void _navigateToScreen(BuildContext context, int index) {
    if (index != context.read<BottomNavBloc>().state.selectedIndex) {
      context.read<BottomNavBloc>().add(ChangeBottomNavIndex(index));
      switch (index) {
        case 0:
          Navigator.pushNamed(context, '/overview');
          break;
        case 1:
          Navigator.pushNamed(context, '/saving');
          break;
        case 2:
          Navigator.pushNamed(context, '/notifications');
          break;
        case 3:
          Navigator.pushNamed(context, '/reminders');
          break;
      }
    }
  }

// Add this method to handle back navigation
  void _handleBackNavigation(BuildContext context, int previousIndex) {
    context.read<BottomNavBloc>().add(ChangeBottomNavIndex(previousIndex));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.read<BottomNavBloc>().add(PopNavigationStack());
        return true;
      },
      child: Scaffold(
        appBar: CustomizedAppBar(
          title: "Overview",
          showImage: true,
          showBackButton: false,
          backgroundColor: DarkMode.neutralColor,
          titleAlignment: MainAxisAlignment.center,
        ),
        body: Container(
          decoration: BoxDecoration(
            color: DarkMode.primaryColor,
          ),
          child: Stack(
            children: [
              TopOverview(),
              SizedBox(
                height: 15,
              ),
              DraggableScrollableSheet(
                initialChildSize: 0.68,
                minChildSize: 0.68,
                maxChildSize: 1,
                builder: (context, scrollController) {
                  return Expanded(
                      child: MainOverview(scrollController: scrollController));
                },
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButtonWidget(
          onPressed: () => {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Add()),
            )
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BlocBuilder<BottomNavBloc, BottomNavState>(
          builder: (context, state) {
            return CustomBottomNavBar(
              selectedIndex: state.selectedIndex,
              onItemTapped: (index) {
                _navigateToScreen(context, index);
              },
            );
          },
        ),
      ),
    );
  }
}
