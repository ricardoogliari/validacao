import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:validacao/data/api_models/story.dart';
import 'package:validacao/utils/constants.dart';

class Detail extends StatelessWidget {
  const Detail({super.key, required this.story, required this.currentUser});

  final Story story;
  final User? currentUser;

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
                      style: fontDetailTag.copyWith(color: story.tagColor),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(story.title, style: fontDetailTitle),
                  const SizedBox(height: 12),
                  Text(story.description, style: fontDetailDescription),
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
                              story.isLiked(user: currentUser?.uid ?? "")
                                  ? Icons.favorite_rounded
                                  : Icons.favorite_border_rounded,
                              color: story.isLiked(user: currentUser?.uid ?? "")
                                  ? Colors.red
                                  : textSecondaryColor,
                              size: 18,
                            ),
                            label: Text(
                              '${story.likes.length}',
                              style: fontDetailAction,
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
                              story.isReported(user: currentUser?.uid ?? "")
                                  ? Icons.report_rounded
                                  : Icons.report_gmailerrorred_rounded,
                              color:
                                  story.isReported(user: currentUser?.uid ?? "")
                                  ? Colors.orange
                                  : textSecondaryColor,
                              size: 18,
                            ),
                            label: Text(
                              '${story.reports.length}',
                              style: fontDetailAction,
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
