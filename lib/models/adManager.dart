import 'dart:io';

import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdManager {
  static final AdManager instance = AdManager();
  BannerAd? _bannerAd;
  InterstitialAd? _interstitialAd;

  static const int _adCooldownDuration = 5 * 60 * 1000;
  static const String _lastAdShownKey = 'last_ad_shown_timestamp';

  Future<bool> shouldShowAd() async {
    final prefs = await SharedPreferences.getInstance();
    final lastAdShown = prefs.getInt(_lastAdShownKey) ?? 0;
    final currentTime = DateTime.now().millisecondsSinceEpoch;
    return (currentTime - lastAdShown) >= _adCooldownDuration;
  }

  Future<void> _updateLastAdShownTime() async {
    final prefs = await SharedPreferences.getInstance();
    final currentTime = DateTime.now().millisecondsSinceEpoch;
    await prefs.setInt(_lastAdShownKey, currentTime);
  }

  void loadInterstitialAdWithCooldown({
    required Function() onAdShown,
    required Function() onAdSkipped,
    required Function(String error) onError,
  }) async {
    final shouldShow = await shouldShowAd();

    if (!shouldShow) {
      onAdSkipped();
      return;
    }

    loadInterstitialAd(
      onLoaded: (ad) {
        showInterstitialAd(
          onAdDismissed: () async {
            await _updateLastAdShownTime();
            onAdShown();
          },
          onAdFailedToShow: (error) {
            onError('Failed to show ad: $error');
          },
        );
      },
      onFailed: (error) {
        onError('Failed to load ad: $error');
      },
    );
  }

  void loadInterstitialAd({
    required Function(InterstitialAd ad) onLoaded,
    required Function(LoadAdError error) onFailed,
  }) {
    InterstitialAd.load(
      adUnitId: Platform.isAndroid
          ? 'ca-app-pub-4654745491099162/4918863100'
          : 'ca-app-pub-4654745491099162/5519544626',
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
