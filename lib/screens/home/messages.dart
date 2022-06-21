import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:messenger/shared/constants.dart';
import 'package:messenger/services/database.dart' as data;

class Messages extends StatefulWidget {
  final String user1;
  final String user2;
  const Messages({Key? key, required this.user1, required this.user2})
      : super(key: key);

  @override
  State<Messages> createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  late String message = "";

  final key = GlobalKey<FormState>();
  final textController = TextEditingController();
  final scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Messages"),
        actions: [
          IconButton(
            onPressed: () {
              scrollController.animateTo(
                  scrollController.position.minScrollExtent,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.ease);
            },
            icon: const Icon(Icons.arrow_upward_rounded),
            color: Colors.white,
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
                vertical: 5, horizontal: 3),
            margin: const EdgeInsets.symmetric(
                vertical: 5, horizontal: 5),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 110, 21, 145),
                borderRadius: const BorderRadius.all(
                    Radius.circular(10)),
                border: Border.all(
                  width: 5,
                  color: const Color.fromARGB(255, 48, 18, 97)
                )
              ),
            child: const Text(
              "All Messages",
              style: TextStyle(
                  fontSize: 15, letterSpacing: 1),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              controller: scrollController,
              child: StreamBuilder(
                  stream: data.Messages().messages,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      Map data = (snapshot.data as QuerySnapshot).docs[0].data()
                          as Map;
                      if (data["messages"].length != 0) {
                        return SingleChildScrollView(
                          physics: const ScrollPhysics(),
                          child: Column(
                            children: [
                              ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemCount: data["messages"].length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 3),
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 7, horizontal: 5),
                                    
                                    decoration: BoxDecoration(
                                        color: List.from(data["messages"].reversed)[index]
                                                    ["sender"] ==
                                                widget.user1
                                            ? const Color.fromARGB(
                                                255, 19, 18, 18)
                                            : Colors.purple,
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10)),
                                        border: Border.all(
                                          width: 2,
                                          color: List.from(data["messages"].reversed)[index]
                                                      ["sender"] ==
                                                  widget.user1
                                              ? Colors.black
                                              : Colors.purple,
                                        )),
                                    child: Text(
                                      List.from(data["messages"].reversed)[index]["message"],
                                      style: const TextStyle(
                                          fontSize: 15, letterSpacing: 1),
                                      textAlign: TextAlign.center,
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        );
                      }
                    }
                    return Container();
                  }),
            ),
          ),
          Form(
            key: key,
            child: Row(
              children: [
                Flexible(
                  child: TextFormField(
                    controller: textController,
                    onChanged: ((value) {
                      setState(() {
                        message = value;
                      });
                    }),
                    validator: ((value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter a message";
                      }
                      return null;
                    }),
                    decoration: textInputDecoration.copyWith(
                        hintText: "Write a Message"),
                  ),
                ),
                Container(
                  color: Colors.purple,
                  child: IconButton(
                    onPressed: () async {
                      data.Messages instance = data.Messages();
                      await instance.createGroup(widget.user1, widget.user2);
                      if (key.currentState!.validate()) {
                        await instance.sendMessage(
                            message, widget.user1, widget.user2);
                      }
                      setState(() {
                        textController.value = TextEditingValue.empty;
                        message = "";
                      });
                    },
                    icon: const Icon(
                      Icons.send,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
