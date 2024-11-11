import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo1/controller/chat_service.dart';
import 'package:demo1/controller/login_controller.dart';
import 'package:demo1/widgents/custom_TextFeild.dart';
import 'package:demo1/widgents/custom_text.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ChatPage extends StatefulWidget {
  final String userData;
  final String receiverID;

  ChatPage({super.key, required this.userData, required this.receiverID});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final ChatService _chatService = ChatService();
  final User_LoginController _user_loginController = User_LoginController();
  final ScrollController _scrollController = ScrollController();
   final ImagePicker _imagePicker = ImagePicker();

  void sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      await _chatService.sendMessage(widget.receiverID, _messageController.text);
      _messageController.clear();
      _scrollToBottom();
    }
  }
  

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  Future<void> _pickAndSendImage() async {
  try {
    final XFile? pickedFile = await _imagePicker.pickImage(source: ImageSource.gallery);
    print("Picked file: ${pickedFile?.path}"); // Debug print

    if (pickedFile != null) {
      final File imageFile = File(pickedFile.path);
      
      // Check if file exists
      if (!await imageFile.exists()) {
        print("File doesn't exist!");
        return;
      }

      // Upload to firebase
      final String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      final Reference storageRef = FirebaseStorage.instance
          .ref()
          .child('chat_images') // Changed from chat_image to chat_images
          .child('$fileName.jpg'); // Added file extension

      // Show loading indicator
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
          child: CircularProgressIndicator(),
        ),
      );

      try {
        final UploadTask uploadTask = storageRef.putFile(imageFile);
        
        // Monitor upload progress
        uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
          print('Upload progress: ${snapshot.bytesTransferred}/${snapshot.totalBytes}');
        });

        final TaskSnapshot taskSnapshot = await uploadTask;
        final String imageUrl = await taskSnapshot.ref.getDownloadURL();
        print("Image URL: $imageUrl"); // Debug print

        // Hide loading indicator
        Navigator.of(context, rootNavigator: true).pop();

        // Send image URL as message
        await _chatService.sendMessage(widget.receiverID, '', imageUrl);
      } catch (uploadError) {
        // Hide loading indicator
        Navigator.of(context, rootNavigator: true).pop();
        print("Upload error: $uploadError");
        
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Failed to upload image")),
        );
      }
    }
  } catch (e) {
    print("Error picking image: $e");
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Error selecting image")),
    );
  }
}

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: CustomText(
            text: widget.userData,
            size: 18,
            weight: FontWeight.w800,
            color: Colors.white,
          ),
          centerTitle: true,
          backgroundColor: const Color(0xFF009688),
        ),
        backgroundColor: Colors.black,
        body: Column(
          children: [
            Expanded(
              child: _buildMessageList(),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _buildUserInput(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageList() {
    String senderID = _user_loginController.getCurrentUser()!.uid;

    return StreamBuilder<QuerySnapshot>(
      stream: _chatService.getMessages(widget.receiverID, senderID),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text("No messages yet."));
        }

        WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());

        return ListView.builder(
          controller: _scrollController,
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            return _buildMessageItem(snapshot.data!.docs[index]);
          },
        );
      },
    );
  }

  Widget _buildMessageItem(DocumentSnapshot doc) {
  Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
  bool isCurrentUser = data['senderID'] == _user_loginController.getCurrentUser()!.uid;

  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
    child: Align(
      alignment: isCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
      child: data['imageUrl'] != null 
      ? Container(
          margin: const EdgeInsets.only(top: 8, bottom: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isCurrentUser ? Colors.green[300]! : Colors.grey[300]!,
              width: 2,
            ),
            color: isCurrentUser ? Colors.green[50] : Colors.grey[50],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: GestureDetector(
              onTap: () {
                // Show full-screen image dialog when tapped
                showDialog(
                  context: context,
                  builder: (context) => Dialog(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Stack(
                            children: [
                              Image.network(
                                data['imageUrl'],
                                fit: BoxFit.contain,
                              ),
                              Positioned(
                                right: 8,
                                top: 8,
                                child: GestureDetector(
                                  onTap: () => Navigator.pop(context),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.5),
                                      shape: BoxShape.circle,
                                    ),
                                    padding: const EdgeInsets.all(8),
                                    child: const Icon(
                                      Icons.close,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              child: Stack(
                children: [
                  Image.network(
                    data['imageUrl'],
                    width: 300,
                    height: 200,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Container(
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                : null,
                            color: isCurrentUser ? Colors.green : Colors.grey,
                          ),
                        ),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      print('Error loading image: $error');
                      return Container(
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.error_outline,
                              color: Colors.red,
                              size: 40,
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Failed to load image',
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  // Optional: Add timestamp or status indicators
                  if (data['timestamp'] != null)
                    Positioned(
                      bottom: 8,
                      right: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          _formatTimestamp(data['timestamp']),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        )
      : Container(
          decoration: BoxDecoration(
            color: isCurrentUser ? Colors.green[300] : Colors.grey[300],
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.7,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                data['message'] ?? '',
                style: TextStyle(
                  color: isCurrentUser ? Colors.white : Colors.black,
                ),
              ),
              if (data['timestamp'] != null)
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    _formatTimestamp(data['timestamp']),
                    style: TextStyle(
                      color: isCurrentUser 
                          ? Colors.white.withOpacity(0.7)
                          : Colors.black.withOpacity(0.7),
                      fontSize: 10,
                    ),
                  ),
                ),
            ],
          ),
        ),
    ),
  );
}

// Add this helper function for timestamp formatting
String _formatTimestamp(Timestamp timestamp) {
  DateTime dateTime = timestamp.toDate();
  DateTime now = DateTime.now();
  DateTime today = DateTime(now.year, now.month, now.day);
  DateTime messageDate = DateTime(dateTime.year, dateTime.month, dateTime.day);

  if (messageDate == today) {
    // Today, show time only
    return '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
  } else if (messageDate == today.subtract(const Duration(days: 1))) {
    // Yesterday
    return 'Yesterday ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
  } else {
    // Other days
    return '${dateTime.day}/${dateTime.month}/${dateTime.year} ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
  }
}

  Widget _buildUserInput() {
    return Row(
      children: [
        Expanded(
          child: CustomTextformfield(
            controller: _messageController,
            hintText: 'Type a message',
            suffixIcon: Padding(
              padding: const EdgeInsets.only(right: 5),
              child: Container(
                decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 241, 235, 235),
                        shape: BoxShape.circle
                                  ),
                        child: IconButton(onPressed:_pickAndSendImage
              
                        , icon: Icon(Icons.image)),
              ),
            ),
          ),
        ),
        // Container(
        //   decoration: BoxDecoration(
        //     color: Colors.grey,
        //     shape: BoxShape.circle
        //   ),
        //   child: IconButton(onPressed:_pickAndSendImage
            
        //   , icon: Icon(Icons.image)),
        // ),
        Padding(
          padding: const EdgeInsets.only(left: 5),
          child: Container(
            decoration: const BoxDecoration(
              color: Color(0xFF009688),
              shape: BoxShape.circle,
            ),
            margin: const EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: sendMessage,
              icon: const Icon(Icons.send, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}