import 'package:flutter/material.dart';
import 'helpers/helpers/api_caller.dart'; 
import 'helpers/helpers/dialog_utils.dart';

class ReportPage extends StatefulWidget {
  @override
  _ReportPageState createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  final _apiCaller = ApiCaller();
  final _urlController = TextEditingController();
  final _detailsController = TextEditingController();
  String? _selectedWebType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Report Website'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView( // Wrap the Column with SingleChildScrollView
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                padding: EdgeInsets.symmetric(horizontal: 12.0),
                child: TextFormField(
                  controller: _urlController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: 'URL',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a URL';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: 16.0),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                padding: EdgeInsets.symmetric(horizontal: 12.0),
                child: TextFormField(
                  controller: _detailsController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: 'Details',
                  ),
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                'Web Type',
                style: TextStyle(fontSize: 16.0),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8.0),
              Column(
                children: [
                  _buildWebTypeButton('Gambling'),
                  SizedBox(height: 8.0),
                  _buildWebTypeButton('Fake'),
                  SizedBox(height: 8.0),
                  _buildWebTypeButton('Misleading'),
                  SizedBox(height: 8.0),
                  _buildWebTypeButton('Chain'),
                ],
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () => _submitReport(context),
                child: Text('Submit Report'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWebTypeButton(String webType) {
    bool isSelected = _selectedWebType == webType;

    // ประกาศตัวแปรสำหรับเก็บข้อมูลรายละเอียดของแต่ละปุ่ม
    Map<String, dynamic> buttonDetails = {
      'Gambling': {
        'title': 'เว็บพนัน',
        'subtitle': 'การพนัน แทงบอล และอื่นๆ',
        'image': 'https://cpsu-api-49b593d4e146.herokuapp.com/images/webby_fondue/gambling.jpg',
      },
      'Fake': {
        'title': 'เว็บปลอมแปลง เลียนแบบ',
        'subtitle': 'หลอกให้กรอกข้อมูลส่วนตัว/รหัสผ่าน',
        'image': 'https://cpsu-api-49b593d4e146.herokuapp.com/images/webby_fondue/fraud.png',
      },
      'Misleading': {
        'title': 'เว็บข่าวมั่ว',
        'subtitle': 'Fake news, ข้อมูลที่ทำให้เข้าใจผิด',
        'image': 'https://cpsu-api-49b593d4e146.herokuapp.com/images/webby_fondue/fake_news_2.jpg',
      },
      'Chain': {
        'title': 'เว็บแชร์ลูกโซ่',
        'subtitle': 'หลอกลงทุน',
        'image': 'https://cpsu-api-49b593d4e146.herokuapp.com/images/webby_fondue/thief.jpg',
      },
    };

    return SizedBox(
      height: 90.0,
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            _selectedWebType = webType;
          });
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
              side: BorderSide(
                color: isSelected ? Colors.blue : Colors.grey,
              ),
            ),
          ),
        ),
        child: Row(
          children: [
            if (buttonDetails[webType]['image'] != null)
              Image.network(
                buttonDetails[webType]['image'],
                height: 50.0, // ปรับขนาดรูปภาพตามต้องการ
              ),
            SizedBox(width: 8.0), // ระยะห่างระหว่างรูปภาพและข้อความ
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  buttonDetails[webType]['title'] ?? webType,
                  style: TextStyle(
                    fontSize: 16.0,
                    color: isSelected ? Colors.blue : Colors.grey,
                  ),
                ),
                Text(
                  buttonDetails[webType]['subtitle'] ?? '',
                  style: TextStyle(
                    fontSize: 12.0,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _submitReport(BuildContext context) async {
    if (_urlController.text.isEmpty) {
      // แสดง AlertDialog ให้ผู้ใช้กรอก URL หากไม่ได้กรอก
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Please enter a URL'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('OK'),
              ),
            ],
          );
        },
      );
      return;
    }

    if (_selectedWebType == null) {
      // แสดง AlertDialog ให้ผู้ใช้เลือก Web Type หากยังไม่ได้เลือก
      await showDialog(
        context: context,
        builder: (BuildContext context) {
                   return AlertDialog(
            title: Text('Error'),
            content: Text('Please select a web type'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('OK'),
              ),
            ],
          );
        },
      );
      return;
    }

    try {
      // ทำการเรียก API สำหรับการส่งรายงาน
      await _apiCaller.post('report_web', params: {
        'url': _urlController.text,
        'web_type': _selectedWebType,
        'details': _detailsController.text,
      });

      // แสดง AlertDialog เมื่อสำเร็จ
      await showOkDialog(
        context: context,
        title: 'Success',
        message: 'Success',
      );

      // ล้างข้อมูลใน TextField และเคลียร์ Web Type ที่เลือก
      _urlController.clear();
      _detailsController.clear();
      setState(() {
        _selectedWebType = null;
      });
    } catch (e) {
      // แสดง AlertDialog เมื่อเกิดข้อผิดพลาดในการส่งรายงาน
      await showOkDialog(
        context: context,
        title: 'Error',
        message: 'Failed to submit report. Please try again later.',
      );
    }
  }

  @override
  void dispose() {
    _urlController.dispose();
    _detailsController.dispose();
    super.dispose();
  }
}

