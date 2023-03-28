import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ViewNotes extends StatefulWidget {
  String title;
  String notes;
  int i;
  ViewNotes(
      {super.key, required this.notes, required this.title, required this.i});

  @override
  State<ViewNotes> createState() =>
      _ViewNotesState(nnotes: notes, tit: title, i: i);
}

class _ViewNotesState extends State<ViewNotes> {
  String tit;
  String nnotes;
  int i;
  _ViewNotesState({required this.nnotes, required this.tit, required this.i});
  final firestore = FirebaseFirestore.instance
      .collection('notes')
      .orderBy('date', descending: true)
      .snapshots();
  CollectionReference ref = FirebaseFirestore.instance.collection('notes');
  TextEditingController title = TextEditingController();
  TextEditingController notes = TextEditingController();

  String t = "";
  String n = "";

  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      t = tit;
      title.text = tit;
      n = nnotes;
      notes.text = nnotes;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 30.h),
        padding: EdgeInsets.all(16.r),
        // color: Colors.red,
        child: StreamBuilder<QuerySnapshot>(
            stream: firestore,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              return Column(
                children: [
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
                              print(t);
                              if (t.isNotEmpty || n.isNotEmpty) {
                                String id = DateTime.now()
                                    .millisecondsSinceEpoch
                                    .toString();

                                ref
                                    .doc(
                                        snapshot.data!.docs[i]['id'].toString())
                                    .update({
                                      'title': t,
                                      'notes': n,
                                      'date':
                                          DateFormat('dd-MM-yyyy – kk:mm:ss')
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
                        hintStyle: TextStyle(
                            fontSize: 22.sp, fontWeight: FontWeight.bold)),
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
                ],
              );
            }),
      ),
    );
  }
}
