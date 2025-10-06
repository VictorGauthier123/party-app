import 'package:flutter/material.dart';
import 'jeu_des_des.dart';
import 'never_have_i_ever.dart';
import 'truth_or_dare.dart';
import 'would_you_rather.dart';
import 'plus_ou_moins.dart';
import 'palmier.dart';
import 'roulette_russe.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  ButtonStyle customButtonStyle() {
    return OutlinedButton.styleFrom(
      side: const BorderSide(color: Colors.white, width: 2),
      foregroundColor: Colors.white,
      backgroundColor: Colors.transparent,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
      textStyle: const TextStyle(
        fontSize: 18,
        fontFamily: 'RobotoCondensed',
        fontWeight: FontWeight.w500,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
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
        child: SafeArea(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 12),
                Image.asset(
                  'assets/demon.png',
                  width: 400,
                  height: 200,
                  fit: BoxFit.contain,
                ),
                const SizedBox(height: 32),
                OutlinedButton(
                  style: customButtonStyle(),
                  onPressed: () async {
                    final result = await showDialog<Map<String, dynamic>>(
                      context: context,
                      builder: (_) => const QuestionCountDialog(),
                    );
                    if (result != null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => NeverHaveIEverPage(
                            count: result['count'],
                            type: result['type'],
                          ),
                        ),
                      );
                    }
                  },
                  child: const Text("Je n'ai jamais"),
                ),
                const SizedBox(height: 16),
                OutlinedButton(
                  style: customButtonStyle(),
                  onPressed: () async {
                    final result = await showDialog<Map<String, dynamic>>(
                      context: context,
                      builder: (_) => const TruthOrDareDialog(),
                    );
                    if (result != null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => TruthOrDarePage(
                            count: result['count'],
                            type: result['type'],
                          ),
                        ),
                      );
                    }
                  },
                  child: const Text("Action ou Vérité"),
                ),
                const SizedBox(height: 16),
                OutlinedButton(
                  style: customButtonStyle(),
                  onPressed: () async {
                    final result = await showDialog<Map<String, dynamic>>(
                      context: context,
                      builder: (_) => const WouldYouRatherDialog(),
                    );
                    if (result != null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => WouldYouRatherPage(
                            count: result['count'],
                            type: result['type'],
                          ),
                        ),
                      );
                    }


                  },
                  child: const Text("Tu préfères"),

                ),
                const SizedBox(height: 16),
                OutlinedButton(
                  style: customButtonStyle(),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const PalmierPage(),
                      ),
                    );
                  },
                  child: const Text("Palmier"),
                ),
                const SizedBox(height: 16),
                OutlinedButton(
                  style: customButtonStyle(),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const PlusOuMoinsPage(),
                      ),
                    );
                  },
                  child: const Text("Plus ou Moins"),
                ),
                const SizedBox(height: 16),
                OutlinedButton(
                  style: customButtonStyle(),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const RouletteRussePage(),
                      ),
                    );
                  },
                  child: const Text("Roulette Russe"),
                ),
                const SizedBox(height: 16),
                OutlinedButton(
                  style: customButtonStyle(),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const JeuDesDesPage(),
                      ),
                    );
                  },
                  child: const Text("Biskit"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


class QuestionCountDialog extends StatefulWidget {
  const QuestionCountDialog({super.key});

  @override
  State<QuestionCountDialog> createState() => _QuestionCountDialogState();
}

class _QuestionCountDialogState extends State<QuestionCountDialog> {
  String selectedType = 'normal';
  int selectedCount = 5;

  final Color backgroundColor = const Color(0xFF0D1B2A); // Couleur personnalisable

  ButtonStyle squareButtonStyle(bool selected) {
    return OutlinedButton.styleFrom(
      backgroundColor: selected ? Color(0xFF294467) : Colors.transparent,

      foregroundColor: selected ? Colors.black : Colors.white,
      side: const BorderSide(color: Colors.white, width: 2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      minimumSize: const Size(80, 80),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(8), // Réduit les marges = plus grande boîte
      backgroundColor: backgroundColor,
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.75, // Boîte plus haute
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween, // Pour placer le GO en bas
            children: [
              Column(
                children: [
                  const Text(
                    "",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: ['normal', 'soiree', 'sexe'].map((type) {
                      String imagePath = 'assets/emoji_$type.png';

                      return OutlinedButton(
                        style: squareButtonStyle(selectedType == type),
                        onPressed: () {
                          setState(() {
                            selectedType = type;
                          });
                        },
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const SizedBox(height: 4),
                            Image.asset(imagePath, width: 60, height: 60),
                            const SizedBox(height: 4),
                            Text(
                              type[0].toUpperCase() + type.substring(1),
                              style: const TextStyle(fontSize: 14),
                            ),
                            const SizedBox(height: 8),
                          ],
                        ),
                      );
                    }).toList(),
                  ),

                  const SizedBox(height: 32),
                  const Text(
                    "Nombre de questions",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [5, 10, 15].map((number) {
                      return OutlinedButton(
                        style: squareButtonStyle(selectedCount == number),
                        onPressed: () {
                          setState(() {
                            selectedCount = number;
                          });
                        },
                        child: Text('$number'),
                      );
                    }).toList(),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, {
                    'type': selectedType,
                    'count': selectedCount,
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                child: const Text("GO"),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class TruthOrDareDialog extends StatefulWidget {
  const TruthOrDareDialog({super.key});

  @override
  State<TruthOrDareDialog> createState() => _TruthOrDareDialogState();
}

class _TruthOrDareDialogState extends State<TruthOrDareDialog> {
  String selectedType = 'normal';
  int selectedCount = 5;

  ButtonStyle squareButtonStyle(bool selected) {
    return OutlinedButton.styleFrom(
      backgroundColor: selected ? const Color(0xFF294467) : Colors.transparent,
      foregroundColor: selected ? Colors.black : Colors.white,
      side: const BorderSide(color: Colors.white, width: 2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      minimumSize: const Size(80, 80),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(8),
      backgroundColor: const Color(0xFF0D1B2A),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.75,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  const Text(
                    "Type de questions",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: ['normal', 'soiree', 'sexe'].map((type) {
                      String imagePath = 'assets/emoji_$type.png';

                      return OutlinedButton(
                        style: squareButtonStyle(selectedType == type),
                        onPressed: () {
                          setState(() {
                            selectedType = type;
                          });
                        },
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const SizedBox(height: 4),
                            Image.asset(imagePath, width: 60, height: 60),
                            const SizedBox(height: 4),
                            Text(
                              type[0].toUpperCase() + type.substring(1),
                              style: const TextStyle(fontSize: 14),
                            ),
                            const SizedBox(height: 8),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 32),
                  const Text(
                    "Nombre de tours",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [5, 10, 15].map((number) {
                      return OutlinedButton(
                        style: squareButtonStyle(selectedCount == number),
                        onPressed: () {
                          setState(() {
                            selectedCount = number;
                          });
                        },
                        child: Text('$number'),
                      );
                    }).toList(),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, {
                    'type': selectedType,
                    'count': selectedCount,
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                child: const Text("GO"),
              )
            ],
          ),
        ),
      ),
    );
  }
}


class WouldYouRatherDialog extends StatefulWidget {
  const WouldYouRatherDialog({super.key});

  @override
  State<WouldYouRatherDialog> createState() => _WouldYouRatherDialogState();
}

class _WouldYouRatherDialogState extends State<WouldYouRatherDialog> {
  String selectedType = 'normal';
  int selectedCount = 5;

  ButtonStyle squareButtonStyle(bool selected) {
    return OutlinedButton.styleFrom(
      backgroundColor: selected ? const Color(0xFF294467) : Colors.transparent,
      foregroundColor: selected ? Colors.black : Colors.white,
      side: const BorderSide(color: Colors.white, width: 2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      minimumSize: const Size(80, 80),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(8),
      backgroundColor: const Color(0xFF0D1B2A),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.75,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  const Text(
                    "Type de dilemme",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: ['normal', 'soiree', 'sexe'].map((type) {
                      String imagePath = 'assets/emoji_$type.png';

                      return OutlinedButton(
                        style: squareButtonStyle(selectedType == type),
                        onPressed: () {
                          setState(() {
                            selectedType = type;
                          });
                        },
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const SizedBox(height: 4),
                            Image.asset(imagePath, width: 60, height: 60),
                            const SizedBox(height: 4),
                            Text(
                              type[0].toUpperCase() + type.substring(1),
                              style: const TextStyle(fontSize: 14),
                            ),
                            const SizedBox(height: 8),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 32),
                  const Text(
                    "Nombre de questions",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [5, 10, 15].map((number) {
                      return OutlinedButton(
                        style: squareButtonStyle(selectedCount == number),
                        onPressed: () {
                          setState(() {
                            selectedCount = number;
                          });
                        },
                        child: Text('$number'),
                      );
                    }).toList(),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, {
                    'type': selectedType,
                    'count': selectedCount,
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                child: const Text("GO"),
              )
            ],
          ),
        ),
      ),
    );
  }
}


