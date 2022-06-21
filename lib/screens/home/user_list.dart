import 'package:flutter/material.dart';
import 'package:messenger/services/database.dart';
import 'messages.dart' as message;
import 'package:messenger/shared/loading.dart';

class UserList extends StatelessWidget {
  const UserList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Users().getUsers(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          List users = snapshot.data as List;
          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: ListTile(
                  tileColor: const Color.fromARGB(255, 29, 28, 28),
                  textColor: const Color.fromARGB(255, 255, 255, 255),
                  onTap: () async {
                    var user1 = await Users().getCurrentUser();
                    // ignore: use_build_context_synchronously
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return message.Messages(
                          user1: user1.data()["email"], user2: users[index].data()["email"]);
                    }));
                  },
                  title: Text(users[index].data()["name"]),
                  subtitle: Text(users[index].data()["email"]),
                ),
              );
            },
          );
        } else {
          return const Loading();
        }
      },
    );
  }
}
