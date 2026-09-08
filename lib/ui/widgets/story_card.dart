import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:validacao/data/api_models/story.dart';
import 'package:validacao/utils/constants.dart';

class StoryCard extends StatelessWidget {
  const StoryCard({
    super.key,
    required this.story,
    required this.currentUser,
    required this.onToggleLike,
    required this.onToggleReport,
    required this.onShowDetails,
  });

  final Story story;
  final User? currentUser;
  final Function({required Story story}) onToggleLike;
  final Function({required Story story}) onToggleReport;
  final Function({required Story story}) onShowDetails;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: borderColor, width: 1),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Card Image
          SizedBox(
            height: 192,
            width: double.infinity,
            child: CachedNetworkImage(
              imageUrl: story.imageUrl,
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(
                color: borderColor,
                child: const Center(child: CircularProgressIndicator()),
              ),
              errorWidget: (context, url, error) => Container(
                color: borderColor,
                child: const Icon(
                  Icons.broken_image,
                  size: 40,
                  color: iconMutedColor,
                ),
              ),
            ),
          ),
          // Content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Tag
                      Text(
                        story.tag,
                        style: fontStoryCardTag.copyWith(color: story.tagColor),
                      ),
                      const SizedBox(height: 4),
                      // Title
                      Text(
                        story.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: fontStoryCardTitle,
                      ),
                      const SizedBox(height: 6),
                      // Description
                      Text(
                        story.description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: fontStoryCardDescription,
                      ),
                    ],
                  ),
                  // Footer Actions
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(
                              story.isLiked(user: currentUser?.uid ?? "")
                                  ? Icons.favorite_rounded
                                  : Icons.favorite_border_rounded,
                              color: story.isLiked(user: currentUser?.uid ?? "")
                                  ? Colors.red
                                  : textMutedColor,
                            ),
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                            iconSize: 20,
                            onPressed: () => onToggleLike(story: story),
                          ),
                          const SizedBox(width: 12),
                          IconButton(
                            icon: Icon(
                              story.isReported(user: currentUser?.uid ?? "")
                                  ? Icons.report_rounded
                                  : Icons.report_gmailerrorred_rounded,
                              color:
                                  story.isReported(user: currentUser?.uid ?? "")
                                  ? Colors.orange
                                  : textMutedColor,
                            ),
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                            iconSize: 20,
                            onPressed: () => onToggleReport(story: story),
                          ),
                        ],
                      ),
                      // See Details Button
                      OutlinedButton(
                        onPressed: () => onShowDetails(story: story),
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: primaryTeal),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 17,
                            vertical: 10,
                          ),
                        ),
                        child: Text('See Details', style: fontStoryCardButton),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
