import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function newTx;
  NewTransaction(this.newTx);

  @override
  _NewTransactionState createState() {
   return _NewTransactionState();
  }
}

class _NewTransactionState extends State<NewTransaction> {
  final nameController = TextEditingController();
  final priceController = TextEditingController();
  DateTime currentDate;

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((selectedDate) {
      if (selectedDate == null) {
        return;
      } else {
        setState(() {
          currentDate = selectedDate;
        });
      }
    });
  }

  addTransaction() {
    final newentryName = nameController.text;
    final newentryPrice = double.parse(priceController.text);

    if (newentryName.isEmpty || newentryPrice <= 0 || currentDate == null) {
      return;
    }

    widget.newTx(newentryName, newentryPrice, currentDate);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 10,
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            right: 10,
            left: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: "Name"),
                onSubmitted: (_) => addTransaction(),
              ),
              TextField(
                controller: priceController,
                decoration: InputDecoration(labelText: "Price"),
                onSubmitted: (_) => addTransaction(),
                keyboardType: TextInputType.number,
              ),
              Container(
                height: 70,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(currentDate == null
                          ? "No Date Choosen"
                          : 'Date Choosen: ${DateFormat.yMd().format(currentDate)}'),
                    ),
                    FlatButton(
                      onPressed: _presentDatePicker,
                      child: Text(
                        'Add Date',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      textColor: Theme.of(context).primaryColor,
                    ),
                  ],
                ),
              ),
              RaisedButton(
                onPressed: addTransaction,
                child: Text('Add Transaction'),
                color: Theme.of(context).primaryColor,
                textColor: Theme.of(context).textTheme.button.color,
              )
            ],
          ),
        ),
      ),
    );
  }
}
