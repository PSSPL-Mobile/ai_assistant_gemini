import 'package:flutter/material.dart';
import 'core/constants.dart';
import 'services/gemini_service.dart';
import 'utils/speech_helper.dart';
import 'utils/tts_helper.dart';
import 'widgets/assistant_ui.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Gemini AI Assistant',
      debugShowCheckedModeBanner: false,
      home: AIAssistant(),
    );
  }
}

class AIAssistant extends StatefulWidget {
  const AIAssistant({super.key});

  @override
  State<AIAssistant> createState() => _AIAssistantState();
}

class _AIAssistantState extends State<AIAssistant> {
  final SpeechHelper speechHelper = SpeechHelper();
  final TTSHelper ttsHelper = TTSHelper();

  String? _userMessage;
  String? _aiResponse;
  bool _isListening = false;

  Future<void> _handleMicTap() async {
    if (_isListening) {
      // Manually stop
      speechHelper.stop();
      setState(() => _isListening = false);
      return;
    }

    final initialized = await speechHelper.initialize();
    if (!initialized) {
      setState(() {
        _userMessage = null;
        _aiResponse = "Microphone not available.";
      });
      return;
    }

    setState(() {
      _isListening = true;
      _userMessage = null;
      _aiResponse = null;
    });

    speechHelper.listen(
      (spokenText) async {
        setState(() => _userMessage = spokenText);
        final aiReply = await GeminiService.fetchResponse(spokenText);
        setState(() {
          _aiResponse = aiReply;
          _isListening = false;
        });
        // Enable 
        //await ttsHelper.speak(aiReply);
      },
      () => setState(() => _isListening = false),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AssistantUI(
      userMessage: _userMessage,
      aiResponse: _aiResponse,
      isListening: _isListening,
      onMicTap: _handleMicTap,
    );
  }
}
