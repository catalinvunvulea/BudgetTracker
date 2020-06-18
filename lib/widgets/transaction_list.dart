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
                  child: Row(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 15,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Theme.of(context)
                                .primaryColor, //access the setted ThemeColor
                            width: 2,
                          ),
                        ),
                        padding: EdgeInsets.all(10),
                        child: FittedBox(
                          child: Text(
                            "£ ${transactions[index].amount.toStringAsFixed(2)}", //string interpolation ${} / toStringAsFixed(2) = shows exactly 2 decimals after .
                            style: TextStyle(
                               // fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.purple),
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(transactions[index].title,
                              style: Theme.of(context).textTheme.headline6),
                          Text(
                            DateFormat("dd MMMM yyyy").format(transactions[
                                    index]
                                .date), //format of date can be changed in many ways, add ".'" after DateFormat to access other options
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          )
                        ],
                      ) //we convert the double to tex using toString
                    ],
                  ),
                );
              },
              itemCount: transactions.length,
            ),
    );
  }
}
