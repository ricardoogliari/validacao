import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:validacao/data/api_models/story.dart';
import 'package:validacao/data/repositories/remote_stories_repository.dart';
import 'package:validacao/ui/view/profile_screen.dart';
import 'package:validacao/ui/view/sign_in_screen.dart';
import 'package:validacao/ui/view_models/home_view_model.dart';
import 'package:validacao/ui/widgets/detail.dart';
import 'package:validacao/ui/widgets/empty_state.dart';
import 'package:validacao/ui/widgets/filter_sections.dart';
import 'package:validacao/ui/widgets/header.dart';
import 'package:validacao/ui/widgets/story_card.dart';
import 'package:validacao/utils/constants.dart';
import 'package:validacao/utils/user_extension.dart';

class AidConnectScreen extends StatefulWidget {
  const AidConnectScreen({super.key, required this.user});

  final User? user;

  @override
  State<AidConnectScreen> createState() => _AidConnectScreenState();
}

class _AidConnectScreenState extends State<AidConnectScreen> {
  String _selectedCategory = allNeeds;
  String _searchQuery = '';

  final HomeViewModel _viewModel = HomeViewModel(
    repository: RemoteStoriesRepository(),
  );

  @override
  void initState() {
    super.initState();

    _readStories();
  }

  void _readStories() {
    _viewModel.getStories();
  }

  Story _toggleLike(Story story) {
    if (widget.user == null) {
      _navigateToProfile();
    } else {
      if (story.likes.contains(widget.user?.customId)) {
        story.likes.remove(widget.user?.customId);
        _viewModel.updateStory(story: story);
      } else {
        story.likes.add(widget.user?.customId ?? '');
        _viewModel.updateStory(story: story);
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            story.likes.contains(widget.user?.customId)
                ? 'Like registrado.'
                : 'Like cancelado.',
          ),
          duration: const Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }

    return story;
  }

  Story _toggleReport(Story story) {
    if (widget.user == null) {
      _navigateToProfile();
    } else {
      if (story.reports.contains(widget.user?.customId)) {
        story.reports.remove(widget.user?.customId);
        _viewModel.updateStory(story: story);
      } else {
        story.reports.add(widget.user?.customId ?? '');
        _viewModel.updateStory(story: story);
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            story.reports.contains(widget.user?.customId)
                ? 'Aviso registrado.'
                : 'Aviso cancelado.',
          ),
          duration: const Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }

    return story;
  }

  void _showDetailsDialog(Story story) {
    showDialog<void>(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          clipBehavior: Clip.antiAlias,
          child: Detail(
            story: story,
            currentUser: widget.user,
            onToggleLike: ({required story}) => _toggleLike(story),
            onToggleReport: ({required story}) => _toggleReport(story),
          ),
        );
      },
    );
  }

  void _navigateToProfile() {
    if (widget.user == null) {
      Navigator.push(
        context,
        MaterialPageRoute<SignInScreen>(
          builder: (context) => const SignInScreen(),
        ),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute<ProfileScreen>(
          builder: (context) => const ProfileScreen(),
        ),
      );
    }
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
                currentUser: widget.user,
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
                                style: fontSearchResultsHeader,
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
                                  currentUser: widget.user,
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
                            const EmptyState(),
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
