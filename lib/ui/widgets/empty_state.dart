import 'package:flutter/material.dart';
import 'package:validacao/utils/constants.dart';

class EmptyState extends StatelessWidget {
  const EmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 64),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: borderColor),
      ),
      child: Column(
        children: [
          const Icon(Icons.search_off_rounded, size: 64, color: iconMutedColor),
          const SizedBox(height: 16),
          Text(
            'No Stories Found',
            style: fontEmptyStateTitle,
          ),
          const SizedBox(height: 8),
          Text(
            'Try adjusting your search query or selected category.',
            style: fontEmptyStateSubtitle,
          ),
        ],
      ),
    );
  }
}
