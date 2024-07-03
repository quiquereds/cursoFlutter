import 'package:flutter/material.dart';

class CategoriesView extends StatelessWidget {
  static const String name = 'categories-view';

  const CategoriesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categories View'),
      ),
      body: const Center(
        child: Text('Categorias'),
      ),
    );
  }
}
