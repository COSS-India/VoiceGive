import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';

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
  static const List<Locale> supportedLocales = <Locale>[Locale('en')];

  /// No description provided for @bhashadaan.
  ///
  /// In en, this message translates to:
  /// **'Bhashadaan'**
  String get bhashadaan;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @bolo.
  ///
  /// In en, this message translates to:
  /// **'Bolo'**
  String get bolo;

  /// No description provided for @suno.
  ///
  /// In en, this message translates to:
  /// **'Suno'**
  String get suno;

  /// No description provided for @likho.
  ///
  /// In en, this message translates to:
  /// **'Likho'**
  String get likho;

  /// No description provided for @dekho.
  ///
  /// In en, this message translates to:
  /// **'Dekho'**
  String get dekho;

  /// No description provided for @boloIndia.
  ///
  /// In en, this message translates to:
  /// **'Bolo India'**
  String get boloIndia;

  /// No description provided for @sunoIndia.
  ///
  /// In en, this message translates to:
  /// **'Suno India'**
  String get sunoIndia;

  /// No description provided for @likhoIndia.
  ///
  /// In en, this message translates to:
  /// **'Likho India'**
  String get likhoIndia;

  /// No description provided for @dekhoIndia.
  ///
  /// In en, this message translates to:
  /// **'Dekho India'**
  String get dekhoIndia;

  /// No description provided for @mStaticLabel.
  ///
  /// In en, this message translates to:
  /// **'Label'**
  String get mStaticLabel;

  /// No description provided for @mStaticValidate.
  ///
  /// In en, this message translates to:
  /// **'Validate'**
  String get mStaticValidate;

  /// No description provided for @mStaticSelectLanguage.
  ///
  /// In en, this message translates to:
  /// **'Select the language for contribution:'**
  String get mStaticSelectLanguage;

  /// No description provided for @mStaticSearch.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get mStaticSearch;

  /// No description provided for @mStaticSubmit.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get mStaticSubmit;

  /// No description provided for @mStaticCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get mStaticCancel;

  /// No description provided for @mStaticSkip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get mStaticSkip;

  /// No description provided for @mStaticNoSearchResultFound.
  ///
  /// In en, this message translates to:
  /// **'No results found'**
  String get mStaticNoSearchResultFound;

  /// No description provided for @mStaticStartTyping.
  ///
  /// In en, this message translates to:
  /// **'Start typing here...'**
  String get mStaticStartTyping;

  /// No description provided for @mStaticInputSubmitted.
  ///
  /// In en, this message translates to:
  /// **'Thanks for your contribution! we have received your input.'**
  String get mStaticInputSubmitted;

  /// No description provided for @mStaticValidationSuccessMessage.
  ///
  /// In en, this message translates to:
  /// **'Thank you for validating the input.'**
  String get mStaticValidationSuccessMessage;
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
      <String>['en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
