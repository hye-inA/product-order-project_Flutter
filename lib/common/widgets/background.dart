import 'package:flutter/material.dart';

import '../const/app_colors.dart';

class Background extends StatelessWidget {
  final List<Widget> children;
  final double? height;

  const Background({
    required this.children,
    this.height,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: AppColors.PRIMARY_GREEN,
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: height,
              ),
              ...children,
            ],
          ),
        ),
      ),
    );
  }
}
