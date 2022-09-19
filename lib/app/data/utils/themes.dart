import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData lightTheme = ThemeData(
  primaryColor: const Color(0xff245ee7),
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    brightness: Brightness.light,
    primary: const Color(0xff245ee7),
    onPrimary: Colors.white,
    secondary: const Color(0xff303030),
    onSecondary: Colors.white,
    tertiary: const Color(0xff707070),
    error: Colors.red.shade800,
    onError: Colors.white,
    background: Colors.white,
    onBackground: const Color(0xffacb4d2),
    surface: const Color(0xfffafbfc),
    surfaceVariant: const Color(0xfff8f9fb),
    onSurface: const Color(0xffa3acbf),
  ),
  extensions: [
    const MembershipColors(
      premium: Color(0xffFFD700),
      standard: Color(0xffC0C0C0),
      basic: Color(0xffCD7F32),
    ),
    StatsColors(
      increaseColor: Colors.green.shade600,
      decreaseColor: Colors.red.shade600,
    ),
  ],
  textButtonTheme: const TextButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStatePropertyAll(
        Color.fromARGB(255, 231, 234, 237),
      ),
      foregroundColor: MaterialStatePropertyAll(Color(0xff303030)),
      padding: MaterialStatePropertyAll(
        EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      ),
    ),
  ),
  textTheme: GoogleFonts.poppinsTextTheme(),
  pageTransitionsTheme: const PageTransitionsTheme(
    builders: {
      TargetPlatform.macOS: ZoomPageTransitionsBuilder(),
      TargetPlatform.windows: ZoomPageTransitionsBuilder(),
      TargetPlatform.linux: ZoomPageTransitionsBuilder(),
    },
  ),
  backgroundColor: Colors.white,
  dividerColor: const Color(0xfff0f2f5),
  hoverColor: CupertinoColors.secondarySystemBackground,
  dividerTheme: const DividerThemeData(
    color: Color(0xfff0f2f5),
    thickness: 1,
    endIndent: 0,
    indent: 0,
    space: 1,
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: ButtonStyle(
      side: MaterialStateProperty.resolveWith(
        (states) {
          return BorderSide(
            color: states.contains(MaterialState.hovered)
                ? const Color(0xff245ee7)
                : const Color.fromARGB(255, 221, 224, 233),
            width: 1,
          );
        },
      ),
    ),
  ),
  primaryIconTheme: const IconThemeData(
    color: Color.fromARGB(255, 142, 149, 173),
  ),
  iconTheme: const IconThemeData(
    color: Color(0xffebeef2),
  ),
  scaffoldBackgroundColor: Colors.white,
  shadowColor: Colors.black12,
  checkboxTheme: CheckboxThemeData(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(4),
    ),
    side: const BorderSide(
      width: 1,
      color: Color(0xff707070),
    ),
    splashRadius: 0,
    fillColor: const MaterialStatePropertyAll(Color(0xff707070)),
  ),
);

ThemeData darkTheme = ThemeData(
  primaryColor: Colors.blue,
  brightness: Brightness.dark,
  backgroundColor: Colors.grey.shade900,
  colorScheme: const ColorScheme.dark().copyWith(
    primary: Colors.blue,
    onPrimary: Colors.white,
    secondary: Colors.white.withOpacity(0.8),
    tertiary: Colors.white.withOpacity(0.65),
    onSecondary: Colors.grey.shade900,
    surface: Colors.grey.withOpacity(0.1),
    onSurface: Colors.white60,
  ),
  extensions: [
    const MembershipColors(
      premium: Color(0xffFFD700),
      standard: Color(0xffC0C0C0),
      basic: Color(0xffCD7F32),
    ),
    StatsColors(
      increaseColor: Colors.green,
      decreaseColor: Colors.red,
    ),
  ],
  dividerColor: Colors.grey.shade700,
  dividerTheme: DividerThemeData(
    color: Colors.grey.shade700,
    endIndent: 0,
    indent: 0,
    space: 1,
    thickness: 1,
  ),
  primaryIconTheme: IconThemeData(
    color: Colors.white.withOpacity(0.8),
  ),
  iconTheme: IconThemeData(
    color: Colors.grey.withOpacity(0.2),
  ),
  textTheme: GoogleFonts.poppinsTextTheme(),
  scaffoldBackgroundColor: Colors.black,
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: ButtonStyle(
      side: MaterialStateProperty.resolveWith(
        (states) {
          return BorderSide(
            color: states.contains(MaterialState.hovered)
                ? Colors.blue
                : Colors.grey.shade700,
            width: 1,
          );
        },
      ),
    ),
  ),
  textButtonTheme: const TextButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStatePropertyAll(
        Color.fromARGB(255, 197, 202, 208),
      ),
      foregroundColor: MaterialStatePropertyAll(Color(0xff303030)),
      padding: MaterialStatePropertyAll(EdgeInsets.symmetric(horizontal: 10)),
    ),
  ),
  checkboxTheme: CheckboxThemeData(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(4),
    ),
    fillColor: MaterialStatePropertyAll(Colors.white.withOpacity(0.65)),
    side: BorderSide(
      width: 1,
      color: Colors.white.withOpacity(0.65),
    ),
    splashRadius: 0,
  ),
);

class MembershipColors extends ThemeExtension<MembershipColors> {
  final Color basic;
  final Color standard;
  final Color premium;

  const MembershipColors({
    required this.basic,
    required this.standard,
    required this.premium,
  });

  @override
  ThemeExtension<MembershipColors> copyWith(
      {Color? basic, Color? standard, Color? premium}) {
    return MembershipColors(
        basic: basic ?? this.basic,
        standard: standard ?? this.standard,
        premium: this.premium);
  }

  @override
  ThemeExtension<MembershipColors> lerp(
      ThemeExtension<MembershipColors>? other, double t) {
    return this;
  }
}

class StatsColors extends ThemeExtension<StatsColors> {
  final Color increaseColor;
  final Color decreaseColor;

  StatsColors({
    required this.increaseColor,
    required this.decreaseColor,
  });

  @override
  ThemeExtension<StatsColors> copyWith(
      {Color? increaseColor, Color? decreaseColor}) {
    return StatsColors(
        increaseColor: increaseColor ?? this.increaseColor,
        decreaseColor: decreaseColor ?? this.decreaseColor);
  }

  @override
  ThemeExtension<StatsColors> lerp(
      ThemeExtension<StatsColors>? other, double t) {
    return this;
  }
}
