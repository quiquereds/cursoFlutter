import 'package:cinemapedia/config/helpers/human_formats.dart';
import 'package:flutter/material.dart';

class MovieRating extends StatelessWidget {
  final double voteAverage;
  final double popularity;

  const MovieRating({
    super.key,
    required this.voteAverage,
    required this.popularity,
  });

  @override
  Widget build(BuildContext context) {
    final textStyleTheme = Theme.of(context).textTheme;

    return SizedBox(
      width: 150,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.star_half_sharp,
            color: Colors.yellow.shade800,
          ),
          const SizedBox(width: 3),
          Text(
            HumanFormats.number(voteAverage),
            style: textStyleTheme.bodyMedium
                ?.copyWith(color: Colors.yellow.shade800),
          ),
          const Spacer(),
          Text(
            HumanFormats.number(popularity),
            style: textStyleTheme.bodySmall,
          )
        ],
      ),
    );
  }
}
