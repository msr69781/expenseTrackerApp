//libriary for apple ios interface
import 'dart:io';
import 'package:flutter/cupertino.dart';

import 'package:expense_app/models/transaction.dart';
import './widgets/transaction_list.dart';
import 'package:flutter/material.dart';
import './widgets/newTransaction.dart';
import '../widgets/newTransaction.dart';
import './widgets/chart.dart';
import 'package:flutter/services.dart';

void main() {
  //first we run the MyApp using the main function
  runApp(MyApp());
  //{
  //if you dont want the app to get into landscape mode import the services.dart
  //use the lines given below
  //   SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown
  // ]);
  //}
}

class MyApp extends StatelessWidget {
  // after MyApp is called we call our stateful widget
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'expensive app',

      theme: ThemeData(
          primarySwatch: Colors.cyan,
          buttonColor: Colors.amber,
          fontFamily: 'OpenSans'),
      //at the home we call the expense class constructor
      home: expense(),
    );
  }
}

class expense extends StatefulWidget {
  @override
  _expense_app createState() => _expense_app();
  //State<StatefulWidget> createState() => _expense_app();
}

class _expense_app extends State<expense> {
  final List<Transaction> userTransactionList = [
    //   Transaction(id: "t1", amount: 89.32, dt: DateTime.now(), title: "grocerry"),
    // Transaction(
    //     id: "t2", amount: 77.32, dt: DateTime.now(), title: "VS fast food")
  ];
  @override
  void _ussTransaction(String NewTitle, double NewAmount, DateTime chosenDate) {
    Transaction newTx = Transaction(
        id: DateTime.now().toString(),
        amount: NewAmount,
        dt: chosenDate,
        title: NewTitle);
    setState(() {
      //userTransactionList is a list in the main file
      // Set state makes the changes once the new transactions are added.In the list new transaction are added
      userTransactionList.add(newTx);
    });
  }
//created a function for the fuctioning of the modalBottom sheet 
  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        // gesture detector does the job ...when we click something...a circular interative boundary is created...
        //we can also define different properties...like what happens on double click,single, long click,swipe
        return GestureDetector(
          onTap: () => {},
          //NewTransaction is a function of the newTransaction.dart file which accept the argument of a function of main.dart file 
          //to add the new transaction from modal sheet to list
          child: NewTransaction(_ussTransaction),
          behavior: HitTestBehavior.translucent,
        );
      },
    );
  }

  void deleteTx(String id) {
    setState(() {
      //learn more about the removeWhere method
      //We dont need iterations to travel: RemoveWhere() travels the whole list
      userTransactionList.removeWhere((Element) {
        return (id == Element.id);
      });
    });
  }

// to create a list with past 7 days of transaction
//please note that this isn't a function
  List<Transaction> get recentctxn {
    var currentDate = DateTime.now();
    //firstly creating an empty list
    List<Transaction> txt = [];
    for (int i = 0; i < userTransactionList.length; i++) {
      if (userTransactionList[i].dt.day - currentDate.day <= 7 &&
          userTransactionList[i].dt.month - currentDate.month == 0 &&
          userTransactionList[i].dt.year - currentDate.year == 0) {
        txt.add(userTransactionList[i]);
      }
    }
    return txt;
  }

  bool _showChart = false;
  @override
  Widget build(BuildContext context) {
    // final IsLandscape=MediaQuery.of(context).orientation==Orientation.landscape;
    final ObstructingPreferredSizeWidget app_Bar_ios = CupertinoNavigationBar(
      middle: Text(
        'Personal Expenses',
      ),
      trailing: Row(
//main axis.min is the enum which takes the minimum width as possible giving the sufficient
//space to middle one
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          GestureDetector(
            child: Icon(CupertinoIcons.add),
            onTap: () => _startAddNewTransaction(context),
          ),
        ],
      ),
    );
