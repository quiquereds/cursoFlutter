import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textStyleTheme = Theme.of(context).textTheme;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: SizedBox(
          width: double.infinity,
          child: Row(
            children: [
              Icon(
                Icons.movie_outlined,
                size: 30,
                color: colors.primary,
              ),
              const SizedBox(width: 10),
              Text('Cinemapedia', style: textStyleTheme.titleLarge),
              const Spacer(),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.search),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
