import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class JeuDesDesPage extends StatefulWidget {
  const JeuDesDesPage({super.key});

  @override
  State<JeuDesDesPage> createState() => _JeuDesDesPageState();
}

class _JeuDesDesPageState extends State<JeuDesDesPage> {
  int _die1 = 1;
  int _die2 = 1;
  String _rule = '';
  bool _isRolling = false;
  Timer? _timer;

  final Map<int, String> _rules = {
    2: "Choisis quelqu’un qui boit",
    3: "Règle du roi : invente une règle",
    4: "Bois 2 gorgées",
    5: "Tout le monde dit 'Bizard'",
    6: "Celui à ta gauche boit",
    7: "Catégorie : chacun son tour",
    8: "Pointé du doigt ! Le dernier boit",
    9: "Fais une action, les autres imitent",
    10: "Raconte une vérité",
    11: "Tu relances !",
    12: "Cul sec !"
  };

  void _rollDice() {
    if (_isRolling) return;

    setState(() {
      _isRolling = true;
      _rule = '';
    });

    final rand = Random();
    int ticks = 0;

    _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      setState(() {
        _die1 = rand.nextInt(6) + 1;
        _die2 = rand.nextInt(6) + 1;
      });

      ticks++;
      if (ticks >= 10) {
        timer.cancel();
        final sum = _die1 + _die2;
        setState(() {
          _rule = _rules[sum] ?? 'Pas de règle pour ce score.';
          _isRolling = false;
        });
      }
    });
  }

  Widget _buildDie(int value) {
    return Container(
      margin: const EdgeInsets.all(8),
      width: 100,
      height: 100,
      child: Image.asset('assets/images/dice_$value.png'),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
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
          child: Column(
            children: [
              const SizedBox(height: 24),
              const Text(
                'Jeu des Dés',
                style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [_buildDie(_die1), _buildDie(_die2)],
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _rollDice,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                ),
                child: Text(_isRolling ? '...' : 'Lancer les dés'),
              ),
              const SizedBox(height: 32),
              if (_rule.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Text(
                    _rule,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white, fontSize: 24),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

