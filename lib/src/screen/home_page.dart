import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:notes_app/src/screen/new_notes.dart';
import 'package:notes_app/src/util/app_constant.dart';

import '../widgets/app_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,MaterialPageRoute(builder: (context)=> const NewNotes()));
        },
        child: Icon(
          Icons.add,
          size: 29.sp,
        ),
        backgroundColor: AppConstant.theme,
      ),
      body: Column(children: [
        Appbar(),
      ]),
    );
  }
}
