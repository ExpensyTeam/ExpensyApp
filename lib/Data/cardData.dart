import 'package:expensy/utils/top_view_card.dart';
import 'package:flutter/material.dart';

final List<CardData> cardDataList_data = [
  CardData(
    name: "Total Income",
    amount: "\$1,289.38",
    icon: Icons.account_balance_wallet_outlined,
  ),
  CardData(
    name: "Total Expenses",
    amount: "\$298.16",
    icon: Icons.account_balance_wallet_outlined,
  ),
  CardData(
    name: "Total Saving",
    amount: "\$112.23",
    icon: Icons.account_balance_wallet_outlined,
  ),
  CardData(
    name: "Investments",
    amount: "\$1,000.00",
    icon: Icons.account_balance_wallet_outlined,
  ),
];

final List<CardData> addCardDataList_data = [
  CardData(
    name: "Add Income",
    amount: "",
    icon: Icons.account_balance_wallet_outlined,
  ),
  CardData(
    name: "Add Expense",
    amount: "",
    icon: Icons.account_balance_wallet_outlined,
  ),
];
