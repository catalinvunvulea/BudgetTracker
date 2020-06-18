import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
 
 final String label;
 final double spendingAmount;
 final double percentageOfTotal;

 ChartBar(this.label, this.spendingAmount, this.percentageOfTotal); 

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Text("${spendingAmount.toStringAsFixed(0)}"), //toStringAsFixed(0) to avoid showing decimals
      SizedBox(height: 4),
    ],);

  }
}