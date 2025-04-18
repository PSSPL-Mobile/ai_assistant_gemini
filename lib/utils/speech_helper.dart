import 'package:speech_to_text/speech_to_text.dart' as stt;

class SpeechHelper {
  final stt.SpeechToText _speech = stt.SpeechToText();

  Future<bool> initialize() async {
    return await _speech.initialize();
  }

  void listen(Function(String) onResult, Function onComplete) {
    _speech.listen(
      onResult: (result) {
        if (result.finalResult) {
          _speech.stop();
          onComplete();
          onResult(result.recognizedWords);
        }
      },
    );
  }

  void stop() {
    _speech.stop();
  }
}
