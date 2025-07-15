import 'dart:io';

import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdManager {
  static final AdManager instance = AdManager();
  BannerAd? _bannerAd;
  InterstitialAd? _interstitialAd;

  void loadInterstitialAd({
    required Function(InterstitialAd ad) onLoaded,
    required Function(LoadAdError error) onFailed,
  }) {
    InterstitialAd.load(
      adUnitId: Platform.isAndroid
          ? 'ca-app-pub-4654745491099162/4918863100'
          : 'ca-app-pub-4654745491099162/5519544626',
      // adUnitId: Platform.isAndroid // test ad unit ID
      //     ? 'ca-app-pub-3940256099942544/1033173712'
      //     : 'ca-app-pub-3940256099942544/4411468910',
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _interstitialAd = ad;
          onLoaded(ad);
        },
        onAdFailedToLoad: (error) {
          _interstitialAd = null;
          onFailed(error);
        },
      ),
    );
  }

  void showInterstitialAd({
    required Function() onAdDismissed,
    required Function(AdError error) onAdFailedToShow,
  }) {
    if (_interstitialAd != null) {
      _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdDismissedFullScreenContent: (ad) {
          ad.dispose();
          _interstitialAd = null;
          onAdDismissed();
        },
        onAdFailedToShowFullScreenContent: (ad, error) {
          ad.dispose();
          _interstitialAd = null;
          onAdFailedToShow(error);
        },
      );
      _interstitialAd!.show();
    }
  }

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

  void dispose() {
    _bannerAd?.dispose();
    _interstitialAd?.dispose();
  }

  BannerAd? get bannerAd => _bannerAd;
}
