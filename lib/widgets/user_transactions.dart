import 'package:flutter/material.dart';
import './new_transactions.dart';
import './transaction_list.dart';
import '../Models/transaction.dart';

class UserTransactions extends StatefulWidget {
  //UserTransactions({Key key}) : super(key: key);

  @override
  _UserTransactionsState createState() => _UserTransactionsState();
}

class _UserTransactionsState extends State<UserTransactions> {

  final List<Transcation> _userTransactions = [
    Transcation(
      id: "t1",
      title: "Shoes",
      amount: 39.19,
      date: DateTime.now(),
    ),
    Transcation(
      id: "t2",
      title: "Weekly shopping",
      amount: 99.69,
      date: DateTime.now(),
    )
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        NewTransaction(),
        TransactionList(_userTransactions),
      ],
    );
  }
}
