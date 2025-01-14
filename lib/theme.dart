import 'package:flutter/material.dart';

class SquashboundTheme {
  static Color get primaryColor => const Color(0xFFDD132B);
  static Color get backgroundColor => const Color(0xFF221d1b);
  static Color get foregroundColor => const Color(0xFFEEE4DA);
  static Color get cardColor => const Color(0xFF1A1615);
  static Color get secondaryColor => const Color(0xFFA7DD13);
  static Color get tertiaryColor => const Color.fromARGB(255, 19, 113, 221);

  static double get borderRadiusLarge => 10.0;
  static double get borderRadiusSmall => 5.0;

  static RoundedRectangleBorder roundedRectangleBorder(
      {required double radius, bool withBorder = true}) {
    return RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(radius),
      side: withBorder
          ? BorderSide(
              color: foregroundColor,
              width: 4.0,
              strokeAlign: BorderSide.strokeAlignOutside,
            )
          : BorderSide.none,
    );
  }

  static TextTheme get textTheme => TextTheme(
        bodyLarge: TextStyle(
          fontSize: 24.0,
          color: foregroundColor,
          fontFamily: 'Outfit',
        ),
        bodyMedium: TextStyle(
          fontSize: 18.0,
          color: foregroundColor,
          fontFamily: 'Outfit',
        ),
        bodySmall: TextStyle(
          fontSize: 12.0,
          color: foregroundColor,
          fontFamily: 'Outfit',
        ),
        displayLarge: TextStyle(
          fontSize: 48.0,
          color: foregroundColor,
          fontFamily: 'Outfit',
        ),
        displayMedium: TextStyle(
          fontSize: 36.0,
          color: foregroundColor,
          fontFamily: 'Outfit',
        ),
        displaySmall: TextStyle(
          fontSize: 24.0,
          color: foregroundColor,
          fontFamily: 'Outfit',
        ),
        headlineLarge: TextStyle(
          fontSize: 24.0,
          color: foregroundColor,
          fontFamily: 'Outfit',
          fontWeight: FontWeight.bold,
        ),
        headlineMedium: TextStyle(
          fontSize: 18.0,
          color: foregroundColor,
          fontFamily: 'Outfit',
          fontWeight: FontWeight.bold,
        ),
        headlineSmall: TextStyle(
          fontSize: 14.0,
          color: foregroundColor,
          fontFamily: 'Outfit',
          fontWeight: FontWeight.bold,
        ),
        labelLarge: TextStyle(
          fontSize: 24.0,
          color: foregroundColor,
          fontFamily: 'Outfit',
        ),
        labelMedium: TextStyle(
          fontSize: 18.0,
          color: foregroundColor,
          fontFamily: 'Outfit',
        ),
        labelSmall: TextStyle(
          fontSize: 14.0,
          color: foregroundColor,
          fontFamily: 'Outfit',
        ),
        titleLarge: TextStyle(
          fontSize: 64.0,
          color: foregroundColor,
          fontFamily: 'LoversQuarrel',
        ),
        titleMedium: TextStyle(
          fontSize: 58.0,
          color: foregroundColor,
          fontFamily: 'LoversQuarrel',
        ),
        titleSmall: TextStyle(
          fontSize: 42.0,
          color: foregroundColor,
          fontFamily: 'LoversQuarrel',
        ),
      );

  static ThemeData get theme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorSchemeSeed: backgroundColor,
      scaffoldBackgroundColor: backgroundColor,
      fontFamily: 'Outfit',
      textTheme: textTheme,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(primaryColor),
          foregroundColor: WidgetStatePropertyAll(foregroundColor),
          textStyle: WidgetStatePropertyAll(textTheme.headlineMedium),
          padding: WidgetStatePropertyAll(EdgeInsets.symmetric(
            horizontal: 24.0,
            vertical: 18.0,
          )),
          elevation: WidgetStatePropertyAll(0.0),
          iconColor: WidgetStatePropertyAll(foregroundColor),
          iconSize: WidgetStatePropertyAll(24.0),
          shape: WidgetStatePropertyAll(
            roundedRectangleBorder(radius: borderRadiusSmall),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(backgroundColor),
          foregroundColor: WidgetStatePropertyAll(foregroundColor),
          textStyle: WidgetStatePropertyAll(textTheme.headlineMedium),
          padding: WidgetStatePropertyAll(EdgeInsets.symmetric(
            horizontal: 24.0,
            vertical: 18.0,
          )),
          elevation: WidgetStatePropertyAll(0.0),
          iconColor: WidgetStatePropertyAll(foregroundColor),
          iconSize: WidgetStatePropertyAll(24.0),
          shape: WidgetStatePropertyAll(
            roundedRectangleBorder(
                radius: borderRadiusSmall, withBorder: false),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(backgroundColor),
          foregroundColor: WidgetStatePropertyAll(foregroundColor),
          textStyle: WidgetStatePropertyAll(textTheme.headlineMedium),
          padding: WidgetStatePropertyAll(EdgeInsets.symmetric(
            horizontal: 24.0,
            vertical: 18.0,
          )),
          elevation: WidgetStatePropertyAll(0.0),
          iconColor: WidgetStatePropertyAll(foregroundColor),
          iconSize: WidgetStatePropertyAll(24.0),
          side: WidgetStatePropertyAll(BorderSide(
            color: foregroundColor,
            width: 4.0,
            strokeAlign: BorderSide.strokeAlignOutside,
          )),
          shape: WidgetStatePropertyAll(
            roundedRectangleBorder(
                radius: borderRadiusSmall, withBorder: false),
          ),
        ),
      ),
      iconButtonTheme: IconButtonThemeData(
        style: ButtonStyle(
          foregroundColor: WidgetStatePropertyAll(foregroundColor),
          padding: WidgetStatePropertyAll(EdgeInsets.all(12.0)),
          iconSize: WidgetStatePropertyAll(28.0),
        ),
      ),
      dialogTheme: DialogTheme(
        backgroundColor: primaryColor,
        elevation: 0,
        shape: roundedRectangleBorder(radius: borderRadiusLarge),
        titleTextStyle: textTheme.headlineMedium,
        contentTextStyle: textTheme.bodyMedium,
        actionsPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        barrierColor: backgroundColor,
      ),
      iconTheme: IconThemeData(
        color: foregroundColor,
        size: 24.0,
      ),
      tooltipTheme: TooltipThemeData(
        decoration: BoxDecoration(
          color: foregroundColor,
          borderRadius: BorderRadius.circular(borderRadiusSmall),
        ),
        textStyle: textTheme.bodySmall?.copyWith(
          fontWeight: FontWeight.bold,
          color: backgroundColor,
        ),
      ),
    );
  }
}
