import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NewNotes extends StatefulWidget {
  const NewNotes({super.key});

  @override
  State<NewNotes> createState() => _NewNotesState();
}

class _NewNotesState extends State<NewNotes> {
  TextEditingController title = TextEditingController();
  TextEditingController notes = TextEditingController();
  String t = "";
  String n = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 30.h),
        padding: EdgeInsets.all(13.r),
        // color: Colors.red,
        child: Column(children: [
          Container(
            // color: Colors.yellow,
            height: 28.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  child: Icon(Icons.arrow_back),
                  onTap: (() {
                    Navigator.pop(context);
                  }),
                ),
                Icon(Icons.done_outlined),
              ],
            ),
          ),
          TextField(
            onChanged: (value) => t=value,
            controller: title,
            style: TextStyle(
              fontSize: 25.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            textInputAction: TextInputAction.newline,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Title',
                hintStyle:
                    TextStyle(fontSize: 25.sp, fontWeight: FontWeight.bold)),
          ),
          SizedBox(
            height: 16.h,
          ),
          TextField(
            onChanged: (value) => n=value,
            controller: notes,
            style: TextStyle(
              fontSize: 20.sp,
              // fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 36, 34, 34),
            ),
            textInputAction: TextInputAction.newline,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            decoration: InputDecoration.collapsed(
              hintText: 'notes',
            ),
          ),
          ElevatedButton(
            onPressed: () {
              print(t);
              print(n);
            },
            child: Text('check'),
          ),
        ]),
      ),
    );
  }
}
