import 'package:expenses/components/transaction_item.dart';
import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> _transactions;
  final void Function(String) onRemove;
  const TransactionList(this._transactions, this.onRemove, {super.key});

  @override
  Widget build(BuildContext context) {
    return _transactions.isEmpty
        ? LayoutBuilder(builder: (context, constraints) {
            return Container(
              alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Nem uma transação cadastrada",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    child: SizedBox(
                      height: constraints.maxHeight * .6,
                      child: Image.asset(
                        'assets/imgs/waiting.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                ],
              ),
            );
          })
        : ListView.builder(
            itemCount: _transactions.length,
            itemBuilder: (_, index) {
              final tr = _transactions[index];
              return TransactionItem(tr: tr, onRemove: onRemove);
            },
          );
  }
}
