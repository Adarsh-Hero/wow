import 'package:flutter/material.dart';
import 'package:istreamo/model/userRepo.dart';

Widget buildList(
    BuildContext context, List<UserRepo> userRepos, List searchedUser,
    {isFromSearchedData = false}) {
  if (isFromSearchedData) {
    searchedUser = searchedUser.sublist(0, 1);
  }
  return ListView.builder(
    itemCount: isFromSearchedData ? searchedUser.length : userRepos.length,
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
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.purple),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  isFromSearchedData
                      ? Text('Name: ${userRepo['name']}',
                          style: TextStyle(
                            fontSize: 20,
                            color: Theme.of(context).textTheme.bodyText1.color,
                          ))
                      : Text(
                          'Name: ${userRepo.description}',
                          style: TextStyle(
                            fontSize: 20,
                            color: Theme.of(context).textTheme.bodyText1.color,
                          ),
                        ),
                  Divider(
                    color: Theme.of(context).textTheme.bodyText1.color,
                  ),
                  isFromSearchedData
                      ? Text('User Name: ',
                          style: TextStyle(
                            fontSize: 20,
                            color: Theme.of(context).textTheme.bodyText1.color,
                          ))
                      : Text(
                          'User Name: ${userRepo.language}',
                          style: TextStyle(
                            fontSize: 20,
                            color: Theme.of(context).textTheme.bodyText1.color,
                          ),
                        ),
                  Divider(
                    color: Theme.of(context).textTheme.bodyText1.color,
                  ),
                  isFromSearchedData
                      ? Text('email: }',
                          style: TextStyle(
                            fontSize: 20,
                            color: Theme.of(context).textTheme.bodyText1.color,
                          ))
                      : Text(
                          'email: ${userRepo.email}',
                          style: TextStyle(
                            fontSize: 20,
                            color: Theme.of(context).textTheme.bodyText1.color,
                          ),
                        ),
                  Divider(
                    color: Theme.of(context).textTheme.bodyText1.color,
                  ),
                  isFromSearchedData
                      ? Text(
                          'Phone no:}',
                          style: TextStyle(
                            fontSize: 20,
                            color: Theme.of(context).textTheme.bodyText1.color,
                          ),
                        )
                      : Text(
                          'Phone no: ${userRepo.owner.avatarUrl}',
                          style: TextStyle(
                            fontSize: 20,
                            color: Theme.of(context).textTheme.bodyText1.color,
                          ),
                        ),
                  Divider(
                    color: Theme.of(context).textTheme.bodyText1.color,
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
