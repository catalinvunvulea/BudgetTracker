import 'package:flutter/material.dart';

class NewTransaction extends StatelessWidget {
  // const NewTransaction({Key key}) : super(key: key);

  final Function addTransaction;
  final tilteController = TextEditingController();
  final amountContorller = TextEditingController();

  NewTransaction(this.addTransaction);

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
              onChanged: (textAdded) {
                //textAdded = text added in the text field
                tilteController.text = textAdded;
              },
            ),
            TextField(
              decoration: InputDecoration(
                labelText: "Value...",
                labelStyle: TextStyle(color: Colors.grey),
              ),
              onChanged: (valueAdded) {
                amountContorller.text = valueAdded;
              },
            ),
            FlatButton(
              child: Text(
                "Add transaction",
              ),
              textColor: Colors.purpleAccent,
              onPressed: () {
                addTransaction(
                  tilteController.text,
                  double.parse(amountContorller.text),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
