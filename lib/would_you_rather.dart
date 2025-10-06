import 'package:flutter/material.dart';
import 'dart:math';

class WouldYouRatherPage extends StatefulWidget {
  final int count;
  final String type;

  const WouldYouRatherPage({super.key, required this.count, required this.type});

  @override
  State<WouldYouRatherPage> createState() => _WouldYouRatherPageState();
}

class _WouldYouRatherPageState extends State<WouldYouRatherPage> {
  final Map<String, List<String>> _questionSets = {
    'normal': [
      "Tu préfères ne plus avoir de téléphone ou ne plus avoir de musique ?",
      "Tu préfères vivre sans internet ou sans films/séries ?",
      "Tu préfères parler toutes les langues ou jouer de tous les instruments ?",
      "Tu préfères être toujours en avance ou toujours en retard ?",
      "Tu préfères ne plus jamais te doucher ou ne plus jamais te brosser les dents ?",
    ],
    'soirée': [
      "Tu préfères finir chaque soirée en pleurant ou en dansant seul ?",
      "Tu préfères oublier ce que tu as dit ou ce que tu as fait en soirée ?",
      "Tu préfères renverser un verre sur quelqu’un ou te le prendre ?",
      "Tu préfères chanter faux toute la soirée ou danser seul au milieu de la piste ?",
      "Tu préfères dormir dans la baignoire ou sur le paillasson ?",
    ],
    'sexe': [
      "Tu préfères ne plus jamais embrasser ou ne plus jamais faire l’amour ?",
      "Tu préfères faire l’amour dans un lieu public ou chez tes parents ?",
      "Tu préfères un(e) partenaire silencieux(se) ou trop bruyant(e) ?",
      "Tu préfères toujours finir trop tôt ou jamais ?",
      "Tu préfères tester tous les fantasmes ou aucun ?",
    ],
  };

  late List<String> _selectedQuestions;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    final list = _questionSets[widget.type] ?? [];
    _selectedQuestions = List<String>.from(list)..shuffle(Random());
    _selectedQuestions = _selectedQuestions.take(widget.count).toList();
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
        child: GestureDetector(
          onTap: _nextQuestion,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Text(
                _selectedQuestions[_currentIndex],
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