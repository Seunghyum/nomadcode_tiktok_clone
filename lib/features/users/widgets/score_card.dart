import 'package:flutter/material.dart';
import 'package:nomadcode_tiktok_clone/constants/gaps.dart';
import 'package:nomadcode_tiktok_clone/constants/sizes.dart';

class ScoreCard extends StatelessWidget {
  final String score;
  final String title;

  const ScoreCard({
    required this.score,
    required this.title,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          score,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: Sizes.size18,
          ),
        ),
        Gaps.v3,
        Text(
          title,
          style: TextStyle(color: Colors.grey.shade500),
        ),
      ],
    );
  }
}
