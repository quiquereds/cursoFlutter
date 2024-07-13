import 'package:flutter/material.dart';

class TransparentView extends StatelessWidget {
  final Widget widget;

  static const String name = 'transparent-view';
  const TransparentView({super.key, required this.widget});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: Colors.black.withAlpha(100),
        ),
        child: Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: widget,
          ),
        ),
      ),
    );
  }
}
