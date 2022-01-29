
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:istreamo/bloc/user_bloc.dart';
import 'package:istreamo/bloc/user_events.dart';
import 'package:istreamo/bloc/user_states.dart';
import 'package:istreamo/component/loading_shimmer.dart';
import 'package:istreamo/component/my_edit_field.dart';
import 'package:istreamo/component/users_detail.dart';
import 'package:istreamo/repo/database_repo.dart';
import 'package:istreamo/repo/notification_api.dart';
import 'package:sqflite/sqflite.dart';

class UserClass extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return UserClassState();
  }
}

class UserClassState extends State<UserClass> {
  final TextEditingController _searchController = TextEditingController();
  Database db;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initializeDataBase();
    _loadUsers();
    NotificationApi.init();
    _listenNotification();
  }

  Future<void> _initializeDataBase() async {
    await Repository().open();
    db = Repository().db;
  }

  void _listenNotification() =>
      NotificationApi.onNotifications.stream.listen(_onClickNotification);

  void _onClickNotification(String payload) =>
      Fluttertoast.showToast(msg: '$payload Notification clicked');

  _loadUsers() async => context.read<UsersBloc>().add(FetchUsers());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocBuilder<UsersBloc, UsersState>(
            builder: (BuildContext contex, UsersState state) {
          if (state is UsersListErrorstate) {
            final error = state.error;
            String message = '${error.message}\nTap to Retry.';
            return Text(
              message,
            );
          }
          if (state is UsersLoadingState) {
            return buildShimmer(context);
          }
          if (state is UsersLoadedState) {
            var users = state.users;
            return Column(
              children: [
                Padding(
                    padding: const EdgeInsets.all(10),
                    child: buildHeader(_searchController, context,
                        MediaQuery.of(context).size)),
                Expanded(child: buildList(context, users, null)),
              ],
            );
          }
          if (state is UsersSearchingState) {
            var searchedUsers = state.searchedUsers;
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: buildHeader(
                      _searchController, context, MediaQuery.of(context).size),
                ),
                Expanded(
                    child: buildList(context, null, searchedUsers,
                        isFromSearchedData: true)),
              ],
            );
          }
          if(state is UserTappedNotification) {
            _loadUsers();
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        }),
        floatingActionButton: InkWell(
          splashColor: Colors.yellow,
          onTap: () => context.read<UsersBloc>().add(ShowNotification()),
          child: Container(
            height: 50,
            width: 200,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20), color: Colors.pink),
            child: const Center(child: Text('Simple Notification')),
          ),
        ),
      ),
    );
  }
}
