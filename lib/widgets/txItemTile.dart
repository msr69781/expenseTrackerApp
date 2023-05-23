import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';
import 'package:flutter/material.dart';
class TransactionTileItem extends StatelessWidget {
  const TransactionTileItem({
    Key? key,
    required this.tx,
    required this.dltx,
  }) : super(key: key);

  final Transaction tx;
  final Function dltx;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.all(5),

      //listTile is an alternative to a row, a list tile has a title ,subtitle prperty
      //using list helps us forming cilcular entity...which would be difficult to form using the row
      child: ListTile(
        //a circular avatar creates a circle
//we could also use circular shape using container ()
//container(decoration : BoxDecoration(shape: BoxShape.circle), height : x,width:y),

        leading: CircleAvatar(
          radius: 30,
          //padding is the alternative of the container widget when we just have the intent to give padding
          child: Padding(
            padding: EdgeInsets.all(5),
            child: FittedBox(
              child: Text(
                "\₹" + tx.amount.toString(),
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
          ),
        ),
        title: Text(
          tx.title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 20,
          ),
        ),
        subtitle: Text(
          DateFormat().format(tx.dt),
          style: TextStyle(color: Colors.blueGrey, fontSize: 16),
        ),
//according to device width we can present the widget we want to show ...like for Ipad and high width UI of app can be different
        trailing: (MediaQuery.of(context).size.width>50)?
        TextButton.icon(
          label: Text("Delete"),
          onPressed: () {
            dltx(tx.id);
          },
          icon: Icon(Icons.delete, color: Colors.red),
        )
        
        :IconButton(
          onPressed: () {
            dltx(tx.id);
          },
          icon: Icon(Icons.delete, color: Colors.red),
        )
        
      ),
    );
  }
}
