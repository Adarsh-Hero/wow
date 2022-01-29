enum UserEvents { fetchUsers, showNotification, startSearch }

abstract class UsersEvents {}

class FetchUsers extends UsersEvents {}

class ShowNotification extends UsersEvents {}

class StartSearch extends UsersEvents {
  final searchPrhase;
  StartSearch({this.searchPrhase});
}
