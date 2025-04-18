import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:focuspulse/colors.dart';
import 'package:focuspulse/widgets/saved.dart';
import 'package:focuspulse/widgets/settings.dart';
import 'package:focuspulse/widgets/stats.dart';

class MenuDrawer extends ConsumerWidget {
  const MenuDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void navigateToSaved() {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const SavedScreen(),
        ),
      );
    }

    void navigateToStats() {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const StatsScreen(),
        ),
      );
    }

    void navigateToSettings() {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const SettingsScreen(),
        ),
      );
    }

    return Drawer(
      backgroundColor: AppColors.bgBeige,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          SizedBox(height: 100.h),
          ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 40.w),
            title: const Text(
              'SETTINGS',
              style: TextStyle(
                fontFamily: 'howdy_duck',
                fontSize: 20,
                color: AppColors.fontbrown,
              ),
            ),
            onTap: () => navigateToSettings(),
          ),
          SizedBox(height: 10.h),
          ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 40.w),
            title: const Text(
              'SAVED',
              style: TextStyle(
                fontFamily: 'howdy_duck',
                fontSize: 20,
                color: AppColors.fontbrown,
              ),
            ),
            onTap: () => navigateToSaved(),
          ),
          SizedBox(height: 10.h),
          ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 40.w),
            title: const Text(
              'STATS',
              style: TextStyle(
                fontFamily: 'howdy_duck',
                fontSize: 20,
                color: AppColors.fontbrown,
              ),
            ),
            onTap: () => navigateToStats(),
          ),
        ],
      ),
    );
  }
}
