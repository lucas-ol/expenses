import 'dart:math';

import 'package:expenses/components/chart.dart';
import 'package:expenses/components/transaction_form.dart';
import 'package:flutter/material.dart';

import 'components/transaction_list.dart';
import 'models/transaction.dart';

void main() {
  runApp(const ExpensesApp());
}

class ExpensesApp extends StatelessWidget {
  const ExpensesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: const HomePage(),
        theme: ThemeData(
            primarySwatch: Colors.pink,
            fontFamily: 'Quicksand',
            textTheme: const TextTheme(
                headline6: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Quicksand',
                    fontWeight: FontWeight.w700)),
            appBarTheme: const AppBarTheme(
              titleTextStyle: TextStyle(
                  fontSize: 18,
                  fontFamily: 'Quicksand',
                  fontWeight: FontWeight.w700),
            )));
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Transaction> _transactions = [
    Transaction(
        't1',
        'Novo Tenis de Corrida',
        310.76,
        DateTime.now().subtract(
          const Duration(days: 1),
        )),
    Transaction(
        't2',
        'Conta de luz',
        100.70,
        DateTime.now().subtract(
          const Duration(days: 2),
        )),
    Transaction(
        't3',
        'Netflix',
        50,
        DateTime.now().subtract(
          const Duration(days: 3),
        )),
    Transaction(
        't3',
        'Netflix 2',
        90,
        DateTime.now().subtract(
          const Duration(days: 4),
        )),
  ];

  List<Transaction> get _recentTransactions {
    return _transactions
        .where((tr) => tr.date.isAfter(DateTime.now().subtract(
              const Duration(days: 7),
            )))
        .toList();
  }

  _addTransaction(String title, double value) {
    final newTransaction = Transaction(
      Random().nextDouble().toString(),
      title,
      value,
      DateTime.now(),
    );

    setState(() {
      _transactions.add(newTransaction);
    });
    Navigator.of(context).pop();
  }

  _openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return TransactionForm(_addTransaction);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
            onPressed: () => _openTransactionFormModal(context),
            child: const Icon(Icons.add)),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        appBar: AppBar(
          title: const Text(
            "Despesas Pessoais",
          ),
          actions: [
            IconButton(
                onPressed: () => _openTransactionFormModal(context),
                icon: const Icon(Icons.add))
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Chart(_recentTransactions),
              TransactionList(_transactions),
            ],
          ),
        ));
  }
}
