import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';
import 'package:flutter/material.dart';
import 'txItemTile.dart';
class TransactionList extends StatelessWidget {
  final List<Transaction> tx;
  Function dltx;
  TransactionList(this.tx, this.dltx);

  @override
  Widget build(BuildContext context) {
    return 
      
    tx.length == 0
          ? Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "no data wohooo!!",
                    textAlign: TextAlign.center,
                  ),
                  // whenever we want to add empty space we use a SizeBox
                  SizedBox(
                    height: 10,
                    width: 20,
                  ),
                  Center(
                    child: Container(
                      height: 100,
                      //for setting the image
                      child: Image.asset(
                        'assets/images/pngwing.com.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                ],
              ),
            )
          : ListView.builder(
              itemBuilder: (ctx, index) {
                return TransactionTileItem(tx: tx[index], dltx: dltx);
                // return Card(
                //   child: Row(
                //     children: <Widget>[
                //       Container(
                //         margin:
                //             EdgeInsets.symmetric(vertical: 11, horizontal: 16),
                //         decoration: BoxDecoration(
                //             border: Border.all(
                //                 color: Theme.of(context).primaryColor,
                //                 width: 2)),
                //         child: Text(
                //           "\₹" + tx[index].amount.toString(),
                //           style: TextStyle(
                //             fontSize: 25,
                //             fontWeight: FontWeight.bold,
                //             color: Theme.of(context).primaryColor,
                //           ),
                //         ),
                //         padding: EdgeInsets.all(15),
                //       ),
                //       Column(
                //         crossAxisAlignment: CrossAxisAlignment.start,
                //         children: [
                //           Container(
                //     child: Text(
                //   tx[index].title,
                //   style: TextStyle(
                //     fontWeight: FontWeight.bold,
                //     color: Colors.black,
                //     fontSize: 20,
                //   ),
                // )),
                //           Container(
                //     child: Text(
                //   DateFormat().format(tx[index].dt),
                //   style:
                //       TextStyle(color: Colors.blueGrey, fontSize: 16),
                // )),
                //         ],
                //       )
                //     ],
                //   ),
                // );
              },
              itemCount: tx.length,
            );
   
  }
}
