import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:formula/pages/loading.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:formula/components/bottomNavBar.dart';
import 'package:formula/general/fonts.dart';
import 'package:formula/general/themes.dart';
import 'package:formula/general/utils.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

class JudgeReportsPage extends StatefulWidget {
  const JudgeReportsPage({Key? key}) : super(key: key);

  @override
  State<JudgeReportsPage> createState() => _JudgeReportsPageState();
}

class _JudgeReportsPageState extends State<JudgeReportsPage> {
  final controller = JudgeReportsController();
  Future? futureCall;

  @override
  void initState() {
    super.initState();
    futureCall = controller.getPictureFromIpfs();
  }

  @override
  Widget build(BuildContext context) {
    ScreenSize.refresh(context);
    return FutureBuilder(
        future: futureCall,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingPage();
          } else {
            return GetBuilder<JudgeReportsController>(
                init: controller,
                builder: (controller) {
                  return Scaffold(
                      appBar: AppBar(
                        backgroundColor: AppColors.orange,
                        title: const Text('Gas Insurance'),
                      ),
                      backgroundColor: Colors.transparent,
                      body: scaffoldBody(
                        context: context,
                        mobileBody: mobileBody(),
                        tabletBody: mobileBody(),
                      ),
                      bottomNavigationBar: const BottomNavBar());
                });
          }
        });
  }

  mobileBody() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const Flexible(
          flex: 1,
          child: Text(
            "Is this damage valid?",
            style: TextStyle(
                fontWeight: FontWeight.bold, letterSpacing: 2, fontSize: 26),
          ),
        ),
        Flexible(
          flex: 6,
          child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              
              child: Image.file(File('/data/user/0/com.example.formula/app_flutter/Screenshot_2022-11-15-10-01-20-438_com.facebook.katana(10).jpg'))),
              
        ),
        Flexible(
          flex: 1,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: ElevatedButton(
                    child: Text("Not valid"),
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.red)),
                    onPressed: () {
                      // call the sc function BUT FIRST DELETE FILE
                    },
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: ElevatedButton(
                    child: Text("Valid"),
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.green)),
                    onPressed: () {
                      // call the sc function BUT FIRST DELETE FILE
                    },
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}

class JudgeReportsController extends GetxController {

  File? picture;

  getPictureFromIpfs() async {
    print('szetbaszom a fjed');
    final url =
        'http://vm.niif.cloud.bme.hu:14434/getFile?path=/G5qYugi3f16bxlxI1WsN/Screenshot_2022-11-15-10-01-20-438_com.facebook.katana.jpg';
    final response = await http.get(Uri.parse(url));
    String header = response.headers['content-disposition']!;
    int fromIndex = header.indexOf('=');
    String filename = header.substring(fromIndex + 1);
    String dir = (await getApplicationDocumentsDirectory()).path;
    String path = '$dir/$filename';
    print(path);
    picture = await File(path).writeAsBytes(response.bodyBytes);
    update();
  }
  
}
