import 'package:flutter/material.dart';
import 'package:progress_bar_flutter/progress_bar.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('progress Bar Exammple'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProgressBarExample()),
                );
              },
              child: Text('Progress Bar'),
            ),
          ],
        ),
      ),
    );
  }
}
