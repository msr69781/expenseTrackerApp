import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

//this takes the input from text fields and calls the addTx method
//addTx methods adress has been taken as an argument of NewTransaction() constructor
class NewTransaction extends StatefulWidget {

  Function addTx;
  NewTransaction(this.addTx);
  @override
  State<NewTransaction> createState() => _NewTransactionState();
}  
class _NewTransactionState extends State<NewTransaction> {
// the below two line creates the TextField controller object which can be use the controller property of the text field to
  final _titleController = TextEditingController();

  final _amountController = TextEditingController();
  //question mark tells flutter that this is nullable and can be assigned null values
  DateTime? _dtController;

// submit data function is called when changes are being made in the text fields , if null value is entered then nothing has been performed
  void submitData() {
    final enteredAmount = double.parse(_amountController.text);
    final enteredTitle = _titleController.text;

    if (enteredTitle == null || enteredAmount < 0 || _dtController == null) {
      return;
    }
    //we are accesing the widget of the stateful widget
    widget.addTx(enteredTitle, enteredAmount, _dtController);
  }

  void ChooingDate() {
    // to show a date chart using in the modal sheet
    showDatePicker(
      //setting the properties of the date time picker
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2018),  
            lastDate: DateTime.now())
        .then((value) {
//when something is selected in the datePicker its value gets stored in the value variable
      if (value == null) {
        return;
      }
      setState(() {
        _dtController = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(4),
        decoration: BoxDecoration(border: Border.all()),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextField(
              controller: _titleController,
              decoration: InputDecoration(label: Text("title")),
              keyboardType: TextInputType.text,
              onChanged: (value) => submitData,
            ),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: "amount"),
              controller: _amountController,
              onChanged: (value) => submitData,
            ),
            Container(
              child: Row(
                children: [
                  Expanded(
                    child: Text(_dtController == null
                        ? "no date chosen"
                        //......................
                        : "Date picked : "),
                  ),
                  TextButton(
                    //ChoosingDate is a function for datEPicker
                      onPressed: ChooingDate,
                      child: Text(
                        "Choose the date",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ))
                ],
              ),
            ),
            Center(
              child: ElevatedButton(
                child: Text(
                  "Add Transaction",
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: () {
                  widget.addTx(_titleController.text,
                      double.parse(_amountController.text),_dtController);

                  //Through Navigator we get rid of the current active screen or popUp... like we want to close the modalBottomSheet
//after clicking the addTransaction text button
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
