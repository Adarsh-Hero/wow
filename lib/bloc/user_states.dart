import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:istreamo/model/userRepo.dart';

abstract class UsersState extends Equatable {
  @override
  List<Object> get props => [];
}

class UsersLoadingState extends UsersState {}

class UsersInitialState extends UsersState {}

class UserReposFromNetworkLoadedState extends UsersState {
  final List<UserRepo> users;
  UserReposFromNetworkLoadedState({@required this.users});
}

class DatabaseUserRepoLoaded extends UsersState {
  final List<UserRepo> databaseUsers;
  DatabaseUserRepoLoaded({@required this.databaseUsers});
}

class UsersListErrorState extends UsersState {
  final error;
  UsersListErrorState({this.error});
}

