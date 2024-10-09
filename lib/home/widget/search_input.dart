import 'package:flutter/material.dart';

class SearchInput extends StatelessWidget {

  final tagsList=["Blood Glucose","Urine Culture","Urine Drug Test"];

   SearchInput({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 25, left: 25, right: 25),
      child: Column(
        children: [
          Row(
            children: [
              Flexible(
                flex: 1,
                child: TextField(
                  cursorColor: Colors.grey,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none
                    ),
                    hintText: 'Search',
                    hintStyle: const TextStyle(
                      color: Colors.grey,
                      fontSize: 18
                    ),
                    prefixIcon: const Icon(Icons.search,
                      color: Colors.grey
                    )
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 10),
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.cyan,
                  borderRadius: BorderRadius.circular(15)
                ),
                child: const Icon(
                    Icons.manage_search_rounded,
                  color: Colors.white,
                ),
              )
            ],
          ),
          Row(
            children:
              tagsList.map((e) => Container(
                margin: const EdgeInsets.only(top: 10, right: 10),
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.cyan.withOpacity(0.3)
                ),
                child: Text(e,
                style: const TextStyle(
                  color: Colors.grey
                ),),
              ))
              .toList(),
          ),
        ],
      ),
    );
  }
}
