import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double percentageOfTotal;

  ChartBar(this.label, this.spendingAmount, this.percentageOfTotal);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context,
            constraints) //used to calculate the size of this widget so we can give custom sizez to the elements inside
        {
      return Column(
        children: <Widget>[
          Container(
            height: constraints.maxHeight * 0.12,
            child: FittedBox(
              //forces his child to shrink if the value is too high
              child: Text("£ ${spendingAmount.toStringAsFixed(0)}"),
            ),
          ), //toStringAsFixed(0) to avoid showing decimals
          SizedBox(height: constraints.maxHeight * 0.05),
          Container(
            height: constraints.maxHeight *
                0.6, //constrains element is taken from LayoutBuilder
            width: 10,
            child: Stack(
              //allows you to place elements on top of each other
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1),
                    color: Color.fromRGBO(220, 220, 220, 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                FractionallySizedBox(
                  heightFactor: percentageOfTotal,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ), //height factor is between 0 and 1 (0% - 100%)
              ],
            ),
          ),
          SizedBox(
            height: constraints.maxHeight * 0.05,
          ),
          Container(
            height: constraints.maxHeight * 0.12,
            child: FittedBox(
              child: Text(
                label,
              ),
            ),
          )
        ],
      );
    });
  }
}
