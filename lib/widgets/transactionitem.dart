import 'dart:math';

import "package:flutter/material.dart";
import "../models/transanction.dart";
import 'package:intl/intl.dart';

class TransactionItem extends StatefulWidget {
  const TransactionItem({
    Key key,
    @required this.transaction,
    @required this.deleteTransaction,
  }) : super(key: key);

  final Transactions transaction;
  final Function deleteTransaction;

  @override
  _TransactionItemState createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
  Color _bgColor;
  @override
  void initState() {
    const _randomColors = [Colors.red, Colors.blue, Colors.green];
    _bgColor = _randomColors[Random().nextInt(3)];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: _bgColor,
          radius: 35,
          child: Padding(
            padding: EdgeInsets.all(6),
            child: FittedBox(
              child: widget.transaction.price > 100000
                  ? Text(
                      '${widget.transaction.price.toString().substring(0, 1)}M')
                  : Text('${widget.transaction.price}'),
            ),
          ),
        ),
        title: Text(
          '${widget.transaction.name}',
          style: Theme.of(context).textTheme.title,
        ),
        subtitle: Text(
          DateFormat.yMMMd().format(widget.transaction.date),
        ),
        trailing: IconButton(
            icon: Icon(Icons.delete),
            color: Theme.of(context).errorColor,
            onPressed: () => widget.deleteTransaction(widget.transaction.id)),
      ),
    );
  }
}
