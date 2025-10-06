import 'dart:math';
import 'package:flutter/material.dart';

class PlusOuMoinsPage extends StatefulWidget {
  const PlusOuMoinsPage({super.key});

  @override
  State<PlusOuMoinsPage> createState() => _PlusOuMoinsPageState();
}

class _PlusOuMoinsPageState extends State<PlusOuMoinsPage> {
  final TextEditingController _controller = TextEditingController();
  int _secret = Random().nextInt(100) + 1;
  int _attempts = 0;
  String? _message;
  bool _gameOver = false;

  void _checkGuess() {
    if (_gameOver) return;

    final guess = int.tryParse(_controller.text);
    if (guess == null || guess < 1 || guess > 100) {
      setState(() => _message = 'Entre un nombre entre 1 et 100 🧠');
      return;
    }

    setState(() {
      _attempts++;
      if (guess == _secret) {
        _message = '🎯 Bravo ! Tu as trouvé en $_attempts essais !';
        _gameOver = true;
      } else if (_attempts >= 5) {
        final diff = (_secret - guess).abs();
        _message = '💀 Raté ! C\'était $_secret\nBois $diff gorgées !';
        _gameOver = true;
      } else {
        _message = guess < _secret ? '🔺 Plus !' : '🔻 Moins !';
      }
      _controller.clear();
    });
  }

  void _resetGame() {
    setState(() {
      _secret = Random().nextInt(100) + 1;
      _attempts = 0;
      _message = null;
      _controller.clear();
      _gameOver = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.black, Colors.blue],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 16),
                const Text(
                  "Plus ou Moins",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 24),
                const Text(
                  "L'appli pense à un nombre entre 1 et 100.\nEssaye de le deviner en 5 coups !",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white70, fontSize: 18),
                ),
                const SizedBox(height: 32),
                TextField(
                  controller: _controller,
                  keyboardType: TextInputType.number,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white24,
                    hintText: "Entre un nombre",
                    hintStyle: const TextStyle(color: Colors.white54),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  enabled: !_gameOver,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _checkGuess,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                    textStyle: const TextStyle(fontSize: 16),
                  ),
                  child: const Text("Valider"),
                ),
                const SizedBox(height: 32),
                if (_message != null)
                  Text(
                    _message!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white, fontSize: 22),
                  ),
                if (_gameOver) ...[
                  const SizedBox(height: 32),
                  OutlinedButton(
                    onPressed: _resetGame,
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.white, width: 2),
                      foregroundColor: Colors.white,
                      padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                    ),
                    child: const Text("Rejouer", style: TextStyle(fontSize: 18)),
                  ),
                ]
              ],
            ),
          ),
        ),
      ),
    );
  }
}
