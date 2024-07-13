import 'package:cinemapedia/config/helpers/human_formats.dart';
import 'package:cinemapedia/config/helpers/rating_gradients.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

class MovieRating extends StatelessWidget {
  final double voteAverage;

  const MovieRating({
    super.key,
    required this.voteAverage,
  });

  @override
  Widget build(BuildContext context) {
    final textStyleTheme = Theme.of(context).textTheme;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          colors: RatingHelpers.getGradients(voteAverage),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 5,
          vertical: 5,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              IconlyBold.star,
              size: 20,
            ),
            const SizedBox(width: 3),
            Text(
              HumanFormats.number(voteAverage),
              style: textStyleTheme.titleSmall,
            ),
          ],
        ),
      ),
    );
  }
}
