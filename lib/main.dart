import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:focuspulse/colors.dart';
import 'package:focuspulse/widgets/intro.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => MaterialApp(
        title: 'Focus Pulse',
        themeMode: ThemeMode.system,
        theme: ThemeData(
          useMaterial3: true,
          colorSchemeSeed: AppColors.bgWhite,
          brightness: Brightness.light,
        ),
        debugShowCheckedModeBanner: false,
        home: const Intro(),
      ),
    );
  }
}
