import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class TruthOrDarePage extends StatefulWidget {
  final int count;
  final String type;

  const TruthOrDarePage({super.key, required this.count, required this.type});

  @override
  State<TruthOrDarePage> createState() => _TruthOrDarePageState();
}

class _TruthOrDarePageState extends State<TruthOrDarePage> {
  String _currentPrompt = '';
  final Random _random = Random();
  Map<String, dynamic> _questionData = {};

  @override
  void initState() {
    super.initState();
    _loadQuestions();
  }

  Future<void> _loadQuestions() async {
    final String jsonString = await rootBundle.loadString('assets/truth_or_dare_questions.json');
    setState(() {
      _questionData = json.decode(jsonString);
    });
  }

  Future<void> _askModeAndPrompt() async {
    setState(() {
      _currentPrompt = '';  // Masquer l'ancien texte avant d'ouvrir la boîte
    });

    final result = await showDialog<String>(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: const Color(0xE7091E33),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildChoiceButton('Action'),
            _buildChoiceButton('Vérité'),
          ],
        ),
      ),
    );

    if (result != null && _questionData.containsKey(widget.type)) {
      final List<String> pool = List<String>.from(
        _questionData[widget.type][result.toLowerCase() == 'action' ? 'actions' : 'truths'] ?? [],
      );

      if (pool.isNotEmpty) {
        pool.shuffle();
        final prompt = pool[_random.nextInt(pool.length)];

        setState(() {
          _currentPrompt = prompt;
        });
      }
    }
  }


  Widget _buildChoiceButton(String label) {
    return SizedBox(
      width: 100,
      height: 120,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          foregroundColor: Colors.white,
          side: const BorderSide(color: Colors.white, width: 2),
          backgroundColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: () => Navigator.pop(context, label.toLowerCase()),
        child: Text(label),
      ),
    );
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
        child: GestureDetector(
          onTap: _askModeAndPrompt,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Text(
                _currentPrompt.isEmpty ? "Appuie pour commencer" : _currentPrompt,
                style: const TextStyle(color: Colors.white, fontSize: 26),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }
}




