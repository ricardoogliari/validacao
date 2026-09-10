import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:validacao/data/api_models/story.dart';
import 'package:validacao/utils/constants.dart';
import 'package:validacao/utils/user_extension.dart';

// ignore: must_be_immutable
class Detail extends StatefulWidget {
  Detail({
    super.key,
    required this.story,
    required this.currentUser,
    required this.onToggleLike,
    required this.onToggleReport,
  });

  Story story;
  final User? currentUser;

  final Story Function({required Story story}) onToggleLike;
  final Story Function({required Story story}) onToggleReport;

  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
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
                  imageUrl: widget.story.imageUrl,
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
                      color: widget.story.tagBgColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      widget.story.tag,
                      style: fontDetailTag.copyWith(
                        color: widget.story.tagColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(widget.story.title, style: fontDetailTitle),
                  const SizedBox(height: 12),
                  Text(widget.story.description, style: fontDetailDescription),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            border: Border.all(color: borderColor),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    widget.story.likes.contains(
                                          widget.currentUser?.customId,
                                        )
                                        ? Icons.favorite_rounded
                                        : Icons.favorite_border_rounded,
                                    color:
                                        widget.story.likes.contains(
                                          widget.currentUser?.customId,
                                        )
                                        ? Colors.red
                                        : textSecondaryColor,
                                    size: 18,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    '${widget.story.likes.length}',
                                    style: fontDetailAction,
                                  ),
                                ],
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 8.0),
                                child: Divider(height: 1),
                              ),
                              if (widget.story.likes.isNotEmpty)
                                ...widget.story.likes.map(
                                  (e) => Text(e.split('***')[1]),
                                ),
                              if (widget.story.likes.isEmpty)
                                const Text('Nenhum like efetuado.'),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      /*Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          border: Border.all(color: borderColor),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              widget.story.reports.contains(
                                    widget.currentUser?.customId,
                                  )
                                  ? Icons.report_rounded
                                  : Icons.report_gmailerrorred_rounded,
                              color:
                                  widget.story.reports.contains(
                                    widget.currentUser?.customId,
                                  )
                                  ? Colors.orange
                                  : textSecondaryColor,
                              size: 18,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              '${widget.story.reports.length}',
                              style: fontDetailAction,
                            ),
                          ],
                        ),
                      ),*/
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
