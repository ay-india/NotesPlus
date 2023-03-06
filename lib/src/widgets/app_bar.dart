import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Appbar extends StatefulWidget {
  const Appbar({super.key});

  @override
  State<Appbar> createState() => _AppbarState();
}

class _AppbarState extends State<Appbar> {
  TextEditingController searchContrller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(
        vertical: 37.h,
        horizontal: 13.w,
      ),
      height: 36.h,
      padding: EdgeInsets.all(10.r),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.r),
        color: Color.fromARGB(255, 165, 191, 212),
      ),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(
          'Search for notes',
          style: TextStyle(
            fontSize: 16,
          ),
        ),
        Icon(
          Icons.account_circle,
          size: 25.sp,
        )
      ]),
    );
  }
}
