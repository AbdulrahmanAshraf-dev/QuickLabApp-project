import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class RecentScreen extends StatelessWidget {
  const RecentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            titleRecent(),
            SizedBox(
              height: 5.h,
            ),
            Expanded(
              child: listOfRecent(),
            )
          ],
        ),
      ),
    );
  }

  ListView listOfRecent() {
    return ListView.builder(
      itemCount: 30,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Slidable(
            startActionPane:
                ActionPane(motion: const ScrollMotion(), children: [
              SlidableAction(
                borderRadius: const BorderRadius.all(Radius.circular(12)),
                onPressed: (context) {},
                backgroundColor: const Color(0xFFFE4A49),
                foregroundColor: Colors.white,
                icon: Icons.delete,
                label: 'Delete',
              ),
            ]),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.cyan)),
                child: ListTile(
                  leading: const CircleAvatar(),
                  title: Text(
                    "Blood Report",
                    style:
                        TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                  ),
                  subtitle: const Text("PDF"),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget titleRecent() {
    return SizedBox(
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.access_time,
            color: Colors.black,
            size: 30,
          ),
          SizedBox(
            width: 10.w,
          ),
          Text(
            "Recent",
            style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black),
          ),
        ],
      ),
    );
  }
}
