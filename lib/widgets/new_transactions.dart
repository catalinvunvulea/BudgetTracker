import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; //alowes us to format the date

class NewTransaction extends StatefulWidget {
  // const NewTransaction({Key key}) : super(key: key);

  final Function addTransaction;

  NewTransaction(this.addTransaction);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _tilteController = TextEditingController();
  final _amountContorller = TextEditingController();
  DateTime
      _selectedDate; //create a var of type Date to store the dates selected by the user

  void _submitData() {
    final enteredTitle = _tilteController.text;
    final enteredAmount = double.parse(_amountContorller.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0) {
      return; //if the condition is meet, the code won't continue to the folowing lines (ex addTransaction)
    }
    widget.addTransaction(
      //widget is used in the state class to access the widget class
      _tilteController.text,
      double.parse(_amountContorller.text),
    );

    Navigator.of(context).pop(); //close the popup
  }

  void _presentDatePicker() {
    showDatePicker(
      //wiget built by flutter to show datePicker
      context: context, //we pass in the context from the class
      initialDate:
          DateTime.now(), //odate to show as selected when open the date picker
      firstDate: DateTime(2020), // oldest date available (Jan 20202)
      lastDate: DateTime.now(), // latest date available
    ).then((pickedDate) {
      //then alows us to run a function once the user chose a date
      if (pickedDate == null) {
        return;
      } else {
        setState(() {
          //tell flutter that a statefull widget updated and needs to update the screen
          _selectedDate = pickedDate;
        });
      }
    });
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
              controller: _tilteController,
              onSubmitted: (_) =>
                  _submitData(), //on submited=when ok from keyboard is pressed; we need to pass a function with string parameter, hence we use (_)
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
                  _amountContorller, //use controller or onChange and create a func
              keyboardType: TextInputType.numberWithOptions(
                  decimal:
                      true), //TextInput.number would probably work only for Android
              onSubmitted: (_) => _submitData(),
            ),
            Container(
              height: 70,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      _selectedDate == null
                          ? "No date chosen"
                          : "Picked date: ${DateFormat.yMMMMd().format(_selectedDate)}",
                    ),
                  ),
                  FlatButton(
                    child: Text(
                      _selectedDate == null ? "Chose date" : "Change date",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    textColor: Theme.of(context).primaryColor,
                    onPressed: _presentDatePicker,
                  )
                ],
              ),
            ),
            RaisedButton(
              child: Text("Add transaction"),
              color: Theme.of(context).primaryColor,
              textColor: Theme.of(context).textTheme.button.color,
              onPressed: _submitData,
            ),
          ],
        ),
      ),
    );
  }
}
