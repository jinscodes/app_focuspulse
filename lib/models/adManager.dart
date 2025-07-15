import 'dart:io';

import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdManager {
  static final AdManager instance = AdManager();
  BannerAd? _bannerAd;
  RewardedAd? _rewardedAd;

  void loadBannerAd() {
    _bannerAd = BannerAd(
      adUnitId: Platform.isAndroid
          ? 'ca-app-pub-4654745491099162/8597134103'
          : 'ca-app-pub-4654745491099162/8390370105',
      size: AdSize.banner,
      request: const AdRequest(),
      listener: const BannerAdListener(),
    );

    _bannerAd!.load();
  }

  BannerAd? get bannerAd => _bannerAd;
}
