import 'package:flutter/material.dart';

import 'add_room.dart';
import 'app.dart';

void main() {
  runApp( MaterialApp(
    home: AddRoom(),
    // routes: {
    //   '/addroom': (context) => AddRoom(),
    // },
    debugShowCheckedModeBanner: false,
    title: 'Shaja Sync',
  ));
}
