import 'package:flutter/material.dart';
import 'dart:math' as math;

class ProgressBarExample extends StatefulWidget {
  const ProgressBarExample({super.key});

  @override
  _ProgressBarExampleState createState() => _ProgressBarExampleState();
}

class _ProgressBarExampleState extends State<ProgressBarExample> {
  double _progress = 0.0;

  @override
  void initState() {
    super.initState();
    _simulateProgress();
  }

  void _simulateProgress() {
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _progress += 0.2;
        if (_progress < 1.0) {
          _simulateProgress();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Progress Bar Example'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Linear Progress Indicator',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                gradient: const LinearGradient(
                  colors: [Colors.blue, Colors.purple],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
              ),
              height: 8,
              child: LinearProgressIndicator(
                value: _progress,
                backgroundColor: Colors.transparent,
                valueColor: const AlwaysStoppedAnimation<Color>(
                    Colors.redAccent),
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              'Circular Progress Indicator',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: 100,
              height: 100,
              child: CustomPaint(
                painter: GradientCircularProgressPainter(_progress),
                child: Center(
                  child: Text(
                    '${(_progress * 100).toInt()}%',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _progress = 0.0;
                  _simulateProgress();
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                elevation: 5,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('Restart Progress'),
            ),
          ],
        ),
      ),
    );
  }
}

class GradientCircularProgressPainter extends CustomPainter {
  final double progress;

  GradientCircularProgressPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..strokeWidth = 8
      ..color = Colors.grey[300]!
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final gradient =  SweepGradient(
      colors: [Colors.blue, Colors.purple],
      startAngle: 0.0,
      endAngle: 2 * math.pi,
    );


    canvas.drawCircle(size.center(Offset.zero), size.width / 2, paint);

    final progressPaint = Paint()
      ..shader = gradient.createShader(rect)
      ..strokeWidth = 8
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final progressRect = Rect.fromCircle(
        center: size.center(Offset.zero), radius: size.width / 2);
    final progressSweepAngle = 2 * math.pi * progress;

    canvas.drawArc(
      progressRect,
      -math.pi / 2,
      progressSweepAngle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
