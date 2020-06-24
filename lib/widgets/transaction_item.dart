import 'package:flutter/material.dart';
import '../Models/transaction.dart';
import 'package:intl/intl.dart'; //alowes us to format the date


class TransactionItem extends StatelessWidget {
  const TransactionItem({
    Key key,
    @required this.transaction,
    @required this.deleteTransaction,
  }) : super(key: key);

  final Transaction transaction;
  final Function deleteTransaction;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.symmetric(vertical: 3, horizontal: 10),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          child: Padding(
            padding: EdgeInsets.all(6),
            child: FittedBox(
              child: Text("£ ${transaction.amount}"),
            ),
          ),
        ),
        title: Text(
          "${transaction.title}",
          style: Theme.of(context).textTheme.headline6,
        ),
        subtitle: Text(
          DateFormat.yMMMEd().format(transaction.date),
        ),
        trailing: MediaQuery.of(context).size.width > 460 //if the device is widher than 460, we will show additional info 
            ? FlatButton.icon(
                label: Text(
                  "Delete"
                ),
                icon: Icon(
                  Icons.delete
                ),
                textColor: Theme.of(context).errorColor,
                onPressed: () =>
                    deleteTransaction(transaction.id),
              )
            : IconButton(
                icon: Icon(
                  Icons.delete,
                  color: Theme.of(context).errorColor,
                ),
                onPressed: () =>
                    deleteTransaction(transaction.id),
              ),
      ),
    );
  }
}