import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          ListTile(
            title: const Text('Cubits'),
            subtitle: const Text('Gestor de estado simple'),
            trailing: const Icon(Icons.arrow_circle_right_outlined),
            onTap: () {
              context.push('/cubits');
            },
          ),
          ListTile(
            title: const Text('Bloc'),
            subtitle: const Text('Otro gestor de estado compuesto'),
            trailing: const Icon(Icons.arrow_circle_right_outlined),
            onTap: () {
              context.push('/bloc');
            },
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Divider(),
          ),
          ListTile(
            title: const Text('Forms App'),
            subtitle: const Text('Otro gestor de estado compuesto'),
            trailing: const Icon(Icons.arrow_circle_right_outlined),
            onTap: () {
              context.push('/bloc');
            },
          ),
        ],
      ),
    );
  }
}
