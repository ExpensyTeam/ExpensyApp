import 'package:expensy/Data/iconMapping.dart';
import 'package:expensy/Data/transactions.dart';
import 'package:expensy/bloc/income%20block/income_bloc.dart';
import 'package:expensy/bloc/income%20block/income_event.dart';
import 'package:expensy/bloc/income%20block/income_state.dart';
import 'package:expensy/utils/transaction.dart';
import 'package:expensy/views/themes/colors.dart';
import 'package:expensy/views/widgets/total_expenses_screen_widgets.dart/pie_chart.dart';
// import 'package:expensy/views/widgets/total_expenses_screen_widgets.dart/pie_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

// // class IncomeCategoriesList extends StatefulWidget {

// class IncomeCategoriesList extends StatelessWidget {
//   // final ScrollController scrollController;

//   // const IncomeCategoriesList({required this.scrollController});

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<IncomeBloc, IncomeState>(
//       builder: (context, state) {
//         if (state is IncomeInitial) {
//           context.read<IncomeBloc>().add(LoadIncomes());
//           return const Center(child: CircularProgressIndicator());
//         } else if (state is IncomeLoading) {
//           return const Center(child: CircularProgressIndicator());
//         } else if (state is IncomeLoaded) {
//           return _buildContent(context, state);
//         } else if (state is IncomeError) {
//           return Center(child: Text(state.message));
//         }
//         return const SizedBox();
//       },
//     );
//   }

//   Widget _buildContent(BuildContext context, IncomeLoaded state) {
//     return Container(
//       decoration: BoxDecoration(
//         color: DarkMode.neutralColor,
//         borderRadius: const BorderRadius.only(
//           topLeft: Radius.circular(30.0),
//           topRight: Radius.circular(30.0),
//         ),
//       ),
//       child: SingleChildScrollView(
//         child: Column(
//           children: [
//             _buildSpendCategorySelector(context, state.isSpendViewSelected),
//             if (!state.isSpendViewSelected) TransactionSemiDoughnutChart(),
//             _buildSpendList(context, state.incomes),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildSpendCategorySelector(
//       BuildContext context, bool isSpendViewSelected) {
//     return Padding(
//       padding: const EdgeInsets.all(15),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           _buildCategoryButton(
//             context,
//             "Incomes",
//             isSpendViewSelected,
//             () => context.read<IncomeBloc>().add(ToggleView(true)),
//           ),
//           _buildCategoryButton(
//             context,
//             "Categories",
//             !isSpendViewSelected,
//             () => context.read<IncomeBloc>().add(ToggleView(false)),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildCategoryButton(
//     BuildContext context,
//     String label,
//     bool isSelected,
//     VoidCallback onPressed,
//   ) {
//     return AnimatedContainer(
//       duration: const Duration(milliseconds: 200),
//       width: MediaQuery.of(context).size.width * 0.45,
//       decoration: BoxDecoration(
//         border: isSelected
//             ? Border(
//                 bottom: BorderSide(
//                   color: DarkMode.buttonColor,
//                   width: 3,
//                 ),
//               )
//             : null,
//       ),
//       child: ElevatedButton(
//         onPressed: onPressed,
//         style: ElevatedButton.styleFrom(
//           backgroundColor: DarkMode.neutralColor,
//           foregroundColor: isSelected ? DarkMode.primaryColor : Colors.white,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(10),
//           ),
//         ),
//         child: Text(
//           label,
//           style: const TextStyle(color: Colors.white),
//         ),
//       ),
//     );
//   }

//   Widget _buildSpendList(BuildContext context, List<Transaction> incomes) {
//     final iconMapping = context.read<IncomeBloc>().iconMapping;

//     return ListView.builder(
//       shrinkWrap: true,
//       physics: const NeverScrollableScrollPhysics(),
//       itemCount: incomes.length,
//       itemBuilder: (context, index) {
//         final transaction = incomes[index];
//         final icon =
//             iconMapping[transaction.type] ?? Icons.attach_money_outlined;

//         return ListTile(
//           leading: Container(
//             width: 45,
//             height: 45,
//             decoration: BoxDecoration(
//               color: DarkMode.iconBackground,
//               borderRadius: BorderRadius.circular(10),
//             ),
//             child: Icon(
//               icon,
//               color: Colors.white,
//               size: 30,
//             ),
//           ),
//           contentPadding:
//               const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
//           title: Text(
//             transaction.type,
//             style: const TextStyle(color: Colors.white, fontSize: 20),
//           ),
//           subtitle: Text(
//             transaction.date,
//             style: const TextStyle(color: Colors.white70),
//           ),
//           trailing: Column(
//             crossAxisAlignment: CrossAxisAlignment.end,
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Text(
//                 '${transaction.amount} + VAT ${transaction.vat}',
//                 style: const TextStyle(color: Colors.white, fontSize: 18),
//               ),
//               Text(
//                 transaction.method,
//                 style: const TextStyle(color: Colors.white70, fontSize: 15),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }

class IncomeCategoriesList extends StatelessWidget {
  final DateTime selectedDate; // Add selectedDate to the constructor

  const IncomeCategoriesList({super.key, required this.selectedDate});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IncomeBloc, IncomeState>(
      builder: (context, state) {
        if (state is IncomeInitial) {
          context.read<IncomeBloc>().add(LoadIncomes());
          return const Center(child: CircularProgressIndicator());
        } else if (state is IncomeLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is IncomeLoaded) {
          // Filter transactions based on the selected date
          final filteredIncomes = _filterTransactions(state.incomes);
          return _buildContent(context, state, filteredIncomes);
        } else if (state is IncomeError) {
          return Center(child: Text(state.message));
        }
        return const SizedBox();
      },
    );
  }

  // Helper method to filter transactions by selected date
  List<Transaction> _filterTransactions(List<Transaction> incomes) {
    return incomes.where((transaction) {
      final transactionDate = DateFormat('d MMMM yyyy').parse(transaction.date);
      return transactionDate
          .isBefore(selectedDate.add(const Duration(days: 1)));
    }).toList();
  }

  Widget _buildContent(BuildContext context, IncomeLoaded state,
      List<Transaction> filteredIncomes) {
    return Container(
      decoration: BoxDecoration(
        color: DarkMode.neutralColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            _buildSpendCategorySelector(context, state.isSpendViewSelected),
            if (!state.isSpendViewSelected)
              TransactionSemiDoughnutChart(
                  transactions:
                      filteredIncomes), // Pass filtered transactions here
            _buildSpendList(
              context,
              filteredIncomes, // Use filtered transactions
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSpendCategorySelector(
      BuildContext context, bool isSpendViewSelected) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildCategoryButton(
            context,
            "Incomes",
            isSpendViewSelected,
            () => context.read<IncomeBloc>().add(ToggleView(true)),
          ),
          _buildCategoryButton(
            context,
            "Categories",
            !isSpendViewSelected,
            () => context.read<IncomeBloc>().add(ToggleView(false)),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryButton(
    BuildContext context,
    String label,
    bool isSelected,
    VoidCallback onPressed,
  ) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: MediaQuery.of(context).size.width * 0.45,
      decoration: BoxDecoration(
        border: isSelected
            ? Border(
                bottom: BorderSide(
                  color: DarkMode.buttonColor,
                  width: 3,
                ),
              )
            : null,
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: DarkMode.neutralColor,
          foregroundColor: isSelected ? DarkMode.primaryColor : Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(
          label,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildSpendList(BuildContext context, List<Transaction> incomes) {
    final iconMapping = context.read<IncomeBloc>().iconMapping;

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: incomes.length,
      itemBuilder: (context, index) {
        final transaction = incomes[index];
        final icon =
            iconMapping[transaction.type] ?? Icons.attach_money_outlined;

        return ListTile(
          leading: Container(
            width: 45,
            height: 45,
            decoration: BoxDecoration(
              color: DarkMode.iconBackground,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: 30,
            ),
          ),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          title: Text(
            transaction.type,
            style: const TextStyle(color: Colors.white, fontSize: 20),
          ),
          subtitle: Text(
            transaction.date,
            style: const TextStyle(color: Colors.white70),
          ),
          trailing: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '${transaction.amount} + VAT ${transaction.vat}',
                style: const TextStyle(color: Colors.white, fontSize: 18),
              ),
              Text(
                transaction.method,
                style: const TextStyle(color: Colors.white70, fontSize: 15),
              ),
            ],
          ),
        );
      },
    );
  }
}
