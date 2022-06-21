import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:messenger/services/authentication.dart';

class Users {
  FirebaseFirestore instance = FirebaseFirestore.instance;

  createUser(name, email, uid) async {
    DocumentReference user = await instance
        .collection("users")
        .add({"name": name, "email": email, "userId": uid});
    return user;
  }

  getCurrentUser() async {
    QuerySnapshot userSnaps = await instance.collection("users").get();
    QueryDocumentSnapshot? user;
    for (var i in userSnaps.docs) {
      if ((i.data() as Map)["userId"] ==
          AuthService().instance.currentUser?.uid) {
        user = i;
      }
    }
    return user;
  }

  dynamic getUsers([String uid = ""]) async {
    if (uid == "") {
      QuerySnapshot userSnaps = await instance.collection("users").get();
      List users = [];
      for (var i in userSnaps.docs) {
        if ((i.data()! as Map)["userId"] !=
            AuthService().instance.currentUser?.uid) {
          users.add(i);
        }
      }
      return users;
    } else {
      DocumentReference user = instance.collection("users").doc(uid);
      return user;
    }
  }
}

class Messages {
  FirebaseFirestore instance = FirebaseFirestore.instance;

  createGroup(String user1, String user2) async {
    bool docExists = false;
    CollectionReference messages = instance.collection("groups");
    QuerySnapshot groups = await messages.get();
    for (var i in groups.docs) {
      Map data = i.data() as Map;
      if (data["users"].contains(user1) && data["users"].contains(user2)) {
        docExists = true;
      }
    }
    if (docExists == false) {
      DocumentReference group = await messages.add({
        "messages": [],
        "users": [user1, user2]
      });
      return group;
    }
  }

  sendMessage(message, sender, reciever) async {
    CollectionReference messages = instance.collection("groups");
    QuerySnapshot groups = await messages.get();
    QueryDocumentSnapshot? group;
    for (var i in groups.docs) {
      Map data = i.data() as Map;
      if (data["users"].contains(sender) && data["users"].contains(reciever)) {
        group = i;
      }
    }
    DocumentReference document = messages.doc(group!.id);
    List messageList = (group.data() as Map)["messages"];
    messageList.add({"message": message, "sender": sender});
    document.update({
      "messages": messageList,
    });
  }

  Stream get messages {
    CollectionReference messages = instance.collection("groups");
    return messages.snapshots();
  }
}