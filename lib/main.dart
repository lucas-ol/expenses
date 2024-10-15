import 'dart:io';
import 'dart:math';

import 'package:expenses/components/chart.dart';
import 'package:expenses/components/transaction_form.dart';
import 'package:flutter/cupertino.dart';
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
    //SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MaterialApp(
        home: const HomePage(),
        theme: ThemeData(
            primarySwatch: Colors.pink,
            fontFamily: 'Quicksand',
            textTheme: const TextTheme(
                titleLarge: TextStyle(
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
  final List<Transaction> _transactions = [];
  bool showChart = false;
  List<Transaction> get _recentTransactions {
    return _transactions
        .where((tr) => tr.date.isAfter(DateTime.now().subtract(
              const Duration(days: 7),
            )))
        .toList();
  }

  void _removeTransaction(String id) {
    setState(() {
      _transactions.removeWhere((tr) => tr.id == id);
    });
  }

  void _addTransaction(String title, double value, DateTime date) {
    final newTransaction = Transaction(
      Random().nextDouble().toString(),
      title,
      value,
      date,
    );

    setState(() {
      _transactions.add(newTransaction);
    });
    Navigator.of(context).pop();
  }

  _openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (_) {
          return Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: TransactionForm(_addTransaction));
        });
  }

  Widget _getIconButton(
      {required IconData icon, required Function() onPressed}) {
    return Platform.isIOS
        ? GestureDetector(
            onTap: onPressed,
            child: Icon(icon),
          )
        : IconButton(
            onPressed: onPressed,
            icon: Icon(icon),
          );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandscap = mediaQuery.orientation == Orientation.landscape;
    final actions = [
      if (isLandscap)
        _getIconButton(
          onPressed: () => setState(() {
            showChart = !showChart;
          }),
          icon: showChart ? Icons.list : Icons.show_chart,
        ),
      _getIconButton(
        onPressed: () => _openTransactionFormModal(context),
        icon: Platform.isIOS ? CupertinoIcons.add : Icons.add,
      )
    ];

    final PreferredSizeWidget appBar = AppBar(
      title: const Text(
        "Despesas Pessoais",
      ),
      actions: actions,
    );
    final avalibeHeight = mediaQuery.size.height -
        appBar.preferredSize.height -
        mediaQuery.padding.top;
    final bodyPage = SafeArea(
      child: Column(
        children: [
          if (showChart || !isLandscap)
            SizedBox(
              height: avalibeHeight * (isLandscap ? 1 : .3),
              child: Chart(_recentTransactions),
            ),
          if (!showChart || !isLandscap)
            SizedBox(
              height: avalibeHeight * (isLandscap ? 1 : .7),
              child: TransactionList(_transactions, _removeTransaction),
            ),
        ],
      ),
    );

    return Platform.isIOS
        ? CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
              middle: const Text("Despesas Pessoais"),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: actions,
              ),
            ),
            child: bodyPage,
          )
        : Scaffold(
            floatingActionButton: FloatingActionButton(
                onPressed: () => _openTransactionFormModal(context),
                child: const Icon(Icons.add)),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            appBar: appBar,
            body: bodyPage,
          );
  }
}
