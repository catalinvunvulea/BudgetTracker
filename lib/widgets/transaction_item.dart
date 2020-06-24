import 'dart:math'; //use func such as Random

import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; //alowes us to format the date


import '../Models/transaction.dart';

class TransactionItem extends StatefulWidget {
  const TransactionItem({
    Key key,
    @required this.transaction,
    @required this.deleteTransaction,
  }) : super(key: key);

  final Transaction transaction;
  final Function deleteTransaction;

  @override
  _TransactionItemState createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {

Color _bgColor;

  @override
  void initState() {
    super.initState();
   const availableColors = [
     Colors.black,
     Colors.blue,
     Colors.purple,
     Colors.pink,
   ];
_bgColor = availableColors[Random().nextInt(availableColors.length)]; //nextInt is the max no, always start with 0 and does not count the last one (ex, if I add , it will take from 0 to 3)

  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.symmetric(vertical: 3, horizontal: 10),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: _bgColor,
          radius: 30,
          child: Padding(
            padding: EdgeInsets.all(6),
            child: FittedBox(
              child: Text("£ ${widget.transaction.amount}"),
            ),
          ),
        ),
        title: Text(
          "${widget.transaction.title}",
          style: Theme.of(context).textTheme.headline6,
        ),
        subtitle: Text(
          DateFormat.yMMMEd().format(widget.transaction.date),
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
                    widget.deleteTransaction(widget.transaction.id),
              )
            : IconButton(
                icon: Icon(
                  Icons.delete,
                  color: Theme.of(context).errorColor,
                ),
                onPressed: () =>
                    widget.deleteTransaction(widget.transaction.id),
              ),
      ),
    );
  }
}