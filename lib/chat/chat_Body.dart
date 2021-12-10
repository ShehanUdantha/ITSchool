import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:itschool/model/user_model.dart';

class ChatRoom extends StatefulWidget {
  ChatRoom({required this.title, required this.loggedInUser});

  final title;
  final UserModel loggedInUser;
  @override
  State<ChatRoom> createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  late CollectionReference nRef;

  @override
  void initState() {
    super.initState();
    nRef =
        _firestore.collection('chats').doc('divder').collection(widget.title);
    setState(() {});
  }

  final TextEditingController _message = TextEditingController();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void onSendMessage() async {
    if (_message.text.isNotEmpty) {
      Map<String, dynamic> chatData = {
        "sendBy": widget.loggedInUser.firstName,
        'id': widget.loggedInUser.indexNo,
        "message": _message.text,
        "type": "text",
        "time": FieldValue.serverTimestamp(),
      };

      _message.clear();

      await _firestore
          .collection('chats')
          .doc('divder')
          .collection(widget.title)
          .add(chatData);
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          (widget.title),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: size.height / 1.29,
              width: size.width,
              child: StreamBuilder<QuerySnapshot>(
                stream: nRef.orderBy('time').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        Map<String, dynamic> chatMap =
                            snapshot.data!.docs[index].data()
                                as Map<String, dynamic>;

                        return messageTile(
                            chatMap, size, context, snapshot, index);
                      },
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            ),
            Container(
              height: size.height / 10,
              width: size.width,
              alignment: Alignment.center,
              child: Container(
                height: size.height / 12,
                width: size.width / 1.1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: size.height / 17,
                      width: size.width / 1.29,
                      child: Scrollbar(
                        child: TextField(
                          controller: _message,
                          decoration: InputDecoration(
                              hintText: "Send Message",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              )),
                        ),
                      ),
                    ),
                    IconButton(
                        icon: Icon(Icons.send),
                        color: Color(0xff0b3140),
                        onPressed: onSendMessage),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Builder messageTile(
      Map<String, dynamic> chatMap,
      Size size,
      BuildContext context,
      AsyncSnapshot<QuerySnapshot<Object?>> snapshot,
      int index) {
    return Builder(builder: (_) {
      if (chatMap['type'] == "text") {
        return Container(
          width: size.width,
          alignment: chatMap['sendBy'] == widget.loggedInUser.firstName
              ? Alignment.centerRight
              : Alignment.centerLeft,
          child: InkWell(
            child: Container(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 14),
                margin: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: chatMap['sendBy'] == widget.loggedInUser.firstName
                      ? Color(0xff00bfa5)
                      : Color(0xff12526c),
                ),
                child: Column(
                  children: [
                    Text(
                      chatMap['sendBy'] + '  ' + chatMap['id'],
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: size.height / 250,
                    ),
                    Text(
                      chatMap['message'],
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ],
                )),
            onTap: () {
              chatMap['sendBy'] == widget.loggedInUser.firstName
                  ? showDialog(
                      context: context,
                      builder: (context) => Dialog(
                            child: Container(
                              width: 100.0,
                              decoration: new BoxDecoration(
                                shape: BoxShape.rectangle,
                                color: const Color(0xFFFFFF),
                                borderRadius: new BorderRadius.all(
                                    new Radius.circular(30.0)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ListView(
                                  shrinkWrap: true,
                                  children: <Widget>[
                                    Text(
                                      "Delete Message",
                                      style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                          fontSize: 20,
                                          color: Color(0xFF3C4046),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 20),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          110, 0, 0, 0),
                                      child: Row(
                                        children: [
                                          InkWell(
                                            child: Text(
                                              "Ok",
                                              style: GoogleFonts.poppins(
                                                textStyle: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.grey,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            onTap: () {
                                              snapshot
                                                  .data!.docs[index].reference
                                                  .delete();

                                              Navigator.pop(context);
                                            },
                                          ),
                                          SizedBox(width: 50),
                                          InkWell(
                                            child: Text(
                                              "Cancel",
                                              style: GoogleFonts.poppins(
                                                textStyle: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.grey,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            onTap: () {
                                              Navigator.pop(context);
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                  ],
                                ),
                              ),
                            ),
                          ))
                  : null;
            },
          ),
        );
      } else {
        return SizedBox();
      }
    });
  }
}
