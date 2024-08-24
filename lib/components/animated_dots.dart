import 'package:flutter/material.dart';

class AnimatedDots extends StatefulWidget {
  final Color activeColor;
  final Color inactiveColor;

  const AnimatedDots({
    super.key,
    required this.activeColor,
    required this.inactiveColor,
  });

  @override
  _AnimatedDotsState createState() => _AnimatedDotsState();
}

class _AnimatedDotsState extends State<AnimatedDots> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<int> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat();
    _animation = IntTween(begin: 0, end: 2).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(3, (index) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 2.0),
              width: 6.0,
              height: 6.0,
              decoration: BoxDecoration(
                color: _animation.value == index ? widget.activeColor : widget.inactiveColor,
                shape: BoxShape.circle,
              ),
            );
          }),
        );
      },
    );
  }
}