import 'package:demo1/controller/chat_service.dart';
import 'package:demo1/controller/login_controller.dart';
import 'package:demo1/view/chat_page.dart';
import 'package:demo1/view/drawer.dart';
import 'package:demo1/view/login.dart';
import 'package:demo1/view/profile.dart';
import 'package:demo1/view/user_tile.dart';
import 'package:demo1/widgents/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final ChatService _chatService = ChatService();
  final User_LoginController _user_loginController = User_LoginController();

  void logout(){
    final _user_loginController = User_LoginController();
    _user_loginController.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          title: CustomText(
            text: 'B r o C h a t',
            size: 20,
            weight: FontWeight.w700,
          ),
          // leading: Icon(Icons.message, color: Colors.white),
          // actions: [
          //   IconButton(
          //       onPressed: () {
          //         Navigator.push(context, MaterialPageRoute(builder: (context) => Profile(),));
          //       }, 
          //       icon: Icon(Icons.person, color: Colors.white)),
          //   IconButton(
          //       onPressed: () {
          //         showDialog(context: context, builder: (context) {
          //               return AlertDialog(
          //                 title: CustomText(text: 'LogOut', size: 20,weight: FontWeight.w600,color: Colors.black,),
          //                 content: CustomText(text: 'Are you sure your you want to logout?', size: 16, weight: FontWeight.normal, color: Colors.black),
          //       actions: [
          //         TextButton(onPressed: () {
          //           logout();
          //           Navigator.push(context, MaterialPageRoute(builder: (context) => Login(),));
          //         }, child: CustomText(text: 'yes', size: 16, weight: FontWeight.w400, color: Colors.black)),
          //         TextButton(onPressed: () {
          //           Navigator.pop(context);
          //         }, child: CustomText(text: 'no', size: 16, weight: FontWeight.w400, color: Colors.black))
          //       ]
          //               );
          //             },);
          //       }, 
          //       icon: Icon(Icons.logout, color: Colors.white))
          // ],
          backgroundColor: Color(0xFF009688),
        ),
        drawer: Mydrawer(),
        backgroundColor: Colors.black,
        body: _buildUserList(),
        
      ),
    );
  }

  Widget _buildUserList() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('Users').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text("Error loading users");
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        return ListView(
          children: snapshot.data!.docs.map((doc) {
            Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

            if (data['email'] == _user_loginController.getCurrentUser()!.email) {
              return Container();
            }

            return StreamBuilder<Map<String, dynamic>?>(
              stream: _chatService.getLatestMessageWithReadStatus(data['uid']),
              builder: (context, messageSnapshot) {
                String latestMessage = 'No messages yet';
                bool showUnread = false;

                if (messageSnapshot.hasData && messageSnapshot.data != null) {
                  var messageData = messageSnapshot.data!;
                  
                  // Check if message is unread and meant for current user
                  if (messageData['isRead'] != null && 
                      messageData['isRead'] == false &&
                      messageData['receiverID'] == _user_loginController.getCurrentUser()!.uid) {
                    showUnread = true;
                  }
                  
                  if (messageData['imageUrl'] != null) {
                    latestMessage = '📷 Image';
                  } else {
                    latestMessage = messageData['message'] ?? 'No messages yet';
                  }
                }

                return StreamBuilder(
                  stream: _chatService.getUnreadMessageCount(data['uid']),
                  builder: (context, unreadSnapshot) {
                    int unreadCount = unreadSnapshot.data ?? 0;
                    return Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: UserTile(
                        text: data['name'] ?? 'Unknown',
                        latestMessage: latestMessage,
                        showUnread: showUnread,
                        unreadCount: unreadCount,
                        profileImageUrl: data['profileImage'] ?? '',
                        onTap: () {
                          _chatService.markMessagesAsRead(data['uid']);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChatPage(
                                userData: data['name'] ?? 'Unknown',
                                receiverID: data['uid'] ?? '',
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }
                );
              },
            );
          }).toList(),
        );
      },
    );
}


}