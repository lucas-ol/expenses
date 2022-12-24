import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> _transactions;

  const TransactionList(this._transactions, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 300,
        child: _transactions.isEmpty
            ? Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Nem uma transação cadastrada",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    SizedBox(
                      height: 200,
                      child: Image.asset(
                        'assets/imgs/waiting.png',
                        fit: BoxFit.cover,
                      ),
                    )
                  ],
                ),
              )
            : ListView.builder(
                itemCount: _transactions.length,
                itemBuilder: (context, index) {
                  final tr = _transactions[index];
                  return Card(
                    elevation: 5,
                    margin:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                    child: ListTile(
                      subtitle: Text(DateFormat("d MMM y").format(tr.date)),
                      title: Text(
                        tr.title,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      leading: CircleAvatar(
                        radius: 30,
                        child: Padding(
                            padding: const EdgeInsets.all(6),
                            child: FittedBox(child: Text("R\$${tr.value}"))),
                      ),
                    ),
                  );
                }));
  }
}
