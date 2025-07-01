import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ScreenA extends StatelessWidget {
  const ScreenA({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Center(child: Text('Screen A')),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              context.push('/a/detail');
            },
            child: const Text('Go to detail'),
          ),
        ],
      ),
    );
  }
}
