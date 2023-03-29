import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NewNotes extends StatefulWidget {
  String collectionId;

  NewNotes({super.key, required this.collectionId});

  @override
  State<NewNotes> createState() => _NewNotesState(collectionId: collectionId);
}

class _NewNotesState extends State<NewNotes> {
  String collectionId;
  _NewNotesState({required this.collectionId});
  
  late CollectionReference<Map<String, dynamic>> firestore =
      FirebaseFirestore.instance.collection(collectionId.toString());
  TextEditingController title = TextEditingController();
  TextEditingController notes = TextEditingController();
  String t = "";
  String n = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 30.h),
        padding: EdgeInsets.all(16.r),
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
                InkWell(
                    onTap: () {
                      if (t.isNotEmpty || n.isNotEmpty) {
                        String id =
                            DateTime.now().millisecondsSinceEpoch.toString();
                        firestore
                            .doc(id)
                            .set({
                              'id': id,
                              'title': t,
                              'notes': n,
                              'date': DateFormat('dd-MM-yyyy – kk:mm:ss')
                                  .format(DateTime.now())
                                  .toString(),
                            })
                            .then((value) {})
                            .onError((error, stackTrace) {});
                        Navigator.pop(context);
                      }
                    },
                    child: Icon(Icons.done_outlined)),
              ],
            ),
          ),
          Divider(),
          TextField(
            onChanged: (value) => t = value,
            controller: title,
            style: TextStyle(
              fontSize: 22.sp,
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
                    TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold)),
          ),
          Divider(
            thickness: 2,
          ),
          SizedBox(
            height: 10.h,
          ),
          TextField(
            onChanged: (value) => n = value,
            controller: notes,
            style: TextStyle(
              fontSize: 18.sp,
              // fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 36, 34, 34),
            ),
            textInputAction: TextInputAction.newline,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            decoration: InputDecoration.collapsed(
              hintText: 'Notes',
            ),
          ),
        ]),
      ),
    );
  }
}
