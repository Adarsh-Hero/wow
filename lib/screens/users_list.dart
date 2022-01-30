import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:istreamo/bloc/user_bloc.dart';
import 'package:istreamo/bloc/user_events.dart';
import 'package:istreamo/bloc/user_states.dart';
import 'package:istreamo/client/hive_names.dart';
import 'package:istreamo/component/loading_shimmer.dart';
import 'package:istreamo/model/userRepo.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class UserRepoHome extends StatefulWidget {
  const UserRepoHome({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return UserRepoHomeState();
  }
}

class UserRepoHomeState extends State<UserRepoHome> {
  StreamSubscription _subscription;
  bool _isOnline = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scrollcontroller.addListener(pagination);
    _initializeDataBase();
    _subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      _isOnline = result == ConnectivityResult.none ? false : true;
      _isOnline?_loadUsersFromNetwork():_loadUsersFromDataBase();
     setState(() {});
    });
  }

  @override
  dispose() {
    super.dispose();
    _subscription.cancel();
  }

  Future<void> _initializeDataBase() async {
    await Hive.openBox<UserRepo>(HiveBoxes.userRepo);
  }

  _loadUsersFromNetwork() async =>
      context.read<UsersBloc>().add(FetchUserReposFromNetwork());
  _loadUsersFromDataBase() async =>
      context.read<UsersBloc>().add(FetchUserReposFromDataBase());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white70,
        appBar: AppBar(
          title: const Text("Jake's Git"),
          backgroundColor: Colors.blueGrey,
        ),
        body: BlocBuilder<UsersBloc, UsersState>(
            builder: (BuildContext context, UsersState state) {
          if (state is UsersListErrorState) {
            final error = state.error;
            String message = '${error.message}\nTap to Retry.';
            return Text(
              message,
            );
          }
          if (state is UsersLoadingState) {
            return buildShimmer(context);
          }
          if (state is UserReposFromNetworkLoadedState) {
            _isOnline=true;
            return buildList(context, state.users, null);
          }
          if (state is DatabaseUserRepoLoaded ) {
            var searchedUsers = state.databaseUsers;
            _isOnline = false;
            return buildList(context, null, searchedUsers,
                isFromSearchedData: true);
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        } , ),
        bottomSheet: !_isOnline
            ? Container(
               height:40 ,
                color: Colors.grey,
                width: MediaQuery.of(context).size.width,
                child: const Center(
                  child: Text(
                    'Connect internet to get updated records',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              )
            :null
      ),
    );
  }
  final scrollcontroller = ScrollController();

  void pagination() {
    if (scrollcontroller.position.pixels ==
        scrollcontroller.position.maxScrollExtent) {
     _loadUsersFromNetwork();
    }
  }
  Widget buildList(
      BuildContext context, List<UserRepo> userRepos, List searchedUser,
      {isFromSearchedData = false}) {
    return ListView.builder(
      controller: scrollcontroller,
      itemCount: isFromSearchedData?searchedUser.length:userRepos.length,
      itemBuilder: (_, index) {
        var userRepo =
        isFromSearchedData ? searchedUser[index] : userRepos[index];

        return Container(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20), color: Colors.white),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.grey),
                      height: 100,
                      width: 70,
                      child: CircleAvatar(
                        child: CachedNetworkImage(
                          imageUrl: "${userRepo.owner.avatarUrl}",
                          placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${userRepo.name}",
                              style: const TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 10,),
                            SizedBox(
                              width: MediaQuery.of(context).size.width - 150,
                              child: Text(
                                "${userRepo.description}",
                                style: const TextStyle(
                                  fontSize: 10,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width - 150,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(Icons.unfold_less),
                                      Text(
                                        "${userRepo.language}",
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Theme.of(context)
                                              .textTheme
                                              .bodyText1
                                              .color,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Icon(Icons.android_rounded),
                                      Text(
                                        "${userRepo.forksCount}",
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Theme.of(context)
                                              .textTheme
                                              .bodyText1
                                              .color,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "id: ${userRepo.id}",
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyText1
                                          .color,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
