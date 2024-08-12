import 'package:flutter/material.dart';

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
    Future.delayed(const Duration(seconds: 1), () {
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
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Linear Progress Indicator',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            LinearProgressIndicator(
              value: _progress,
            ),
            const SizedBox(height: 30),
            const Text(
              'Circular Progress Indicator',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            CircularProgressIndicator(
              value: _progress,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _progress = 0.0;
                  _simulateProgress();
                });
              },
              child: const Text('Restart Progress'),
            ),
          ],
        ),
      ),
    );
  }
}
