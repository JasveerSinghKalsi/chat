import 'package:chat/theme/palette.dart';
import 'package:flutter/material.dart';

class MessageCard extends StatelessWidget {
  final String message;
  final String time;
  final bool isSentByMe;

  const MessageCard({
    super.key,
    required this.message,
    required this.time,
    required this.isSentByMe,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isSentByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width*0.8),
        child: Card(
          color:
              isSentByMe ? Palette.userMessageColor : Palette.senderMessageColor,
          elevation: 2.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 4, bottom: 20, left: 4, right: 4),
                  child: Text(
                    message,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
            
                Positioned(
                  bottom: 1,
                  right: 1,
                  child: Row(
                    children: [
                      Text(
                        time,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(width: 4,),
                      isSentByMe ? const Icon(Icons.done_all, size: 16,) : const SizedBox(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
