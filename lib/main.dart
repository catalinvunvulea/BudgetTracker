import 'dart:math';

import 'package:BudgetTracker/widgets/chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import './widgets/new_transactions.dart';
import './Models/transaction.dart';
import './widgets/transaction_list.dart';
import './widgets/chart.dart';

void main() {
//  WidgetsFlutterBinding //commented as we will show the app in all orientations style
  //     .ensureInitialized(); //if this func is not called, on some devices orientation won't work as requsted below
  // SystemChrome.setPreferredOrientations(//used to set the device orentations
  //    [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Budget App',
      theme: ThemeData(
        primarySwatch: Colors
            .purple, //used to set a theme color that can be used throughout the App
        accentColor: Colors.amberAccent, //showing to some of the widgets
        errorColor: Colors.red[400],
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
              headline6: TextStyle(
                //headline6 = title
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              button:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
                  //title was replaced by headline6
                  fontFamily: 'OpenSans',
                  fontSize: 22,
                ),
                button: TextStyle(
                  color: Colors.white,
                ),
              ),
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [
    // Transaction(
    //   id: "t1",
    //   title: "Shoes",
    //   amount: 39.19,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: "t2",
    //   title: "Weekly shopping",
    //   amount: 99.69,
    //   date: DateTime.now(),
    // )
  ];

  bool _showChart = false;

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((element) {
      //.where can be used to lists(arrays) to return only the elemnts which we want; just like  for in loop
      return element.date.isAfter(DateTime.now().subtract(Duration(
          days:
              7))); //isAfter can be added to dates, and return only the dates after the date we give, and we substract 7 days from now
    }).toList(); //where return an Iterable and we expect a list, hence we convert it
  }

  void _addNewTransaction(String txTitle, double txAmount, DateTime txDate) {
    final newTrans = Transaction(
      title: txTitle,
      amount: txAmount,
      date: txDate,
      id: DateTime.now().toString() + txTitle.toString() + txAmount.toString(),
    );
    setState(() {
      _userTransactions.add(newTrans);
    });
  }

  void _deleteTransaction(String idToDelete) {
    setState(() {
      //to reload the screen once the transaction is removed
      _userTransactions.removeWhere((element) {
        //removeWhere will run a loop in the list and remove the element we ask him to
        return element.id ==
            idToDelete; // it has to return a bool, so once the condition is true, it will remove the elment
      });
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return NewTransaction(_addNewTransaction);
        });
  }

  @override
  Widget build(BuildContext context) {
    final isLandskape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final appBar = AppBar(
      //appBar is added in a constant so the size can be accessed and used when creatin dynamic sizes
      centerTitle: true,
      title: Text(
        "My Budget",
        style: TextStyle(
          fontFamily: 'Open Sans',
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.add, color: Colors.white),
          onPressed: () => _startAddNewTransaction(context),
        ),
      ],
    );

    final transactionsListWidget = Container(
      height: (MediaQuery.of(context).size.height -
          appBar.preferredSize.height -
          MediaQuery.of(context).padding.top),
      child: TransactionList(
        _userTransactions,
        _deleteTransaction,
      ),
    );

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if (isLandskape)
              Row(
                //this is a special if inside of a List, hence we don't have to use {}
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Text("Show chart"),
                      Switch(
                        activeColor: Theme.of(context).primaryColor,
                        value: _showChart,
                        onChanged: (value) {
                          setState(() {
                            _showChart = value;
                          });
                        },
                      )
                    ],
                  )
                ],
              ),
            if (!isLandskape)
              Container(
                height: (MediaQuery.of(context).size.height -
                        appBar.preferredSize.height -
                        MediaQuery.of(context).padding.top) *
                    0.3, //padding is kind of a safe area
                child: Chart(_recentTransactions),
              ),
            if (!isLandskape) transactionsListWidget,
            if (isLandskape)
               _showChart
                  ? Container(
                      height: (MediaQuery.of(context).size.height -
                              appBar.preferredSize.height -
                              MediaQuery.of(context).padding.top) *
                          0.7, //padding is kind of a safe area
                      child: Chart(_recentTransactions),
                    )
                  : transactionsListWidget,
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context),
      ),
    );
  }
}
