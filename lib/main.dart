import 'package:expensy/bloc/expense%20block/expense_bloc.dart';
import 'package:expensy/bloc/income%20block/income_bloc.dart';
import 'package:expensy/bloc/notificaton%20block/notification_bloc.dart';
import 'package:expensy/bloc/reminder%20block/reminder_bloc.dart';
import 'package:expensy/bloc/saving%20block/saving_block.dart';
import 'package:expensy/bloc/transaction%20block/transaction_bloc.dart';
import 'package:expensy/views/screens/overview_screen/overview.dart';
import 'package:expensy/views/screens/savings_screen/savings.dart';
import 'package:flutter/material.dart';
import 'views/screens/onboarding_screen/onboarding_screen.dart';
import 'views/screens/notifications_screen/notifications_screen.dart';
import 'package:expensy/views/screens/reminder_screen/reminder_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Import your transaction bloc
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://warkuczspselbodswknb.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Indhcmt1Y3pzcHNlbGJvZHN3a25iIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzQ2MjEwNDgsImV4cCI6MjA1MDE5NzA0OH0.8GcEKSxc_X5ZO2erDj0ivGiWmwqcRt8hNrCgyk6HBaw',
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => TransactionBloc()),
        BlocProvider(create: (context) => IncomeBloc()),
        BlocProvider(create: (context) => ExpenseBloc()),
        BlocProvider(create: (context) => SavingBloc()),
        BlocProvider(create: (context) => NotificationBloc()),
        BlocProvider(create: (context) => ReminderBloc()),
        // Add other BLoCs here if needed
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/home': (context) => const Overview(),
          '/saving': (context) => Savings(),
          '/notifications': (context) => const NotificationsScreen(),
          '/reminders': (context) => const ReminderList(),
        },
        title: 'Onboarding & Login',
        theme: ThemeData.dark(),
        home: const OnboardingScreen(),
      ),
    );
  }
}
