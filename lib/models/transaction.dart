import 'package:flutter/material.dart';
// this defines the class type and and data that need to be there in the transaction list and specify which are necessary fields
class Transaction {
  final String id;
   final double amount;
  final String title;
  final DateTime dt;

  Transaction({ required this.id, required this.amount, required this.dt, required this.title});
}
