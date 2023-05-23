import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:intl/intl.dart';
import 'transaction_list.dart';
import '../models/transaction.dart';
import 'chart_bar.dart';

//int this chart we get the past 7 days amount spend list and then we calculate totolSum of each day
//because there can be transaction of two tx for monday 5 tx for tuesday
class chart extends StatelessWidget {
  @override
  final List<Transaction> recentTransaction;
  chart(this.recentTransaction);
// a getter function is automatically invoked whenever any of its references changes while normal function requires
//explicit calling
  List<Map<String, Object>> get groupedTransactionValues {
    //.generate function generates a list of size as passed in the first argument
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      //totSum find the amount spend on each day of the week
      double totSum = 0;

      for (int i = 0; i < recentTransaction.length; i++) {
        if (recentTransaction[i].dt.day == weekDay.day &&
            recentTransaction[i].dt.month == weekDay.month &&
            recentTransaction[i].dt.year == weekDay.year) {
          totSum = totSum + recentTransaction[i].amount;
        }
      }
      //element of map is created// .E() gives us the date which is formatted
      return {'day': DateFormat.E().format(weekDay), 'amount': totSum};
    }).reversed.toList();
  }

  double get totalSpending {
    List<Transaction> t = recentTransaction;
    double sum = 0.0;
    for (int i = 0; i < t.length; i++) {
      sum = sum + t[i].amount;
    }
    return sum;
  }

  @override
  Widget build(BuildContext context) {
   
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: groupedTransactionValues.map((e) {
          return chart_bar(
              e['day'].toString(),
              totalSpending,
              totalSpending == 0
                  ? 0
                  : (e['amount'] as double) / (totalSpending));
        }).toList(),
      ),
    );
  }
}
