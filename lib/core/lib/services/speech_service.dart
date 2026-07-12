import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:porcupine_flutter/porcupine_manager.dart';

class SpeechService {
  final stt.SpeechToText _speech = stt.SpeechToText();
  PorcupineManager? _porcupine;
  bool isListening = false;
  final Function(String) onCommand;

  SpeechService(this.onCommand);

  Future<void> init() async {
    await _speech.initialize();
    // Porcupine wake word (replace ACCESS_KEY after getting from picovoice.ai)
    _porcupine = await PorcupineManager.fromBuiltInKeywords(
      "YOUR_PICOVOICE_ACCESS_KEY_HERE",
      [], // Add custom keyword index for "hi orchid"
      _onWakeWord,
    );
    await _porcupine?.start();
  }

  void _onWakeWord(int keywordIndex) {
    print("🌸 Wake word detected!");
    startCommandListening();
  }

  Future<void> startCommandListening() async {
    if (isListening) return;
    isListening = true;
    await _speech.listen(
      onResult: (result) {
        if (result.finalResult) {
          onCommand(result.recognizedWords);
          isListening = false;
        }
      },
      listenFor: const Duration(minutes: 1),
    );
  }
}