//i have created two final variable for app bar because some error was there which i was unable to get through
//the error was with preffered size widget.
    final PreferredSizeWidget app_Bar_android = AppBar(
      title: Text(
        'Personal Expenses',
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => _startAddNewTransaction(context),
        ),
      ],
    );

    final txList = Container(
        //here MediaQuery is use to find the size of the widget tree and then extracting the height
        ////part from the size property
        ///we have subtracted the height of the appBar to have proper scrolling and the chart doesn't get scroll up
//MediaQuery.of(ctx).padding.top provide us the padding due status bar
        // height: (MediaQuery.of(context).size.height -
        //         appBar.preferredSize.height -
        //         MediaQuery.of(context).padding.top) *
        //         0.6,
        child: TransactionList(userTransactionList, deleteTx));
    final isLandscape = 
        MediaQuery.of(context).orientation == Orientation.landscape;
Widget landscapeContent(){

  return Column(
                  children: [
                    Container(
                      height: (MediaQuery.of(context).size.height -
                              -380 -
                              MediaQuery.of(context).padding.top) *
                          0.080,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("show chart"),
                          //.adaptive will make the button look like ios if plattform is apple
                          Switch.adaptive(
                              value: _showChart,
                              onChanged: (val) {
                                setState(() {
                                  _showChart = val;
                                });
                              })
                        ],
                      ),
                    ),
                    if (_showChart)
                      Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(10),
                            margin: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 15),

                            width: double.infinity,
                            height: (MediaQuery.of(context).size.height -
                                    -180 -
                                    MediaQuery.of(context).padding.top) *
                                0.25,
                            // child: Card(
                            //   child: Text(
                            //     "List of tx",
                            //     textAlign: TextAlign.center,
                            //     style: TextStyle(
                            //       fontSize: 20,
                            //     ),
                            //   ),
                            //   color: Theme.of(context).primaryColor,
                            // ),
                            //$$
                            // height: (MediaQuery.of(context).size.height -
                            //         appBar.preferredSize.height) *
                            //     0.25,

                            child: chart(recentctxn),
                          ),
                          Container(
                            height: (MediaQuery.of(context).size.height -
                                    -180 -
                                    MediaQuery.of(context).padding.top) *
                                0.5,
                            child: txList,
                          )
                        ],
                      )
                    else
                      Container(
                        height: (MediaQuery.of(context).size.height -
                                -180 -
                                MediaQuery.of(context).padding.top) *
                            0.5,
                        child: txList,
                      )
                  ],
                );

}
Widget potraitContent(){

  return Container(
                  child: Column(children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(10),
                      margin:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 15),

                      width: double.infinity,
                      height: (MediaQuery.of(context).size.height -
                              -10 -
                              MediaQuery.of(context).padding.top) *
                          0.25,
                      // child: Card(
                      //   child: Text(
                      //     "List of tx",
                      //     textAlign: TextAlign.center,
                      //     style: TextStyle(
                      //       fontSize: 20,
                      //     ),
                      //   ),
                      //   color: Theme.of(context).primaryColor,
                      // ),
                      //$$
                      // height: (MediaQuery.of(context).size.height -
                      //         appBar.preferredSize.height) *
                      //     0.25,

                      child: chart(recentctxn),
                    ),
                    Container(
                      height: (MediaQuery.of(context).size.height -
                              -10 -
                              MediaQuery.of(context).padding.top) *
                          0.5,
                      child: txList,
                    )
                  ]),
                );
  
}

//the safeArea is used to avoid the overlapping of the app bar with chart which has occured due to for ios
//full screen dispay is avaible with front camera
    final BodyOfAPP = SafeArea(
      child: SingleChildScrollView(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              if (isLandscape)
                landscapeContent(),
              if (!isLandscape)
              potraitContent(),
                
            ]),
      ),
    );
    return Platform.isIOS
        ? CupertinoPageScaffold(
            navigationBar: app_Bar_ios,
            child: BodyOfAPP,
          )
        : Scaffold(
            //appBar final variable is created because to find the height of the height of the app bar at
            //any part of the code we can use that varialble and use it.
            appBar: app_Bar_android,
            body: BodyOfAPP,
            // ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            //to check whether platform is IOs and render the widget accordingly
            floatingActionButton: Platform.isIOS == true
                ? Container()
                : FloatingActionButton(
                    onPressed: () {
                      _startAddNewTransaction(context);
                    },
                    child: Text("new tx"),
                  ),
          );
  }
}
