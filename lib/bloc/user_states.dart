import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:istreamo/model/userRepo.dart';

abstract class UsersState extends Equatable {
  @override
  List<Object> get props => [];
}

class UsersLoadingState extends UsersState {}

class UsersInitialState extends UsersState {}

class UsersLoadedState extends UsersState {
  final List<UserRepo> users;
  UsersLoadedState({@required this.users});
}

class UsersSearchingState extends UsersState {
  final List<Map> searchedUsers;
  UsersSearchingState({@required this.searchedUsers});
}

class UsersListErrorstate extends UsersState {
  final error;
  UsersListErrorstate({this.error});
}

class UserTappedNotification extends UsersState {}
