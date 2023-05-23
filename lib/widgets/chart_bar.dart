import 'package:flutter/rendering.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/widgets.dart';

class chart_bar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double spendingPercentage;

  chart_bar(this.label, this.spendingAmount, this.spendingPercentage);

  @override
  Widget build(BuildContext context) {
    //used the expanded widget to make sure the things wont go out of the boundary and show error ....of boundary limits
    return LayoutBuilder(builder: (context,Constraints){
      //contraints in the above line is an object used to make manage the widget tree features like height,etc
      return Column(
        children: <Widget>[
          //.toStringAsFixed convert a number to a decimal point string ...here the argument is 0 so integer string is the conversion
          //fitted box is used to make a boundary to not let the particular element come out
          Container(
            height: Constraints.maxHeight*0.15,
            child: FittedBox(child:Padding(
              padding: EdgeInsets.all(4),
              child: Text("\₹${spendingAmount.toStringAsFixed(0)}"))),
          ),
          SizedBox(
            height: Constraints.maxHeight*0.05,
          ),
          Container(
            height: Constraints.maxHeight*0.6,
            width: 20,
            //a stack is widget which lets you put elements one over another
            child: Stack(
              children: <Widget>[
                Container(
                  height: 100,
                  decoration: BoxDecoration(
                    border: Border.all(),
                    color: Color.fromARGB(220, 234, 232, 232),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                //fractionallySizedBox is used to specify the size according to the widget it is child of
                //we can pass the argument between 0 or 1 which means full height or percentage of the height we want
                FractionallySizedBox(
                  heightFactor: spendingPercentage,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Color.fromARGB(220, 12, 9, 20),
                        borderRadius: BorderRadius.circular(20)),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: Constraints.maxHeight*0.15,
            child: FittedBox(child: Text(label))),
          SizedBox(
            height: Constraints.maxHeight*0.05,
          ),
        ],
      );
    });
    
    
  }
}
