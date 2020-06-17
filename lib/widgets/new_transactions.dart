import 'package:flutter/material.dart';

class NewTransaction extends StatelessWidget {
  // const NewTransaction({Key key}) : super(key: key);

  final Function addTransaction;
  final tilteController = TextEditingController();
  final amountContorller = TextEditingController();

  NewTransaction(this.addTransaction);

  void submitData() {
    final enteredTitle = tilteController.text;
    final enteredAmount = double.parse(amountContorller.text);

if (enteredTitle.isEmpty || enteredAmount <= 0) {
  return; //if the condition is meet, the code won't continue to the folowing lines (ex addTransaction)
}
    addTransaction(
      tilteController.text,
      double.parse(amountContorller.text),
    );
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
              textColor: Colors.purpleAccent,
              onPressed: submitData,
            )
          ],
        ),
      ),
    );
  }
}
