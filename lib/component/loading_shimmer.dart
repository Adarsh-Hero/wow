import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Widget buildShimmer(BuildContext context) {
  return SizedBox(
    height: MediaQuery.of(context).size.height * .75,
    width: MediaQuery.of(context).size.width,
    child: GridView.count(
        crossAxisCount: 1,
        padding: const EdgeInsets.all(0),
        children: List.generate(10, (index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              enabled: true,
              child: Container(
                height: MediaQuery.of(context).size.width * .35,
                width: MediaQuery.of(context).size.height * .65,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
              ),
            ),
          );
        })),
  );
}
