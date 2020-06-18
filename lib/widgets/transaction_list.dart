import 'package:BudgetTracker/Models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  // TransactionList({Key key}) : super(key: key);
  final List<Transaction> transactions;

  TransactionList(this.transactions);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      child: transactions.isEmpty
          ? Column(
              children: <Widget>[
                Text(
                  "You don't have a transaction!",
                  style: Theme.of(context).textTheme.headline6,
                ),
                SizedBox(height: 20),
                Container(
                    height: 200,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    ))
              ],
            )
          : ListView.builder(
              //used for long lists (or if no of rows/columns is unknown; always has to have itemBuilder - elemtns included, and itemCount = number of rows/columns)
              itemBuilder: (ctx, index) {
                return Card(
                  elevation: 3,
                  margin: EdgeInsets.symmetric(vertical: 3, horizontal: 10),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: Padding(
                        padding: EdgeInsets.all(6),
                        child: FittedBox(
                          child: Text("£ ${transactions[index].amount}"),
                        ),
                      ),
                    ),
                    title: Text(
                      "${transactions[index].title}",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    subtitle: Text(
                      DateFormat.yMMMEd().format(transactions[index].date),
                    ),
                  ),
                );
              },
              itemCount: transactions.length,
            ),
    );
  }
}
