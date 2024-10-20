import 'package:chat/features/chat/chat_controller.dart';
import 'package:flutter/material.dart';
import 'package:chat/theme/palette.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BottomTextMessageField extends ConsumerStatefulWidget {
  final String receiverUserId;
  final bool isGroupChat;
  const BottomTextMessageField({
    super.key,
    required this.receiverUserId,
    required this.isGroupChat,
  });

  @override
  ConsumerState<BottomTextMessageField> createState() =>
      _BottomTextMessageFieldState();
}

class _BottomTextMessageFieldState
    extends ConsumerState<BottomTextMessageField> {
  bool isShowSendButton = false;
  late final TextEditingController _message;
  late final ScrollController _scrollController;

  @override
  void initState() {
    _message = TextEditingController();
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _message.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _sendTextMessage() async {
    if (isShowSendButton) {
      ref.read(chatControllerProvider).sendTextMessage(
          context: context,
          text: _message.text.trim(),
          receiverUserId: widget.receiverUserId,
          isGroupChat: widget.isGroupChat);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: _message,
            onChanged: (value) {
              if (value.isNotEmpty) {
                setState(() {
                  isShowSendButton = true;
                });
              } else {
                setState(() {
                  isShowSendButton = false;
                });
              }
            },
            keyboardType: TextInputType.multiline,
            minLines: 1,
            maxLines: 2,
            scrollController: _scrollController,
            decoration: InputDecoration(
              hintText: 'Message',
              prefixIcon: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.emoji_emotions),
              ),
              suffixIcon: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.camera_alt,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.attach_file,
                    ),
                  ),
                ],
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
                borderSide: const BorderSide(width: 0, style: BorderStyle.none),
              ),
              filled: true,
              fillColor: Palette.mobileChatBoxColor,
              contentPadding: const EdgeInsets.all(10),
            ),
          ),
        ),
        const SizedBox(width: 8),
        CircleAvatar(
          radius: 24,
          backgroundColor: Palette.tabColor,
          child: IconButton(
            onPressed: () {
              _sendTextMessage();
              _message.clear();
            },
            icon: Icon(isShowSendButton ? Icons.send : Icons.mic),
          ),
        ),
      ],
    );
  }
}
