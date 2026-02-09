import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class AnimatedTextBox extends StatefulWidget {
  final List<String> texts;
  final double fontSize;

  const AnimatedTextBox({
    Key? key,
    required this.texts,
    this.fontSize = 18,
  }) : super(key: key);

  @override
  State<AnimatedTextBox> createState() => _AnimatedTextBoxState();
}

class _AnimatedTextBoxState extends State<AnimatedTextBox>
    with SingleTickerProviderStateMixin {
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeIn),
    );

    _fadeController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: Colors.white.withOpacity(0.3), width: 1),
        ),
        child: DefaultTextStyle(
          style: TextStyle(
            fontSize: widget.fontSize,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            height: 1.5,
            letterSpacing: 1.5,
          ),
          child: AnimatedTextKit(
            animatedTexts: widget.texts
                .map((text) => TyperAnimatedText(text))
                .toList(),
            isRepeatingAnimation: true,
            repeatForever: true,
          ),
        ),
      ),
    );
  }
}
