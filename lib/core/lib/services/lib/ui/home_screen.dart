import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../services/speech_service.dart';
import '../core/constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late SpeechService _speechService;
  String _status = "Say 'hi orchid'";
  String _lastResponse = "";

  @override
  void initState() {
    super.initState();
    _speechService = SpeechService(_handleCommand);
    _speechService.init();
  }

  void _handleCommand(String command) {
    setState(() {
      _status = "Heard: $command";
      // Call LLM here
      _lastResponse = "Orchid: Oh great, another command from my favorite human. Working on '$command'...";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("🌸 Orchid")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Glowing Orb
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const RadialGradient(colors: [Colors.purpleAccent, Colors.deepPurple]),
                boxShadow: [
                  BoxShadow(color: Colors.purple.withOpacity(0.8), blurRadius: 40, spreadRadius: 20),
                ],
              ),
            ).animate().shimmer(duration: 2.seconds),
            const SizedBox(height: 40),
            Text(_status, style: const TextStyle(fontSize: 24, color: Colors.white)),
            const SizedBox(height: 20),
            Text(_lastResponse, style: const TextStyle(fontSize: 18, color: Colors.purpleAccent)),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () => _speechService.startCommandListening(),
              child: const Text("Force Listen"),
            ),
          ],
        ),
      ),
    );
  }
}
