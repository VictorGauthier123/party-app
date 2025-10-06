import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class NeverHaveIEverPage extends StatefulWidget {
  final int count;
  final String type;

  const NeverHaveIEverPage({
    super.key,
    required this.count,
    required this.type,
  });

  @override
  State<NeverHaveIEverPage> createState() => _NeverHaveIEverPageState();
}

class _NeverHaveIEverPageState extends State<NeverHaveIEverPage> {
  List<String> _selectedQuestions = [];
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _loadQuestionsFromJson();
  }

  Future<void> _loadQuestionsFromJson() async {
    final String jsonString = await rootBundle.loadString('assets/questions_never.json');
    final Map<String, dynamic> jsonData = json.decode(jsonString);
    final List<dynamic> questionsRaw = jsonData[widget.type] ?? [];
    final List<String> questions = List<String>.from(questionsRaw);
    questions.shuffle(Random());

    setState(() {
      _selectedQuestions = questions.take(widget.count).toList();
    });
  }

  void _nextQuestion() {
    setState(() {
      if (_currentIndex < _selectedQuestions.length - 1) {
        _currentIndex++;
      } else {
        Navigator.pop(context);
      }
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
        child: _selectedQuestions.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : GestureDetector(
          onTap: _nextQuestion,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Text(
                _selectedQuestions[_currentIndex],
                style: const TextStyle(color: Colors.white, fontSize: 28),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }
}


