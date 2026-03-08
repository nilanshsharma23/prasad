import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_hi.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('hi'),
  ];

  /// No description provided for @grantPermission.
  ///
  /// In en, this message translates to:
  /// **'Grant Permission'**
  String get grantPermission;

  /// No description provided for @nearbyBhandaras.
  ///
  /// In en, this message translates to:
  /// **'Nearby Bhandaras'**
  String get nearbyBhandaras;

  /// No description provided for @nearby.
  ///
  /// In en, this message translates to:
  /// **'Nearby'**
  String get nearby;

  /// No description provided for @nearest.
  ///
  /// In en, this message translates to:
  /// **'Nearest'**
  String get nearest;

  /// No description provided for @noBhandaras.
  ///
  /// In en, this message translates to:
  /// **'No Bhandaras are available at this distance right now'**
  String get noBhandaras;

  /// No description provided for @success.
  ///
  /// In en, this message translates to:
  /// **'Success!'**
  String get success;

  /// No description provided for @bhandaraCreated.
  ///
  /// In en, this message translates to:
  /// **'Your bhandara has been created.'**
  String get bhandaraCreated;

  /// No description provided for @reload.
  ///
  /// In en, this message translates to:
  /// **'Reload'**
  String get reload;

  /// No description provided for @distance.
  ///
  /// In en, this message translates to:
  /// **'Distance'**
  String get distance;

  /// No description provided for @kilometers.
  ///
  /// In en, this message translates to:
  /// **'km'**
  String get kilometers;

  /// No description provided for @hostABhandara.
  ///
  /// In en, this message translates to:
  /// **'Host A Bhandara'**
  String get hostABhandara;

  /// No description provided for @selectLocation.
  ///
  /// In en, this message translates to:
  /// **'Select Location'**
  String get selectLocation;

  /// No description provided for @selectDate.
  ///
  /// In en, this message translates to:
  /// **'Select Date'**
  String get selectDate;

  /// No description provided for @from.
  ///
  /// In en, this message translates to:
  /// **'From'**
  String get from;

  /// No description provided for @to.
  ///
  /// In en, this message translates to:
  /// **'To'**
  String get to;

  /// No description provided for @noOfPeople.
  ///
  /// In en, this message translates to:
  /// **'No Of People'**
  String get noOfPeople;

  /// No description provided for @pleaseEnterSomething.
  ///
  /// In en, this message translates to:
  /// **'Please Enter Something'**
  String get pleaseEnterSomething;

  /// No description provided for @uploadProof.
  ///
  /// In en, this message translates to:
  /// **'Upload Proof'**
  String get uploadProof;

  /// No description provided for @uploadProofDescription.
  ///
  /// In en, this message translates to:
  /// **'Any sort of document confirming the bhandara like an advance payment receipt from the caterer or tent.'**
  String get uploadProofDescription;

  /// No description provided for @dateNotSelected.
  ///
  /// In en, this message translates to:
  /// **'Date Not Selected.'**
  String get dateNotSelected;

  /// No description provided for @timeNotSelected.
  ///
  /// In en, this message translates to:
  /// **'Time Not Selected.'**
  String get timeNotSelected;

  /// No description provided for @locationNotSelected.
  ///
  /// In en, this message translates to:
  /// **'Location Not Selected'**
  String get locationNotSelected;

  /// No description provided for @proofNotUploaded.
  ///
  /// In en, this message translates to:
  /// **'Proof Not Uploaded'**
  String get proofNotUploaded;

  /// No description provided for @host.
  ///
  /// In en, this message translates to:
  /// **'Host'**
  String get host;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// No description provided for @myBhandaras.
  ///
  /// In en, this message translates to:
  /// **'My Bhandaras'**
  String get myBhandaras;

  /// No description provided for @bhandarasHosted.
  ///
  /// In en, this message translates to:
  /// **'Bhandaras Hosted: '**
  String get bhandarasHosted;

  /// No description provided for @thanksForHosting.
  ///
  /// In en, this message translates to:
  /// **'Thanks for hosting with us!'**
  String get thanksForHosting;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @theme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get theme;

  /// No description provided for @signIn.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get signIn;

  /// No description provided for @enterMobileNumber.
  ///
  /// In en, this message translates to:
  /// **'Enter Your Mobile Number'**
  String get enterMobileNumber;

  /// No description provided for @tenDigitMobileNumber.
  ///
  /// In en, this message translates to:
  /// **'Mobile number should be 10 digits'**
  String get tenDigitMobileNumber;

  /// No description provided for @sendOTP.
  ///
  /// In en, this message translates to:
  /// **'Send OTP'**
  String get sendOTP;

  /// No description provided for @enterOTP.
  ///
  /// In en, this message translates to:
  /// **'Enter OTP'**
  String get enterOTP;

  /// No description provided for @otpSent.
  ///
  /// In en, this message translates to:
  /// **'An OTP has been sent to your mobile number.'**
  String get otpSent;

  /// No description provided for @sixDigitOTP.
  ///
  /// In en, this message translates to:
  /// **'OTP should be 6 digits'**
  String get sixDigitOTP;

  /// No description provided for @continueOn.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueOn;

  /// No description provided for @enterYourName.
  ///
  /// In en, this message translates to:
  /// **'Enter Your Name'**
  String get enterYourName;

  /// No description provided for @takeMeThere.
  ///
  /// In en, this message translates to:
  /// **'Take Me There'**
  String get takeMeThere;

  /// No description provided for @status.
  ///
  /// In en, this message translates to:
  /// **'Status: '**
  String get status;

  /// No description provided for @needToSignIn.
  ///
  /// In en, this message translates to:
  /// **'You need to sign in to access this feature.'**
  String get needToSignIn;

  /// No description provided for @provideLocationPermission.
  ///
  /// In en, this message translates to:
  /// **'You need to grant location permission in order to access some features.'**
  String get provideLocationPermission;

  /// No description provided for @clicks.
  ///
  /// In en, this message translates to:
  /// **'Clicks: '**
  String get clicks;

  /// No description provided for @times.
  ///
  /// In en, this message translates to:
  /// **' times'**
  String get times;

  /// No description provided for @signOut.
  ///
  /// In en, this message translates to:
  /// **'Sign Out'**
  String get signOut;

  /// No description provided for @deleteAccount.
  ///
  /// In en, this message translates to:
  /// **'Delete Account'**
  String get deleteAccount;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @selectLanguage.
  ///
  /// In en, this message translates to:
  /// **'Select Language'**
  String get selectLanguage;

  /// No description provided for @findBhandaras.
  ///
  /// In en, this message translates to:
  /// **'Find Bhandaras'**
  String get findBhandaras;

  /// No description provided for @findBhandarasDescription.
  ///
  /// In en, this message translates to:
  /// **'You can find bhandaras near your location.'**
  String get findBhandarasDescription;

  /// No description provided for @hostABhandaraDescription.
  ///
  /// In en, this message translates to:
  /// **'You can host your own bhandaras so that more people can come.'**
  String get hostABhandaraDescription;

  /// No description provided for @allForFree.
  ///
  /// In en, this message translates to:
  /// **'All For Free!'**
  String get allForFree;

  /// No description provided for @allForFreeDescription.
  ///
  /// In en, this message translates to:
  /// **'Find bhandaras, Host bhandaras, and more!'**
  String get allForFreeDescription;

  /// No description provided for @aboutUs.
  ///
  /// In en, this message translates to:
  /// **'About Us'**
  String get aboutUs;

  /// No description provided for @prasad.
  ///
  /// In en, this message translates to:
  /// **'Prasad'**
  String get prasad;

  /// No description provided for @prasadDescription.
  ///
  /// In en, this message translates to:
  /// **'Prasad is the easiest way to find bhandaras happening near you. Whether it\'s a langar, community feast, or prasad distribution, we help you discover free meals while connecting you with the spirit of giving in your city.'**
  String get prasadDescription;

  /// No description provided for @findFreeFood.
  ///
  /// In en, this message translates to:
  /// **'Find Free Food'**
  String get findFreeFood;

  /// No description provided for @findFreeFoodDescription.
  ///
  /// In en, this message translates to:
  /// **'Stop missing out on bhandaras in your area. Get notified about free meals, timings, and locations—all in one app. From daily langars to special occasion feasts, find prasad near you with just a few taps.'**
  String get findFreeFoodDescription;

  /// No description provided for @hostABhandaraAboutDescription.
  ///
  /// In en, this message translates to:
  /// **'Organizing a bhandara? Let people know. Reach more devotees, share your act of seva with the community, and make sure your generosity finds the people who\'ll appreciate it most.'**
  String get hostABhandaraAboutDescription;

  /// No description provided for @whyPrasad.
  ///
  /// In en, this message translates to:
  /// **'Why Prasad?'**
  String get whyPrasad;

  /// No description provided for @whyPrasadDescription.
  ///
  /// In en, this message translates to:
  /// **'Prasad brings an age-old tradition into the modern age. Because doing good and eating well shouldn\'t be complicated.'**
  String get whyPrasadDescription;

  /// No description provided for @vendorsNearMe.
  ///
  /// In en, this message translates to:
  /// **'Vendors Near Me'**
  String get vendorsNearMe;

  /// No description provided for @services.
  ///
  /// In en, this message translates to:
  /// **'Services'**
  String get services;

  /// No description provided for @images.
  ///
  /// In en, this message translates to:
  /// **'Images'**
  String get images;

  /// No description provided for @ratings.
  ///
  /// In en, this message translates to:
  /// **'Ratings'**
  String get ratings;

  /// No description provided for @noRatings.
  ///
  /// In en, this message translates to:
  /// **'No Ratings'**
  String get noRatings;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'hi'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'hi':
      return AppLocalizationsHi();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
