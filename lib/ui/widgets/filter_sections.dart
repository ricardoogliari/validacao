import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:validacao/data/api_models/category_item.dart';
import 'package:validacao/utils/constants.dart';

class FilterSections extends StatefulWidget {
  const FilterSections({super.key, required this.callback});

  final void Function({required String section}) callback;

  @override
  State<FilterSections> createState() => _FilterSectionsState();
}

class _FilterSectionsState extends State<FilterSections> {
  final List<CategoryItem> _categories = const [
    CategoryItem(label: allNeeds, icon: Icons.grid_view_rounded),
    CategoryItem(label: food, icon: Icons.restaurant_rounded),
    CategoryItem(label: medical, icon: Icons.medical_services_rounded),
    CategoryItem(label: shelter, icon: Icons.home_rounded),
    CategoryItem(label: education, icon: Icons.school_rounded),
    CategoryItem(label: clothes, icon: Icons.checkroom_rounded),
  ];

  String _selectedCategory = allNeeds;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(
            'Como você gostaria de ajudar?',
            style: GoogleFonts.inter(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF0F172A),
            ),
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 40,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _categories.length,
            itemBuilder: (context, index) {
              final cat = _categories[index];
              final isSelected = _selectedCategory == cat.label;
              return Padding(
                padding: const EdgeInsets.only(right: 12.0),
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedCategory = cat.label;
                        widget.callback(section: cat.label);
                      });
                    },
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        color: isSelected
                            ? const Color(0xFF2BEECD)
                            : Colors.white,
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(
                          color: isSelected
                              ? const Color(0xFF2BEECD)
                              : const Color(0xFFE2E8F0),
                        ),
                        boxShadow: isSelected
                            ? [
                                const BoxShadow(
                                  color: Color(0x0D000000),
                                  blurRadius: 1,
                                  offset: Offset(0, 1),
                                ),
                              ]
                            : null,
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            cat.icon,
                            size: 16,
                            color: isSelected
                                ? const Color(0xFF0F172A)
                                : const Color(0xFF475569),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            cat.label,
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              fontWeight: isSelected
                                  ? FontWeight.bold
                                  : FontWeight.w500,
                              color: isSelected
                                  ? const Color(0xFF0F172A)
                                  : const Color(0xFF334155),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
