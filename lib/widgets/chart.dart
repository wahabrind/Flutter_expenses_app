import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transanction.dart';
import './chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transactions> recentTransactions;
  Chart(this.recentTransactions);

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      var totalSum = 0.0;
      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year) {
          totalSum += recentTransactions[i].price;
        }
      }

      return {
        "day": DateFormat.E().format(weekDay).substring(0, 1),
        'price': totalSum
      };
    }).reversed.toList();
  }

  double get totalSpending {
    var sum = 0.0;
    final a = groupedTransactionValues.map((data) {
      return data['price'];
    }).toList();

    for (var i = 0; i < a.length; i++) {
      sum += a[i];
    }
    return sum;

    // return groupedTransactionValues.fold(0.0, (sum, item){
    //   return sum+item['price'];
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 7,
      margin: EdgeInsets.all(20),
      child: Padding(
          padding: EdgeInsets.all(10),
              child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: groupedTransactionValues.map((data) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                data['price'],
                data['day'],
                totalSpending == 0.0
                    ? 0.0
                    : (data['price'] as double) / totalSpending,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
