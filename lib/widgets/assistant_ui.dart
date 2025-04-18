import 'package:flutter/material.dart';

class AssistantUI extends StatelessWidget {
  final String? userMessage;
  final String? aiResponse;
  final bool isListening;
  final VoidCallback onMicTap;

  const AssistantUI({
    super.key,
    required this.userMessage,
    required this.aiResponse,
    required this.isListening,
    required this.onMicTap,
  });

  Widget _buildMessage(String text, bool isUser) {
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.all(12),
        constraints: const BoxConstraints(maxWidth: 250),
        decoration: BoxDecoration(
          color: isUser ? Colors.blue[200] : Colors.grey[300],
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(text, style: const TextStyle(fontSize: 16)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Gemini AI Assistant')),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                if (userMessage != null) _buildMessage(userMessage!, true),
                if (aiResponse != null) _buildMessage(aiResponse!, false),
              ],
            ),
          ),
          const Divider(height: 1),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    isListening ? "Listening..." : "Tap mic to ask",
                    style: const TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ),
                IconButton(
                  icon: Icon(isListening ? Icons.stop : Icons.mic),
                  color: isListening ? Colors.red : Colors.blue,
                  onPressed: onMicTap,
                  tooltip: isListening ? "Stop Recording" : "Start Recording",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
