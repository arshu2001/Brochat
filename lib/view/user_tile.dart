import 'package:flutter/material.dart';

class UserTile extends StatelessWidget {
  final String text;
  final String? latestMessage;
  final void Function()? onTap;
  final bool showUnread;
  final int? unreadCount;
  final String? profileImageUrl;

  const UserTile({
    super.key,
    required this.text,
    this.latestMessage,
    required this.onTap,
    required this.showUnread,
    this.unreadCount,
    this.profileImageUrl
    
  });

  

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(12)
        ),
        margin: const EdgeInsets.symmetric(vertical: 5,horizontal: 20),
        padding: EdgeInsets.all(13),
        child: Row(
          children: [
            CircleAvatar(
              radius: 24, // Adjust size as needed
              backgroundImage: profileImageUrl != null && profileImageUrl!.isNotEmpty
                  ? NetworkImage(profileImageUrl!) // Display profile image if available
                  : AssetImage('images/ravi.png') as ImageProvider, // Placeholder image
            ),

            const SizedBox(width: 20,),

            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(text,style: TextStyle(fontWeight: FontWeight.bold),),
                  const SizedBox(height: 4,),
                  Text(
                    latestMessage ?? '', // Display latest message if available
                    style: TextStyle(
                      color: showUnread?Colors.green : Colors.black54),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            if(unreadCount != null && unreadCount!> 0)
            Container(
                width: 20,
                height: 20,              
                decoration: BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    unreadCount.toString(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
            ) 
          ],
        ),
      ),
    );
  }
}