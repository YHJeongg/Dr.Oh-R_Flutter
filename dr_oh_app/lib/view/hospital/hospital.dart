import 'package:flutter/material.dart';

class Hospital extends StatelessWidget {
  const Hospital({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('hospital'),
        elevation: 0,
      ),
      body: const Text('hospital'),
    );
  }
}
