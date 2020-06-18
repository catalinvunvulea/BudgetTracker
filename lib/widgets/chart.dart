import 'package:flutter/material.dart';
import '../Models/transaction.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(
          days: index,
        ),
      );
      var totalSum = 0.0;

      for (var i = 0; i < recentTransactions.length; i++) {
        //i++ means i = i+1 we tell the loop to add 1 each time it runs
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year) {
          totalSum += recentTransactions[i].amount;
        }
      }

      return {'day': DateFormat.E().format(weekDay).substring(0, 1), 'amount': totalSum}; //.substring(element to start counting, how many digits to count and show)
    }); //generate = generate new list where we define a lenght (7 columns), each element has an index
  }

  @override
  Widget build(BuildContext context) {
    print(groupedTransactionValues);
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(15),
      child: Row(
        children: groupedTransactionValues.map((data) {
          return Text(
            "${data["day"]}: ${data["amount"]}",
          );
        }).toList(),
      ),
    );
  }
}
