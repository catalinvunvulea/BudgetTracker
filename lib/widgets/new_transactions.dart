import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  // const NewTransaction({Key key}) : super(key: key);

  final Function addTransaction;

  NewTransaction(this.addTransaction);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final tilteController = TextEditingController();

  final amountContorller = TextEditingController();

  void submitData() {
    final enteredTitle = tilteController.text;
    final enteredAmount = double.parse(amountContorller.text);

if (enteredTitle.isEmpty || enteredAmount <= 0) {
  return; //if the condition is meet, the code won't continue to the folowing lines (ex addTransaction)
}
    widget.addTransaction( //widget is used in the state class to access the widget class 
      tilteController.text,
      double.parse(amountContorller.text),
    );

    Navigator.of(context).pop(); //close the popup
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: "Title..."),
              controller: tilteController,
              onSubmitted: (_) =>
                  submitData(), //on submited=when ok from keyboard is pressed; we need to pass a function with string parameter, hence we use (_)
              // onChanged: (textAdded) {
              //textAdded = text added in the text field
              //  tilteController.text = textAdded;
              // },
            ),
            TextField(
              decoration: InputDecoration(
                labelText: "Value...",
                labelStyle: TextStyle(color: Colors.grey),
              ),
              controller:
                  amountContorller, //use controller or onChange and create a func
              keyboardType: TextInputType.numberWithOptions(
                  decimal:
                      true), //TextInput.number would probably work only for Android
              onSubmitted: (_) => submitData(),
            ),
            FlatButton(
              child: Text(
                "Add transaction",
              ),
              textColor: Theme.of(context).primaryColor,
              onPressed: submitData,
            )
          ],
        ),
      ),
    );
  }
}
