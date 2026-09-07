import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:validacao/data/api_models/story.dart';
import 'package:validacao/data/repositories/remote_stories_repository.dart';
import 'package:validacao/ui/view_models/home_view_model.dart';
import 'package:validacao/ui/widgets/detail.dart';
import 'package:validacao/ui/widgets/empty_state.dart';
import 'package:validacao/ui/widgets/filter_sections.dart';
import 'package:validacao/ui/widgets/header.dart';
import 'package:validacao/ui/widgets/story_card.dart';
import 'package:validacao/utils/constants.dart';

class AidConnectScreen extends StatefulWidget {
  const AidConnectScreen({super.key});

  @override
  State<AidConnectScreen> createState() => _AidConnectScreenState();
}

class _AidConnectScreenState extends State<AidConnectScreen> {
  User? _currentUser;

  String _selectedCategory = allNeeds;
  String _searchQuery = "";

  final HomeViewModel _viewModel = HomeViewModel(
    repository: RemoteStoriesRepository(),
  );

  @override
  void initState() {
    super.initState();
    _currentUser = FirebaseAuth.instance.currentUser;
    FirebaseAuth.instance.authStateChanges().listen((user) {
      if (mounted) {
        setState(() {
          _currentUser = user;
        });
      }
    });

    _readStories();
  }

  void _readStories() {
    _viewModel.getStories();
    /*
    db
      .collection("stories")
      .add(story.toMap())
      .then(
        (DocumentReference doc) => print(
          'DocumentSnapshot added with ID: ${doc.id}',
        ),
      );
    */
  }

  void _toggleLike(Story story) {
    setState(() {
      if (story.hasLiked) {
        story.hasLiked = false;
        story.likesCount--;
      } else {
        story.hasLiked = true;
        story.likesCount++;
      }
    });
  }

  void _toggleReport(Story story) {
    setState(() {
      story.isReported = !story.isReported;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          story.isReported
              ? 'Thank you for reporting. We will review this story.'
              : 'Report cancelled.',
        ),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _showDetailsDialog(Story story) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          clipBehavior: Clip.antiAlias,
          child: Detail(story: story),
        );
      },
    );
  }

  void _navigateToProfile() {
    Navigator.push(
      context,
      MaterialPageRoute<ProfileScreen>(
        builder: (context) => ProfileScreen(
          appBar: AppBar(
            title: Text(
              'User Profile',
              style: GoogleFonts.inter(fontWeight: FontWeight.bold),
            ),
            backgroundColor: Colors.white,
            foregroundColor: textPrimaryColor,
            elevation: 0,
          ),
          actions: [
            SignedOutAction((context) {
              Navigator.of(context).pop();
            }),
          ],
          children: [
            const Divider(),
            Padding(
              padding: const EdgeInsets.all(16),
              child: AspectRatio(
                aspectRatio: 1.5,
                child: Container(
                  decoration: BoxDecoration(
                    color: surfaceColor,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.favorite_rounded,
                        color: primaryTeal,
                        size: 64,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Thank you for being part of AidConnect!',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.bold,
                          color: textPrimaryColor,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _selectCategory({required String section}) {
    setState(() {
      _selectedCategory = section;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBackgroundColor,
      body: ListenableBuilder(
        listenable: _viewModel,
        builder: (context, child) {
          final filteredStories = _viewModel.filter(
            selectedCategory: _selectedCategory,
            searchQuery: _searchQuery,
          );
          return Column(
            children: [
              Header(
                navigationToProfile: _navigateToProfile,
                currentUser: _currentUser,
                updateSearchQuery: ({required query}) => setState(() {
                  _searchQuery = query;
                }),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(vertical: 32),
                  child: Center(
                    child: Container(
                      constraints: const BoxConstraints(maxWidth: 960),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FilterSections(callback: _selectCategory),
                          const SizedBox(height: 32),

                          // Story Feed Header
                          if (_searchQuery.isNotEmpty ||
                              _selectedCategory != allNeeds)
                            Padding(
                              padding: const EdgeInsets.only(
                                bottom: 16,
                                left: 8,
                              ),
                              child: Text(
                                'Search Results (${filteredStories.length})',
                                style: GoogleFonts.inter(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: textSecondaryColor,
                                ),
                              ),
                            ),

                          // Grid of Stories
                          if (filteredStories.isNotEmpty)
                            GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 24,
                                    mainAxisSpacing: 24,
                                    mainAxisExtent:
                                        385, // Explicit height matching mock layout
                                  ),
                              itemCount: filteredStories.length,
                              itemBuilder: (context, index) {
                                final story = filteredStories[index];

                                return StoryCard(
                                  story: story,
                                  onToggleLike: ({required story}) =>
                                      _toggleLike(story),
                                  onToggleReport: ({required story}) =>
                                      _toggleReport(story),
                                  onShowDetails: ({required story}) =>
                                      _showDetailsDialog(story),
                                );
                              },
                            )
                          else
                            EmptyState(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
