import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class VoteIndicator extends StatelessWidget {
  const VoteIndicator({
    super.key,
    required this.voteAverage,
  });

  final double voteAverage;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 44,
      height: 44,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(44),
        color: Colors.black,
      ),
      child: Center(
        child: CircularPercentIndicator(
          radius: 18,
          lineWidth: 2,
          percent: voteAverage / 10,
          center: Text(
            '$voteAverage',
          ),
          progressColor: Colors.green,
        ),
      ),
    );
  }
}
