import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class BannerAdTemplate extends StatefulWidget {
  const BannerAdTemplate({super.key, required this.adUnitId});

  final String adUnitId;

  @override
  State<BannerAdTemplate> createState() => _BannerAdTemplateState();
}

class _BannerAdTemplateState extends State<BannerAdTemplate> {
  BannerAd? bannerAd;
  bool? adFailedToLoad;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    loadAd();
  }

  void loadAd() async {
    final size = await AdSize.getCurrentOrientationAnchoredAdaptiveBannerAdSize(
      MediaQuery.sizeOf(context).width.truncate(),
    );

    if (size == null) {
      return;
    }

    bannerAd = BannerAd(
      size: size,
      adUnitId: widget.adUnitId,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          debugPrint("Banner Ad Loaded");
          setState(() {
            bannerAd = ad as BannerAd;
          });
        },
        onAdFailedToLoad: (ad, error) {
          debugPrint("Ad failed to load with error: $error");

          setState(() {
            adFailedToLoad = true;
          });

          ad.dispose();
        },
      ),
      request: const AdRequest(),
    );

    if (bannerAd != null) {
      await bannerAd!.load();

      setState(() {
        adFailedToLoad = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (bannerAd != null && adFailedToLoad != null && adFailedToLoad == false) {
      return Column(
        children: [
          SizedBox(height: 32),
          SizedBox(
            width: bannerAd!.size.width.toDouble(),
            height: bannerAd!.size.height.toDouble(),
            child: AdWidget(ad: bannerAd!),
          ),
        ],
      );
    }

    return SizedBox.shrink();
  }
}
