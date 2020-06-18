import './chart_bar.dart';
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
      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalSum
      }; //.substring(element to start counting, how many digits to count and show)
    }); //generate = generate new list where we define a lenght (7 columns), each element has an index
  }

  double get totalSpending {
    return groupedTransactionValues.fold(0.0, (sum, item) {
      //fold alows us to change a list to a different type with a logig defined by us
      return sum + item['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(15),
      child: Padding( //if you need a container only to set Padding, use Padding instead
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactionValues.map((data) {
            return Flexible( //we wrap the ChartBar in a Flexible to manage the view if the text is too long
              fit: FlexFit.tight, //with thight we force the child not to exceed his dedicated space
                        child: ChartBar(
                data['day'],
                data['amount'],
                totalSpending == 0 ? 0.0 : (data['amount'] as double) / totalSpending,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
