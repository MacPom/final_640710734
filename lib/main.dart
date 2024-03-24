import 'package:flutter/material.dart';
import 'ReportPage.dart';
import 'helpers/helpers/api_caller.dart';
import 'helpers/helpers/dialog_utils.dart';
import 'helpers/helpers/my_list_tile.dart';
import 'helpers/helpers/my_text_field.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Webby Fondue',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ReportPage(), // เปลี่ยนเป็น ReportPage ทันทีเมื่อเปิดแอป
    );
  }
}

