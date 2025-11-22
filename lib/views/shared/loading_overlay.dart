import 'package:flutter/material.dart';

class LoadingOverlay extends StatelessWidget {
  final bool isLoading;
  final bool solidBackground;

  const LoadingOverlay({
    super.key,
    required this.isLoading,
    this.solidBackground = false,
  });

  @override
  Widget build(BuildContext context) {
    if (!isLoading) return const SizedBox.shrink();

    return Stack(
      children: [
        if (solidBackground)
          Container(color: Colors.white)
        else
          Container(color: Colors.black.withValues(alpha: 0.5)),

        // Loading indicator
        const Center(child: CircularProgressIndicator(
          color: Colors.white,
        )),
      ],
    );
  }
}
