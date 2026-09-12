import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:validacao/data/api_models/story.dart';
import 'package:validacao/utils/constants.dart';

class CreateStoryDialog extends StatefulWidget {
  const CreateStoryDialog({super.key, required this.onSubmit});

  final Future<bool> Function(Story story) onSubmit;

  @override
  State<CreateStoryDialog> createState() => _CreateStoryDialogState();
}

class _CreateStoryDialogState extends State<CreateStoryDialog> {
  final _formKey = GlobalKey<FormState>();

  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _tagController = TextEditingController();
  final _imageUrlController = TextEditingController();

  String _selectedCategory = food;
  bool _isUrgent = false;
  bool _isSubmitting = false;

  final List<String> _categories = [food, medical, shelter, education, clothes];

  @override
  void initState() {
    super.initState();
    _tagController.text = _getDefaultTagForCategory(_selectedCategory);
    _imageUrlController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _tagController.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  String _getDefaultTagForCategory(String category) {
    switch (category) {
      case food:
        return 'ALIMENTO';
      case medical:
        return 'MÉDICO';
      case shelter:
        return 'ABRIGO';
      case education:
        return 'EDUCAÇÃO';
      case clothes:
        return 'ROUPAS';
      default:
        return category.toUpperCase();
    }
  }

  (Color, Color) _getTagColorsForCategory(String category) {
    switch (category) {
      case food:
        return (tagRedColor, tagRedBgColor);
      case medical:
        return (tagBlueColor, tagBlueBgColor);
      case shelter:
        return (tagGreenColor, tagGreenBgColor);
      case education:
        return (tagPurpleColor, tagPurpleBgColor);
      case clothes:
        return (tagPinkColor, tagPinkBgColor);
      default:
        return (darkTeal, primaryTealLight);
    }
  }

  void _onCategoryChanged(String? newCategory) {
    if (newCategory == null) return;
    setState(() {
      _selectedCategory = newCategory;
      _tagController.text = _getDefaultTagForCategory(newCategory);
    });
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    final (tagColor, tagBgColor) = _getTagColorsForCategory(_selectedCategory);

    final story = Story(
      id: '',
      category: _selectedCategory,
      tag: _tagController.text.trim().toUpperCase(),
      tagColor: tagColor,
      tagBgColor: tagBgColor,
      title: _titleController.text.trim(),
      description: _descriptionController.text.trim(),
      imageUrl: _imageUrlController.text.trim(),
      isUrgent: _isUrgent,
      likes: [],
      reports: [],
    );

    final success = await widget.onSubmit(story);

    if (mounted) {
      setState(() {
        _isSubmitting = false;
      });
      if (success) {
        Navigator.of(context).pop(true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final (tagColor, tagBgColor) = _getTagColorsForCategory(_selectedCategory);

    return Container(
      constraints: const BoxConstraints(maxWidth: 580),
      padding: const EdgeInsets.all(28),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Nova História', style: fontDetailTitle),
                  CircleAvatar(
                    backgroundColor: surfaceColor,
                    radius: 18,
                    child: IconButton(
                      icon: const Icon(
                        Icons.close,
                        size: 18,
                        color: textPrimaryColor,
                      ),
                      onPressed: () => Navigator.pop(context),
                      padding: EdgeInsets.zero,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                'Compartilhe uma causa para receber apoio da comunidade.',
                style: fontDetailDescription.copyWith(fontSize: 14),
              ),
              const SizedBox(height: 24),

              // Title
              Text(
                'Título',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: textPrimaryColor,
                ),
              ),
              const SizedBox(height: 6),
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  hintText: 'Ex: Apoio para Família Silva',
                  hintStyle: fontHeaderSearchHint,
                  filled: true,
                  fillColor: surfaceColor,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: borderColor),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: borderColor),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Por favor, informe o título.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Category & Tag row
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Category Dropdown
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Categoria',
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: textPrimaryColor,
                          ),
                        ),
                        const SizedBox(height: 6),
                        DropdownButtonFormField<String>(
                          initialValue: _selectedCategory,
                          items: _categories.map((cat) {
                            return DropdownMenuItem(
                              value: cat,
                              child: Text(cat, style: fontCategoryUnselected),
                            );
                          }).toList(),
                          onChanged: _onCategoryChanged,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: surfaceColor,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(color: borderColor),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(color: borderColor),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Tag Input
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Tag',
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: textPrimaryColor,
                          ),
                        ),
                        const SizedBox(height: 6),
                        TextFormField(
                          controller: _tagController,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: surfaceColor,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(color: borderColor),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(color: borderColor),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Tag preview pill
              Row(
                children: [
                  Text(
                    'Preview da tag: ',
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      color: textMutedColor,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: tagBgColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      _tagController.text.isNotEmpty
                          ? _tagController.text.toUpperCase()
                          : _selectedCategory.toUpperCase(),
                      style: fontDetailTag.copyWith(color: tagColor),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Description
              Text(
                'Descrição',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: textPrimaryColor,
                ),
              ),
              const SizedBox(height: 6),
              TextFormField(
                controller: _descriptionController,
                minLines: 3,
                maxLines: 5,
                decoration: InputDecoration(
                  hintText:
                      'Descreva a necessidade e como as pessoas podem contribuir...',
                  hintStyle: fontHeaderSearchHint,
                  filled: true,
                  fillColor: surfaceColor,
                  contentPadding: const EdgeInsets.all(16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: borderColor),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: borderColor),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Por favor, informe a descrição.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Image URL
              Text(
                'URL da Imagem',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: textPrimaryColor,
                ),
              ),
              const SizedBox(height: 6),
              TextFormField(
                controller: _imageUrlController,
                decoration: InputDecoration(
                  hintText: 'https://images.unsplash.com/...',
                  hintStyle: fontHeaderSearchHint,
                  filled: true,
                  fillColor: surfaceColor,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: borderColor),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: borderColor),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Por favor, informe uma URL de imagem.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),

              // Image Preview
              if (_imageUrlController.text.trim().isNotEmpty)
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: SizedBox(
                    height: 150,
                    width: double.infinity,
                    child: CachedNetworkImage(
                      imageUrl: _imageUrlController.text.trim(),
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        color: surfaceColor,
                        child: const Center(
                          child: Icon(
                            Icons.image_outlined,
                            color: iconMutedColor,
                            size: 32,
                          ),
                        ),
                      ),
                      errorWidget: (context, url, error) => Container(
                        color: surfaceColor,
                        padding: const EdgeInsets.all(8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.broken_image,
                              color: iconMutedColor,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'URL de imagem inválida ou inacessível',
                              style: GoogleFonts.inter(
                                fontSize: 12,
                                color: textMutedColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              const SizedBox(height: 16),

              // Urgent Switch
              Material(
                color: surfaceColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: const BorderSide(color: borderColor),
                ),
                clipBehavior: Clip.antiAlias,
                child: SwitchListTile(
                  title: Text(
                    'Pedido Urgente',
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: textPrimaryColor,
                    ),
                  ),
                  subtitle: Text(
                    'Destaque esta história com prioridade urgente.',
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      color: textMutedColor,
                    ),
                  ),
                  value: _isUrgent,
                  activeThumbColor: tagRedColor,
                  onChanged: (value) {
                    setState(() {
                      _isUrgent = value;
                    });
                  },
                ),
              ),
              const SizedBox(height: 24),

              // Submit Button
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: _isSubmitting ? null : _submit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryTeal,
                    foregroundColor: textPrimaryColor,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: _isSubmitting
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: textPrimaryColor,
                          ),
                        )
                      : Text(
                          'Publicar História',
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
