import 'dart:math';
import 'dart:async';
import 'package:flutter/material.dart';

class PalmierPage extends StatefulWidget {
  const PalmierPage({super.key});

  @override
  State<PalmierPage> createState() => _PalmierPageState();
}

class _PalmierPageState extends State<PalmierPage> {
  final List<String> cardNames = [
    '01-carreau','01-coeur','01-pique','01-trefle',
    '02-carreau','02-coeur','02-pique','02-trefle',
    '03-carreau','03-coeur','03-pique','03-trefle',
    '04-carreau','04-coeur','04-pique','04-trefle',
    '05-carreau','05-coeur','05-pique','05-trefle',
    '06-carreau','06-coeur','06-pique','06-trefle',
    '07-carreau','07-coeur','07-pique','07-trefle',
    '08-carreau','08-coeur','08-pique','08-trefle',
    '09-carreau','09-coeur','09-pique','09-trefle',
    '10-carreau','10-coeur','10-pique','10-trefle',
    'V-carreau','V-coeur','V-pique','V-trefle',
    'D-carreau','D-coeur','D-pique','D-trefle',
    'R-carreau','R-coeur','R-pique','R-trefle',
  ];

  final Map<String, String> ruleMap = {
    '01': 'Cul sec !',
    '02': 'Bois 2 gorgées !',
    '03': 'Bois 3 gorgées !',
    '04': 'Four to the floor !',
    '05': 'Five to the sky !',
    '06': 'Dans ma valise :',
    '07': 'Maître de la question',
    '08': 'Do?',
    '09': "Je n'ai jamais :",
    '10': 'Maître du regard',
    'V':  'Thème :',
    'D':  'Tout le monde boit !',
    'R':  'Invente une règle !',
  };

  static const _flipDuration = Duration(milliseconds: 1000);

  late List<int> _indices;    // indices des 4 cartes
  int? _tappedIndex;          // quelle tuile a été tapée
  bool _showGrid = true;      // true = grille, false = plein écran
  String? _selectedRule;      // règle associée

  @override
  void initState() {
    super.initState();
    _drawFourCards();
  }

  void _drawFourCards() {
    final all = List.generate(cardNames.length, (i) => i)..shuffle(Random());
    _indices = all.take(4).toList();
    _tappedIndex = null;
    _selectedRule = null;
    _showGrid = true;
    setState(() {});
  }

  void _onTapCard(int i) {
    if (_tappedIndex != null) return; // bloque après un flip
    _tappedIndex = i;
    final real = _indices[i];
    _selectedRule = ruleMap[cardNames[real].split('-').first];
    setState(() {});
    // après le flip, on passe en plein écran
    Timer(_flipDuration, () {
      setState(() => _showGrid = false);
    });
  }

  Widget _buildGrid() {
    return Column(
      key: const ValueKey('grid'),
      children: [
        const SizedBox(height: 16),
        const Text(
          'Choisis une carte !',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 32),
        Expanded(
          child: GridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            children: List.generate(4, (i) {
              final flipping = _tappedIndex == i;
              return GestureDetector(
                onTap: () => _onTapCard(i),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0.0, end: flipping ? 1.0 : 0.0),
                    duration: _flipDuration,
                    builder: (context, value, child) {
                      // flip value entre 0 et 1
                      // avant 0.5 : on garde le dos, angle = value*π
                      // après 0.5 : on affiche la face, angle = (1-value)*π
                      final showingFront = value > 0.5;
                      final angle = showingFront
                          ? (1 - value) * pi
                          : value * pi;
                      final asset = showingFront
                          ? 'assets/cards/${cardNames[_indices[i]]}.png'
                          : 'assets/dos-bleu.png';
                      return Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.rotationY(angle),
                        child: Image.asset(asset, fit: BoxFit.contain),
                      );
                    },
                  ),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }

  Widget _buildFullScreen(Size size) {
    final real = _indices[_tappedIndex!];
    return Column(
      key: const ValueKey('full'),
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset(
              'assets/cards/${cardNames[real]}.png',
              fit: BoxFit.contain,
              width: size.width,       // on gère la largeur via le padding
              height: size.height * 0.6,
            ),
          ),
        ),
        const SizedBox(height: 8),
        if (_selectedRule != null)
          Text(
            _selectedRule!,
            style: const TextStyle(
                color: Colors.white, fontSize: 42, fontWeight: FontWeight.w500
            ),
            textAlign: TextAlign.center,
          ),
        const SizedBox(height: 64),
        OutlinedButton(
          onPressed: _drawFourCards,
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: Colors.white, width: 2),
            foregroundColor: Colors.white,
            backgroundColor: Colors.transparent,
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
          ),
          child: const Text("Carte suivante", style: TextStyle(fontSize: 18)),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: _showGrid ? _buildGrid() : _buildFullScreen(size),
          ),
        ),
      ),
    );
  }
}