import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Categories
const String allNeeds = 'Todos';
const String food = 'Alimento';
const String medical = 'Médico';
const String shelter = 'Abrigo';
const String education = 'Educação';
const String clothes = 'Roupas';

// Firebase environment config
const apiKey = String.fromEnvironment('apiKey');
const appId = String.fromEnvironment('appId');
const messagingSenderId = String.fromEnvironment('messagingSenderId');
const projectId = String.fromEnvironment('projectId');
const authDomain = String.fromEnvironment('authDomain');
const storageBucket = String.fromEnvironment('storageBucket');

// App & UI Colors
const Color appBackgroundColor = Color(0xFFF6F8F8);
const Color surfaceColor = Color(0xFFF1F5F9);
const Color borderColor = Color(0xFFE2E8F0);
const Color shadowColor = Color(0x0D000000);

const Color primaryTeal = Color(0xFF2BEECD);
const Color primaryTealLight = Color(0x332BEECD);
const Color darkTeal = Color(0xFF0D9488);

const Color textPrimaryColor = Color(0xFF0F172A);
const Color textSecondaryColor = Color(0xFF475569);
const Color textMutedColor = Color(0xFF64748B);
const Color textDarkColor = Color(0xFF334155);
const Color iconMutedColor = Color(0xFF94A3B8);

// Tag / Category Colors
const Color tagRedColor = Color(0xFFDC2626);
const Color tagRedBgColor = Color(0xFFFEE2E2);
const Color tagBlueColor = Color(0xFF3B82F6);
const Color tagBlueBgColor = Color(0xFFEFF6FF);
const Color tagPurpleColor = Color(0xFFA855F7);
const Color tagPurpleBgColor = Color(0xFFF3E8FF);
const Color tagPinkColor = Color(0xFFEC4899);
const Color tagPinkBgColor = Color(0xFFFCE7F3);
const Color tagGreenColor = Color(0xFF22C55E);
const Color tagGreenBgColor = Color(0xFFDCFCE7);

// Typography / TextStyles
final TextStyle fontDetailTag = GoogleFonts.inter(
  fontSize: 10,
  fontWeight: FontWeight.bold,
  letterSpacing: 0.5,
);

final TextStyle fontDetailTitle = GoogleFonts.inter(
  fontSize: 22,
  fontWeight: FontWeight.bold,
  color: textPrimaryColor,
);

final TextStyle fontDetailDescription = GoogleFonts.inter(
  fontSize: 15,
  color: textSecondaryColor,
  height: 1.6,
);

final TextStyle fontDetailAction = GoogleFonts.inter(
  fontWeight: FontWeight.bold,
  color: textDarkColor,
);

final TextStyle fontStoryCardTag = GoogleFonts.inter(
  fontSize: 12,
  fontWeight: FontWeight.bold,
  letterSpacing: 0.3,
);

final TextStyle fontStoryCardTitle = GoogleFonts.inter(
  fontSize: 18,
  fontWeight: FontWeight.bold,
  color: textPrimaryColor,
);

final TextStyle fontStoryCardDescription = GoogleFonts.inter(
  fontSize: 14,
  color: textMutedColor,
  height: 1.4,
);

final TextStyle fontStoryCardButton = GoogleFonts.inter(
  fontSize: 12,
  fontWeight: FontWeight.bold,
  color: darkTeal,
);

final TextStyle fontEmptyStateTitle = GoogleFonts.inter(
  fontSize: 18,
  fontWeight: FontWeight.bold,
  color: textPrimaryColor,
);

final TextStyle fontEmptyStateSubtitle = GoogleFonts.inter(
  fontSize: 14,
  color: textMutedColor,
);

final TextStyle fontFilterSectionTitle = GoogleFonts.inter(
  fontSize: 20,
  fontWeight: FontWeight.bold,
  color: textPrimaryColor,
);

final TextStyle fontCategorySelected = GoogleFonts.inter(
  fontSize: 14,
  fontWeight: FontWeight.bold,
  color: textPrimaryColor,
);

final TextStyle fontCategoryUnselected = GoogleFonts.inter(
  fontSize: 14,
  fontWeight: FontWeight.w500,
  color: textDarkColor,
);

final TextStyle fontHeaderBrand = GoogleFonts.inter(
  fontSize: 18,
  fontWeight: FontWeight.bold,
  color: textPrimaryColor,
  letterSpacing: -0.45,
);

final TextStyle fontHeaderSearch = GoogleFonts.inter(
  fontSize: 14,
  color: textPrimaryColor,
);

final TextStyle fontHeaderSearchHint = GoogleFonts.inter(
  fontSize: 14,
  color: textMutedColor,
);

final TextStyle fontProfileAppBarTitle = GoogleFonts.inter(
  fontWeight: FontWeight.bold,
);

final TextStyle fontProfileBannerTitle = GoogleFonts.inter(
  fontSize: 16,
  fontWeight: FontWeight.bold,
  color: textPrimaryColor,
);

final TextStyle fontSearchResultsHeader = GoogleFonts.inter(
  fontSize: 16,
  fontWeight: FontWeight.bold,
  color: textSecondaryColor,
);
