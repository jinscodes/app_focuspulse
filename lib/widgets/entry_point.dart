import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:focuspulse/colors.dart';
import 'package:focuspulse/models/adManager.dart';
import 'package:focuspulse/widgets/history.dart';
import 'package:focuspulse/widgets/home.dart';
import 'package:focuspulse/widgets/normal_timer.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class EntryPoint extends ConsumerStatefulWidget {
  const EntryPoint({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EntryPointState();
}

class _EntryPointState extends ConsumerState<EntryPoint> {
  bool _showAd = true;
  int _selectedIndex = 0;
  final List<Widget> _screens = [
    const HomeScreen(),
    const NormalTimer(),
    const HistoryScreen(),
  ];

  @override
  void initState() {
    super.initState();
    AdManager.instance.loadBannerAd();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgWhite,
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 150),
        switchInCurve: Curves.easeIn,
        switchOutCurve: Curves.easeOut,
        child: _screens[_selectedIndex],
        transitionBuilder: (Widget child, Animation<double> animation) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Divider(
              height: 1,
              thickness: 1,
              color: Colors.grey[300],
            ),
            BottomNavigationBar(
              backgroundColor: AppColors.bgWhite,
              selectedItemColor: Colors.black,
              currentIndex: _selectedIndex,
              onTap: _onItemTapped,
              items: [
                BottomNavigationBarItem(
                  icon: Padding(
                    padding: EdgeInsets.only(top: 8.h),
                    child: const Icon(Icons.home),
                  ),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Padding(
                    padding: EdgeInsets.only(top: 8.h),
                    child: const Icon(Icons.timer),
                  ),
                  label: 'Timer',
                ),
                BottomNavigationBarItem(
                  icon: Padding(
                    padding: EdgeInsets.only(top: 8.h),
                    child: const Icon(Icons.history),
                  ),
                  label: 'History',
                ),
              ],
            ),
            if (_showAd)
              Stack(
                children: [
                  Container(
                    color: Colors.white,
                    height: AdManager.instance.bannerAd!.size.height.toDouble(),
                    child: AdWidget(ad: AdManager.instance.bannerAd!),
                  ),
                  Positioned(
                    right: 0,
                    top: 0,
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          _showAd = false;
                        });
                      },
                      icon: Icon(
                        Icons.close_rounded,
                        size: 24.w,
                        color: Colors.grey,
                      ),
                    ),
                  )
                ],
              )
          ],
        ),
      ),
    );
  }
}
