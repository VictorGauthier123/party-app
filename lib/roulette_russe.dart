import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';

class RouletteRussePage extends StatefulWidget {
  const RouletteRussePage({super.key});

  @override
  State<RouletteRussePage> createState() => _RouletteRussePageState();
}

class _RouletteRussePageState extends State<RouletteRussePage> {
  final StreamController<int> _controller = StreamController<int>();
  final int _boomIndex = Random().nextInt(6); // 1 balle dans 6 emplacements
  final List<String> slots = List.generate(6, (i) => i.toString()); // 6 positions
  bool _isSpinning = false;
  int? _result;

  @override
  void initState() {
    super.initState();
    slots[_boomIndex] = '💥 BOOM';
    for (int i = 0; i < 6; i++) {
      if (i != _boomIndex) slots[i] = 'Safe';
    }
  }

  void _spin() {
    if (_isSpinning) return;

    setState(() {
      _isSpinning = true;
    });

    final picked = Random().nextInt(slots.length);
    _controller.add(picked);

    Future.delayed(const Duration(seconds: 5), () {
      setState(() {
        _result = picked;
        _isSpinning = false;
      });
    });
  }

  @override
  void dispose() {
    _controller.close();
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
                'Roulette Russe',
                style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: FortuneWheel(
                  selected: _controller.stream,
                  items: List.generate(slots.length, (index) {
                    final isBoom = slots[index].contains('BOOM');
                    return FortuneItem(
                      child: Text(
                        slots[index],
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      style: FortuneItemStyle(
                        color: isBoom ? Colors.redAccent.shade700 : Colors.blue.shade800,
                        borderColor: Colors.white,
                        borderWidth: 2,
                      ),
                    );
                  }),
                  indicators: const <FortuneIndicator>[
                    FortuneIndicator(
                      alignment: Alignment.topCenter,
                      child: TriangleIndicator(color: Colors.white),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _spin,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                ),
                child: const Text("Tirer !"),
              ),
              const SizedBox(height: 24),
              if (_result != null)
                Text(
                  slots[_result!] == 'BOOM'
                      ? 'Cul sec !!'
                      : 'Tu es sauf !',
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white, fontSize: 24),
                ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}

