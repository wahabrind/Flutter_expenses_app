import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final spendingAmount;
  final weekDay;
  final spendPctg;

  ChartBar(this.spendingAmount, this.weekDay, this.spendPctg);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constraints) {
      return Column(
        children: <Widget>[
          Container(
            height: constraints.maxHeight*0.15,
            child: FittedBox(
              child: spendingAmount > 100000
                  ? Text('\$${spendingAmount.toString().substring(0, 1)}M')
                  : Text('\$${spendingAmount.toStringAsFixed(0)}'),
            ),
          ),
          SizedBox(
            height: constraints.maxHeight*0.05,
          ),
          Container(
            height: constraints.maxHeight * 0.6,
            width: 10,
            child: Stack(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: Theme.of(context).dividerColor, width: 2),
                    color: Color.fromRGBO(220, 220, 220, 1),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                FractionallySizedBox(
                  heightFactor: spendPctg,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: constraints.maxHeight*0.05),
          Container(
            height: constraints.maxHeight*0.15,
            child: Text('$weekDay'),
            ),
        ],
      );
    });
  }
}
