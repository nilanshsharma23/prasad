// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get grantPermission => 'Grand Permission';

  @override
  String get nearbyBhandaras => 'Nearby Bhandaras';

  @override
  String get nearby => 'Nearby';

  @override
  String get nearest => 'Nearest';

  @override
  String get noBhandaras =>
      'No Bhandaras are available at this distance right now';

  @override
  String get success => 'Success!';

  @override
  String get bhandaraCreated => 'Your bhandara has been created.';

  @override
  String get reload => 'Reload';

  @override
  String get distance => 'Distance';

  @override
  String get kilometers => 'km';

  @override
  String get hostABhandara => 'Host A Bhandara';

  @override
  String get selectLocation => 'Select Location';

  @override
  String get selectDate => 'Select Date';

  @override
  String get from => 'From';

  @override
  String get to => 'To';

  @override
  String get noOfPeople => 'No Of People';

  @override
  String get pleaseEnterSomething => 'Please Enter Something';

  @override
  String get uploadProof => 'Upload Proof';

  @override
  String get uploadProofDescription =>
      'Any sort of document confirming the bhandara like an advance payment receipt from the caterer or tent.';

  @override
  String get dateNotSelected => 'Date Not Selected.';

  @override
  String get timeNotSelected => 'Time Not Selected.';

  @override
  String get locationNotSelected => 'Location Not Selected';

  @override
  String get proofNotUploaded => 'Proof Not Uploaded';

  @override
  String get host => 'Host';

  @override
  String get ok => 'OK';
}
