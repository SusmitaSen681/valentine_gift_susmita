import 'dart:math';
import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';

void main() {
  runApp(const BinaryLoveApp());
}

class BinaryLoveApp extends StatelessWidget {
  const BinaryLoveApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoveScreen(),
    );
  }
}

class LoveScreen extends StatefulWidget {
  const LoveScreen({super.key});

  @override
  State<LoveScreen> createState() => _LoveScreenState();
}

class _LoveScreenState extends State<LoveScreen> {
  final ConfettiController _confettiController =
      ConfettiController(duration: const Duration(seconds: 6));

  final Random _random = Random();

  bool accepted = false;

  double noLeft = 150;
  double noTop = 60;

 void moveNoButton() {
  final size = MediaQuery.of(context).size;

  // Card width (same as UI)
  final cardWidth = size.width < 600 ? size.width * 0.9 : 520;
  final cardHeight = 160.0;

  final maxX = cardWidth - buttonWidth - safePadding;
  final maxY = cardHeight - buttonHeight - safePadding;

  setState(() {
    noLeft = safePadding + _random.nextDouble() * maxX;
    noTop  = safePadding + _random.nextDouble() * maxY;
  });
}
static const double buttonWidth = 120;
static const double buttonHeight = 50;
static const double safePadding = 12;


  void onYesPressed() {
    setState(() => accepted = true);
    _confettiController.play();
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 600;

    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        decoration: const BoxDecoration(
  image: DecorationImage(
    image: AssetImage('assets/images/val.png'),
    fit: BoxFit.cover,
  ),
),

        child: Stack(
          children: [
/// 💕 MADE BY TEXT (TOP LEFT)
Positioned(
  top: 20,
  left: 20,
  child: Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    decoration: BoxDecoration(
      color: Colors.white.withOpacity(0.65),
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          blurRadius: 8,
        ),
      ],
    ),
    child: const Text(
      "Made by Susmita 💖",
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: Colors.black87,
      ),
    ),
  ),
),

            /// 🎉 CONFETTI
            Align(
              alignment: Alignment.topCenter,
              child: ConfettiWidget(
                confettiController: _confettiController,
                blastDirectionality: BlastDirectionality.explosive,
                emissionFrequency: 0.05,
                numberOfParticles: 25,
                colors: const [
                  Colors.pink,
                  Colors.red,
                  Colors.purple,
                ],
              ),
            ),

            /// MAIN CARD
            Center(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 400),
                padding: EdgeInsets.all(isMobile ? 24 : 36),
                width: isMobile ? size.width * 0.9 : 520,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.55),
                  borderRadius: BorderRadius.circular(28),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.12),
                      blurRadius: 30,
                      offset: const Offset(0, 20),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [

                    Text(
                      accepted
                          ? "Looks like fate compiled successfully 💖"
                          : "Do you believe some bugs are actually destiny? 💫",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: isMobile ? 22 : 26,
                        fontWeight: FontWeight.w700,
                        height: 1.4,
                        color: Colors.black87
                      ),
                    ),

                    const SizedBox(height: 40),

                    if (!accepted)
                      SizedBox(
                        height: 160,
                        width: double.infinity,
                        child: Stack(
                          children: [

                            /// YES BUTTON
                            Align(
                              alignment: Alignment.centerLeft,
                              child: ElevatedButton(
                                onPressed: onYesPressed,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.pinkAccent,
                                  elevation: 6,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 36, vertical: 18),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                                child: const Text(
                                  "Yes ✨",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white
                                  ),
                                ),
                              ),
                            ),

                            /// NO BUTTON (ESCAPES 😈)
                            AnimatedPositioned(
                              duration:
                                  const Duration(milliseconds: 140),
                              curve: Curves.easeOut,
                              left: noLeft,
                              top: noTop,
                              child: MouseRegion(
                                onHover: (_) => moveNoButton(),
                                child: GestureDetector(
                                  onTapDown: (_) => moveNoButton(),
                                  child: ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white60,
                                      elevation: 4,
                                      padding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 36,
                                              vertical: 18),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30),
                                      ),
                                    ),
                                    child: const Text(
                                      "Nope 🙃",
                                      style: TextStyle(fontSize: 18
                                      ,color: Colors.red),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
