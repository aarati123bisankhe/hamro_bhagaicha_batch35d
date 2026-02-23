import 'package:flutter/material.dart';
import 'package:hamro_bhagaicha_batch35d/core/theme/app_background.dart';

class ChatMessage {
  final String text;
  final bool isUser;
  final bool isIssue;
  final DateTime createdAt;

  const ChatMessage({
    required this.text,
    required this.isUser,
    this.isIssue = false,
    required this.createdAt,
  });
}

class ChatSectionPage extends StatefulWidget {
  const ChatSectionPage({super.key});

  @override
  State<ChatSectionPage> createState() => _ChatSectionPageState();
}

class _ChatSectionPageState extends State<ChatSectionPage> {
  final TextEditingController _messageController = TextEditingController();
  final List<ChatMessage> _messages = [
    ChatMessage(
      text:
          'Hello! You can chat with us here and also report any issue you are facing.',
      isUser: false,
      createdAt: DateTime.now(),
    ),
  ];

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  void _sendMessage({required bool isIssue}) {
    final text = _messageController.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _messages.add(
        ChatMessage(
          text: text,
          isUser: true,
          isIssue: isIssue,
          createdAt: DateTime.now(),
        ),
      );
      _messages.add(
        ChatMessage(
          text: isIssue
              ? 'Issue reported successfully. Our team will review it soon.'
              : 'Thanks for your message. We will get back to you shortly.',
          isUser: false,
          createdAt: DateTime.now(),
        ),
      );
    });

    _messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat & Support'),
        backgroundColor: isDarkMode(context)
            ? const Color(0xFF1F2937)
            : const Color(0xFFD8F3DC),
      ),
      body: Container(
        decoration: appBackgroundDecoration(context),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  final message = _messages[index];
                  final align = message.isUser
                      ? Alignment.centerRight
                      : Alignment.centerLeft;
                  final bubbleColor = message.isUser
                      ? const Color(0xFFB7E4C7)
                      : const Color(0xFFE9F7DB);

                  return Align(
                    alignment: align,
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 10,
                      ),
                      constraints: const BoxConstraints(maxWidth: 290),
                      decoration: BoxDecoration(
                        color: bubbleColor,
                        borderRadius: BorderRadius.circular(12),
                        border: message.isIssue
                            ? Border.all(color: Colors.red.shade300)
                            : null,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (message.isIssue)
                            const Padding(
                              padding: EdgeInsets.only(bottom: 4),
                              child: Text(
                                'Issue Report',
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          Text(message.text),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(12, 8, 12, 14),
              decoration: const BoxDecoration(color: Colors.white),
              child: Column(
                children: [
                  TextField(
                    controller: _messageController,
                    minLines: 1,
                    maxLines: 4,
                    decoration: InputDecoration(
                      hintText: 'Type your message or issue...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () => _sendMessage(isIssue: true),
                          icon: const Icon(Icons.report_problem_outlined),
                          label: const Text('Report Issue'),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () => _sendMessage(isIssue: false),
                          icon: const Icon(Icons.send),
                          label: const Text('Send'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
