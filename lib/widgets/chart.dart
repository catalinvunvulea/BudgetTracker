import 'package:flutter/material.dart';
import './widgets/transaction_list.dart';

class Chart extends StatelessWidget {

final List<Transaction> recentTransactions;

Chart(this.recentTransactions)

 List<Map<String, Object>> get groupedTransactionValues {
  return List.generate(7, (index) {
    return {'day': 'M', 'amount': 9.99}
  }) //generate = generate new list where we define a lenght (7 columns), each element has an index
} 

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(15),
      child: Row(children: <Widget>[

      ],),
    );
  }
}
