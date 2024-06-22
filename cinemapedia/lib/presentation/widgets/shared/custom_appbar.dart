import 'package:cinemapedia/config/constants/images.dart';
import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: SizedBox(
          width: double.infinity,
          child: Row(
            children: [
              Image.asset(
                cinemexLogo,
                scale: 0.5,
              ),
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
