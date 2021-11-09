import 'package:flutter/material.dart';

class GradientsPainter extends CustomPainter {
  const GradientsPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final Rect rect = Offset.zero & size;

    RadialGradient redGradient = RadialGradient(
      center: const Alignment(0.3, -0.4),
      radius: 2,
      colors: <Color>[
        Colors.redAccent.shade400,
        Colors.redAccent.shade400.withOpacity(0.4)
      ],
    );
    RadialGradient orangeGradient = RadialGradient(
      center: const Alignment(-0.8, 0.5),
      radius: 2,
      colors: <Color>[
        Colors.orangeAccent,
        Colors.orangeAccent.withOpacity(0.2)
      ],
    );
    RadialGradient purpleGradient = RadialGradient(
      center: const Alignment(0.6, 0.9),
      radius: 1,
      colors: <Color>[
        Colors.deepPurpleAccent.shade700.withOpacity(0.6),
        Colors.deepPurpleAccent.shade700.withOpacity(0.1),
      ],
    );

    canvas.drawRect(
      rect,
      Paint()..shader = redGradient.createShader(rect),
    );
    canvas.drawRect(
      rect,
      Paint()..shader = orangeGradient.createShader(rect),
    );
    canvas.drawRect(
      rect,
      Paint()..shader = purpleGradient.createShader(rect),
    );
  }

  @override
  bool shouldRepaint(GradientsPainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(GradientsPainter oldDelegate) => false;
}
