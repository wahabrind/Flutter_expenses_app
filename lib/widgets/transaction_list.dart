import 'package:expenses/models/transanction.dart';
import 'package:flutter/material.dart';
import "./transactionitem.dart";

class TransactionList extends StatelessWidget {
  final List<Transactions> transactions;
  final Function deleteTransaction;
  TransactionList(this.transactions, this.deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(
            builder: (ctx, constraints) {
              return Column(
                children: <Widget>[
                  Text(
                    'eMpty List',
                    style: Theme.of(context).textTheme.title,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: constraints.maxHeight * 0.8,
                    child: Image.asset(
                      './assets/images/pic1.jpg',
                      fit: BoxFit.cover,
                    ),
                  )
                ],
              );
            },
          )
        : ListView(
            children: transactions.map((tx) {
              return TransactionItem(
                  key: ValueKey(tx.id),
                  transaction: tx,
                  deleteTransaction: deleteTransaction);
            }).toList(),
          );
  }
}
