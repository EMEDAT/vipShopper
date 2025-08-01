import 'package:flutter/material.dart';

class ResponsiveGrid {
  static int getCrossAxisCount(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    
    if (screenWidth > 800) {
      return 3; // Large screens - tablets/desktop
    } else if (screenWidth > 500) {
      return 2; // Medium screens - large phones
    } else {
      return 1; // Small screens - phones
    }
  }
  
  static double getChildAspectRatio(BuildContext context) {
    final crossAxisCount = getCrossAxisCount(context);
    
    switch (crossAxisCount) {
      case 1:
        return 0.5; // Much taller cards for single column
      case 2:
        return 0.65; // Taller cards for two columns
      case 3:
      default:
        return 0.7; // Original aspect ratio for three columns
    }
  }
  
  static double getSpacing(BuildContext context) {
    final crossAxisCount = getCrossAxisCount(context);
    
    switch (crossAxisCount) {
      case 1:
        return 20.0;
      case 2:
        return 16.0;
      case 3:
      default:
        return 12.0;
    }
  }
  
  // Header responsive functions
  static double getExpandedHeight(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    
    if (screenWidth > 800) {
      return 220.0; // Large screens
    } else if (screenWidth > 500) {
      return 180.0; // Medium screens
    } else {
      return screenHeight < 700 ? 140.0 : 160.0; // Small screens
    }
  }
  
  static double getTitleFontSize(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    
    if (screenWidth > 800) {
      return 20.0;
    } else if (screenWidth > 500) {
      return 18.0;
    } else {
      return 16.0;
    }
  }
  
  static EdgeInsets getHeaderPadding(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final expandedHeight = getExpandedHeight(context);
    
    if (screenWidth > 800) {
      return const EdgeInsets.only(top: 80, left: 24, right: 24);
    } else if (screenWidth > 500) {
      return const EdgeInsets.only(top: 60, left: 20, right: 20);
    } else {
      return EdgeInsets.only(
        top: expandedHeight * 0.35, // Dynamic top based on height
        left: 16, 
        right: 16
      );
    }
  }
}