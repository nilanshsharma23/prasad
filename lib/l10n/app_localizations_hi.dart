// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hindi (`hi`).
class AppLocalizationsHi extends AppLocalizations {
  AppLocalizationsHi([String locale = 'hi']) : super(locale);

  @override
  String get grantPermission => 'अनुमति प्रदान करें';

  @override
  String get nearbyBhandaras => 'आस-पास भंडारे';

  @override
  String get nearby => 'आस-पास';

  @override
  String get nearest => 'सबसे पास';

  @override
  String get noBhandaras => 'इस दूरी पर अभी कोई भंडारा उपलब्ध नहीं है';

  @override
  String get success => 'हो गया!';

  @override
  String get bhandaraCreated => 'आपका भंडारा बन चुका है।';

  @override
  String get reload => 'फिरसे लोड करें';

  @override
  String get distance => 'दूरी';

  @override
  String get kilometers => 'कि.मी.';

  @override
  String get hostABhandara => 'भंडारा आयोजित करें';

  @override
  String get selectLocation => 'स्थान चुनें';

  @override
  String get selectDate => 'तारीख़ चुनें';

  @override
  String get from => 'शुरुआत';

  @override
  String get to => 'अंत';

  @override
  String get noOfPeople => 'लोगों की संख्या';

  @override
  String get pleaseEnterSomething => 'कुछ डालें';

  @override
  String get uploadProof => 'सबूत अपलोड करें';

  @override
  String get uploadProofDescription =>
      'कोई ऐसी तस्वीर जो यह दिखाएं कि भंडारा सच में है जैसे की कोई रिसीप्ट';

  @override
  String get dateNotSelected => 'तारीख नहीं चुनी';

  @override
  String get timeNotSelected => 'समय नहीं चुना';

  @override
  String get locationNotSelected => 'स्थान नहीं चुना';

  @override
  String get proofNotUploaded => 'सबूत अपलोड नहीं किया';

  @override
  String get host => 'आयोजित करें';

  @override
  String get ok => 'ठीक है';
}
