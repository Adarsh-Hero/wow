import 'dart:io';


import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:istreamo/bloc/user_events.dart';
import 'package:istreamo/bloc/user_states.dart';
import 'package:istreamo/model/userRepo.dart';
import 'package:istreamo/repo/database_repo.dart';
import 'package:istreamo/repo/network_call.dart';
import 'package:istreamo/repo/notification_api.dart';
import 'package:sqflite/sqflite.dart';

class UsersBloc extends Bloc<UsersEvents, UsersState> {
  final UserRepository usersRepository;
  List<UserRepo> _users;
  List<Map> _searchedUsers;

  Database db;

  UsersBloc({@required this.usersRepository}) : super(UsersInitialState());

  @override
  Stream<UsersState> mapEventToState(UsersEvents event) async* {
    if (event is FetchUsers) {
      await _initializeDataBase();
      yield UsersLoadingState();

      try {
        _users = await UserRepository.getUser();
        _saveData(_users);
        yield UsersLoadedState(users: _users);
      } on SocketException {
        yield UsersListErrorstate(
          error: ('No Internet'),
        );
      } on HttpException {
        yield UsersListErrorstate(
          error: ('No Service'),
        );
      } on FormatException {
        yield UsersListErrorstate(
          error: ('No Format Exception'),
        );
      } catch (e) {
        yield UsersListErrorstate(
          error: ('Un Known Error ${e.toString()}'),
        );
      }
    } else if (event is StartSearch) {
      await _getSearchedUsers(event.searchPrhase);
      yield UsersSearchingState(searchedUsers: _searchedUsers);
    } else if (event is ShowNotification) {
      await _showNotification();
      yield UserTappedNotification();
    }
  }

  Future<void> _initializeDataBase() async {
    await Repository().open();
    db = Repository().db;
  }

  Future<void> _showNotification() async {
    await NotificationApi.showNotification(
        id: 0,
        title: "Adarsh's simple Notification",
        body: "Hey there! This notification was created by Adarsh",
        payload: 'Adarsh.Ag');
  }

  _saveData(data) async {
    for (var item in data) {
      // await UserRepo.insert(db, item);
    }
  }

  _getSearchedUsers(searchedPhrase) async {
    // _searchedUsers =
    //     await UserRepo.getItems(db, name: searchedPhrase, id: searchedPhrase);
  }
}
