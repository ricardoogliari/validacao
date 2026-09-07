import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:validacao/data/api_models/story.dart';
import 'package:validacao/utils/constants.dart';

class Detail extends StatelessWidget {
  const Detail({super.key, required this.story});

  final Story story;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 600),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                CachedNetworkImage(
                  imageUrl: story.imageUrl,
                  height: 250,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    height: 250,
                    color: borderColor,
                    child: const Center(child: CircularProgressIndicator()),
                  ),
                  errorWidget: (context, url, error) => Container(
                    height: 250,
                    color: borderColor,
                    child: const Icon(
                      Icons.broken_image,
                      size: 50,
                      color: iconMutedColor,
                    ),
                  ),
                ),
                Positioned(
                  top: 16,
                  right: 16,
                  child: CircleAvatar(
                    backgroundColor: Colors.white.withValues(alpha: 0.9),
                    child: IconButton(
                      icon: const Icon(Icons.close, color: textPrimaryColor),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: story.tagBgColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      story.tag,
                      style: GoogleFonts.inter(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: story.tagColor,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    story.title,
                    style: GoogleFonts.inter(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: textPrimaryColor,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    story.description,
                    style: GoogleFonts.inter(
                      fontSize: 15,
                      color: textSecondaryColor,
                      height: 1.6,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          OutlinedButton.icon(
                            onPressed: () {
                              Navigator.pop(context);
                              //_toggleLike(story);
                            },
                            icon: Icon(
                              story.hasLiked
                                  ? Icons.favorite_rounded
                                  : Icons.favorite_border_rounded,
                              color: story.hasLiked
                                  ? Colors.red
                                  : textSecondaryColor,
                              size: 18,
                            ),
                            label: Text(
                              '${story.likesCount}',
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.bold,
                                color: textDarkColor,
                              ),
                            ),
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: borderColor),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 12,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          OutlinedButton.icon(
                            onPressed: () {
                              Navigator.pop(context);
                              //_toggleReport(story);
                            },
                            icon: Icon(
                              story.isReported
                                  ? Icons.report_rounded
                                  : Icons.report_gmailerrorred_rounded,
                              color: story.isReported
                                  ? Colors.orange
                                  : textSecondaryColor,
                              size: 18,
                            ),
                            label: Text(
                              story.isReported ? 'Reported' : 'Report',
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.bold,
                                color: textDarkColor,
                              ),
                            ),
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: borderColor),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
