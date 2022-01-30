import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:istreamo/bloc/user_events.dart';
import 'package:istreamo/bloc/user_states.dart';
import 'package:istreamo/client/hive_names.dart';
import 'package:istreamo/model/userRepo.dart';
import 'package:istreamo/repo/network_call.dart';

class UsersBloc extends Bloc<UsersEvents, UsersState> {
  final UserRepository usersRepository;
  final List<UserRepo> _users = [];
  final List<UserRepo> _searchedUsers=[];
  int _pageNumber = 0;



  UsersBloc({@required this.usersRepository}) : super(UsersInitialState());

  @override
  Stream<UsersState> mapEventToState(UsersEvents event) async* {
    if (event is FetchUserReposFromNetwork) {
      _pageNumber++;
        yield UsersLoadingState();
      try {
        _users.addAll( await UserRepository.getUser(_pageNumber));
        _users.isEmpty? add(FetchUserReposFromDataBase()):null;
        if(_users.isNotEmpty){
          _searchedUsers.clear();
          _saveData(_users);
        }
        yield UserReposFromNetworkLoadedState(users: _users);
      } on SocketException {
        yield UsersListErrorState(
          error: ('No Internet'),
        );
      } on HttpException {
        yield UsersListErrorState(
          error: ('No Service'),
        );
      } on FormatException {
        yield UsersListErrorState(
          error: ('No Format Exception'),
        );
      } catch (e) {
        yield UsersListErrorState(
          error: ('Un Known Error ${e.toString()}'),
        );
      }
    } else if (event is FetchUserReposFromDataBase) {
      await _getSearchedUsers();
      yield DatabaseUserRepoLoaded(databaseUsers: _searchedUsers);
    }
  }


  _saveData(List<UserRepo> data) async {
    for (var item in data) {
      Box<UserRepo> contactsBox = Hive.box<UserRepo>(HiveBoxes.userRepo);
      contactsBox.add(UserRepo(
          description: item.description,
          forksCount: item.forksCount,
          id: item.id,
          fullName: item.fullName,
          language: item.language,
          name: item.name,
          owner: item.owner));
    }
  }

  _getSearchedUsers() async {
    Box<UserRepo> data = Hive.box<UserRepo>(HiveBoxes.userRepo);
    if (data.values.isEmpty)return;
    for(var item in data.values){
      _searchedUsers.add(item);
    }
  }
}
