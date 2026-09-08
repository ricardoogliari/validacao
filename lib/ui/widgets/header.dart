import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:validacao/utils/constants.dart';

class Header extends StatefulWidget {
  const Header({
    super.key,
    required this.navigationToProfile,
    required this.currentUser,
    required this.updateSearchQuery,
  });

  final Function() navigationToProfile;
  final Function({required String query}) updateSearchQuery;
  final User? currentUser;

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: appBackgroundColor,
        border: Border(bottom: BorderSide(color: borderColor, width: 1)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Left: Brand Logo & Links
          Row(
            children: [
              // Logo Icon
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: primaryTealLight,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(
                  Icons.favorite_rounded,
                  color: darkTeal,
                  size: 16,
                ),
              ),
              const SizedBox(width: 12),
              // Brand Name
              Text(
                'ValidAção',
                style: fontHeaderBrand,
              ),
            ],
          ),
          // Right: Search & Profile Avatar
          Row(
            children: [
              // Search Input
              Container(
                width: 256,
                height: 40,
                decoration: BoxDecoration(
                  color: surfaceColor,
                  borderRadius: BorderRadius.circular(24),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    const Icon(
                      Icons.search,
                      size: 16,
                      color: textMutedColor,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        onChanged: (value) {
                          setState(() {
                            _searchQuery = value;
                            widget.updateSearchQuery(query: _searchQuery);
                          });
                        },
                        style: fontHeaderSearch,
                        decoration: InputDecoration(
                          hintText: 'Busque histórias...',
                          hintStyle: fontHeaderSearchHint,
                          border: InputBorder.none,
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                        ),
                      ),
                    ),
                    if (_searchQuery.isNotEmpty)
                      IconButton(
                        icon: const Icon(
                          Icons.clear,
                          size: 14,
                          color: textMutedColor,
                        ),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        onPressed: () {
                          setState(() {
                            _searchController.clear();
                            _searchQuery = '';
                            widget.updateSearchQuery(query: _searchQuery);
                          });
                        },
                      ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              // User Profile Avatar with Teal Border
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: widget.navigationToProfile,
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: primaryTeal,
                        width: 2,
                      ),
                    ),
                    child: ClipOval(
                      child: widget.currentUser?.photoURL != null
                          ? CachedNetworkImage(
                              imageUrl: widget.currentUser!.photoURL!,
                              fit: BoxFit.cover,
                              errorWidget: (context, url, error) => const Icon(
                                Icons.person,
                                color: textSecondaryColor,
                              ),
                            )
                          : const Icon(Icons.person, color: textSecondaryColor),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
