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
  final List<Transaction> _userTransactions = [
    Transaction(
      id: "t1",
      title: "Shoes",
      amount: 39.19,
      date: DateTime.now(),
    ),
    Transaction(
      id: "t2",
      title: "Weekly shopping",
      amount: 99.69,
      date: DateTime.now(),
    )
  ];

  void _addNewTransaction(String txTitle, double txAmount) {
    final newTrans = Transaction(
      title: txTitle,
      amount: txAmount,
      date: DateTime.now(),
      id: DateTime.now().toString(),
    );
    setState(() {
      _userTransactions.add(newTrans);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        NewTransaction(
          _addNewTransaction,
        ),
        TransactionList(
          _userTransactions,
        ),
      ],
    );
  }
}
