import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:istreamo/bloc/user_bloc.dart';
import 'package:istreamo/bloc/user_events.dart';

Widget buildHeader(
    TextEditingController controller, BuildContext context, Size size) {
  return Container(
    height: 50,
    decoration: BoxDecoration(
      color: Colors.white,
      boxShadow: const [BoxShadow(color: Colors.brown, spreadRadius: 5)],
      borderRadius: BorderRadius.circular(20),
    ),
    child: Row(
      children: [
        const SizedBox(
          width: 10,
        ),
        const Icon(Icons.search),
        const SizedBox(
          width: 10,
        ),
        SizedBox(
          width: size.width * .70,
          height: size.height * 0.08,
          child: TextFormField(
            initialValue: controller != null ? null : 'Enter 3 char',
            controller: controller,
            onChanged: (searchedPhrase) async {
              if (controller.text.isEmpty) {
                context.read<UsersBloc>().add(FetchUsers());
              }
              if (searchedPhrase.length > 2) {
                context
                    .read<UsersBloc>()
                    .add(StartSearch(searchPrhase: searchedPhrase));
              }
            },
            style: const TextStyle(
              color: Colors.brown,
            ),
          ),
        ),
        controller.text != ''
            ? Container(
                child: IconButton(
                    icon: const Icon(Icons.cancel),
                    onPressed: () {
                      controller.text = '';
                      context.read<UsersBloc>().add(FetchUsers());
                    }),
              )
            : Container(),
      ],
    ),
  );
}
