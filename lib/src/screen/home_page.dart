import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:notes_app/src/screen/new_notes.dart';
import 'package:notes_app/src/screen/sign_in_page.dart';
import 'package:notes_app/src/screen/user_account.dart';
import 'package:notes_app/src/screen/view_notes.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:notes_app/src/util/app_constant.dart';
import 'package:notes_app/src/util/utils.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late String collectionId;
  bool loaded = true;
  // final user = FirebaseAuth.instance.currentUser!;
  bool searchBarTap = false;
  TextEditingController search = TextEditingController();
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   if (FirebaseAuth.instance.currentUser?.email != null) {
  //     // collectionId =FirebaseAuth.instance.currentUser.email!;
  //     loaded = true;
  //   }
  // }

  late Stream<QuerySnapshot<Map<String, dynamic>>> firestore = FirebaseFirestore
      .instance
      .collection(FirebaseAuth.instance.currentUser!.email!)
      .orderBy('date', descending: true)
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return loaded
        ? Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => NewNotes(
                              collectionId:
                                  FirebaseAuth.instance.currentUser!.email!,
                            )));
              },
              backgroundColor: AppConstant.theme,
              child: Icon(
                Icons.add,
                size: 29.sp,
              ),
            ),
            body: SafeArea(
              child: Column(
                children: [
                  Container(
                    // height: 50,
                    margin: EdgeInsets.all(10),
                    child: !searchBarTap
                        ? Container(
                            height: 40,
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'JustNotes',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22,
                                      color: Color.fromARGB(255, 2, 49, 90)),
                                ),
                                Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          searchBarTap = true;
                                        });
                                      },
                                      child: Icon(
                                        Icons.search_outlined,
                                        // color: AppConstant.c1,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => UserAccount(),
                                          ),
                                        );
                                      },
                                      child: const Icon(
                                        Icons.account_circle,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                        : TextField(
                            controller: search,
                            onChanged: ((value) {
                              setState(() {});
                            }),
                            decoration: InputDecoration(
                              focusColor: AppConstant.c1,
                              contentPadding:
                                  EdgeInsets.only(right: 10.w, left: 15.w),
                              hintText: 'Search your notes',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              suffixIcon: Icon(Icons.search_outlined),
                              suffixIconColor: AppConstant.c1,
                            ),
                            showCursor: false,
                          ),
                  ),
                  Divider(
                    thickness: 2,
                    endIndent: 10,
                    indent: 10,
                  ),
                  StreamBuilder<QuerySnapshot>(
                    stream: firestore,
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (snapshot.hasError) {
                        return Text('Some Error');
                      }

                      return Expanded(
                        child: MediaQuery.removePadding(
                          context: context,
                          removeTop: true,
                          child: ListView.builder(
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              final searchtitle = snapshot
                                  .data!.docs[index]['title']
                                  .toString();
                              final searchnotes = snapshot
                                  .data!.docs[index]['notes']
                                  .toString();
                              if (search.text.isEmpty) {
                                return InkWell(
                                  onTap: () {
                                    setState(() {
                                      searchBarTap = false;
                                    });
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => ViewNotes(
                                                  collectionId: FirebaseAuth
                                                      .instance
                                                      .currentUser!
                                                      .email!,
                                                  notes: snapshot.data!
                                                      .docs[index]['notes']
                                                      .toString(),
                                                  title: snapshot.data!
                                                      .docs[index]['title']
                                                      .toString(),
                                                  i: index,
                                                )));
                                  },
                                  child: Container(
                                    height: 95.h,
                                    margin: EdgeInsets.all(8),
                                    padding: EdgeInsets.all(20),
                                    decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 236, 252, 255),
                                      borderRadius: BorderRadius.circular(20.r),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.2),
                                          spreadRadius: 2,
                                          blurRadius: 2,
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      // mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${snapshot.data!.docs[index]['title'].toString()}',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18.sp,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        SizedBox(
                                          height: 5.h,
                                        ),
                                        Text(
                                          '${snapshot.data!.docs[index]['notes'].toString()}',
                                          style: TextStyle(
                                            // color: Colors.black,
                                            // fontWeight: FontWeight.bold,
                                            fontSize: 15.sp,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        SizedBox(
                                          height: 5.h,
                                        ),
                                        Text(
                                          'Last edited: ${snapshot.data!.docs[index]['date'].toString()}',
                                          style: TextStyle(
                                            // color: Colors.black,
                                            // fontWeight: FontWeight.bold,
                                            fontSize: 10.sp,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              } else if (searchtitle.toLowerCase().contains(
                                      search.text.toLowerCase().toString()) ||
                                  searchnotes.toLowerCase().contains(
                                      search.text.toLowerCase().toString())) {
                                return InkWell(
                                  onTap: () {
                                    setState(() {
                                      searchBarTap = false;
                                    });
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ViewNotes(
                                          collectionId: FirebaseAuth
                                              .instance.currentUser!.email!,
                                          notes: snapshot
                                              .data!.docs[index]['notes']
                                              .toString(),
                                          title: snapshot
                                              .data!.docs[index]['title']
                                              .toString(),
                                          i: index,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    height: 95.h,
                                    margin: EdgeInsets.all(8),
                                    padding: EdgeInsets.all(20),
                                    decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 236, 252, 255),
                                      borderRadius: BorderRadius.circular(20.r),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.grey.withOpacity(0.2),
                                            spreadRadius: 2,
                                            blurRadius: 2),
                                      ],
                                    ),
                                    child: Column(
                                      // mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${snapshot.data!.docs[index]['title'].toString()}',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18.sp,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        SizedBox(
                                          height: 5.h,
                                        ),
                                        Text(
                                          '${snapshot.data!.docs[index]['notes'].toString()}',
                                          style: TextStyle(
                                            // color: Colors.black,
                                            // fontWeight: FontWeight.bold,
                                            fontSize: 15.sp,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        SizedBox(
                                          height: 5.h,
                                        ),
                                        Text(
                                          'Last edited: ${snapshot.data!.docs[index]['date'].toString()}',
                                          style: TextStyle(
                                            // color: Colors.black,
                                            // fontWeight: FontWeight.bold,
                                            fontSize: 10.sp,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              } else {
                                return Container();
                              }
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          )
        : Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
  }
}
