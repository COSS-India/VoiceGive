// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AppLocalizationsGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ml.dart';

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate` in their app's
/// localizationDelegates list, and the locales they support in the app's
/// supportedLocales list. For example:
///
/// ```dart
/// import 'package:flutter_localizations/flutter_localizations.dart';
/// import 'package:bhashadaan/l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update locale
///
/// The app's current locale can be changed by calling `setLocale` with a
/// [Locale] that is supported by the app.
///
/// ```dart
/// AppLocalizations.setLocale(context, Locale('en'));
/// ```
///
/// ## Retrieve localized strings
///
/// The localized strings are available through the [AppLocalizations] class.
/// For example, to get the localized string for 'helloWorld', you would use:
///
/// ```dart
/// AppLocalizations.of(context).helloWorld
/// ```
///
/// If the string is not found, an error will be thrown.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  /// The locale of this localizations class.
  final String localeName;

  /// A list of this localizations class along with the information that
  /// Flutter Codegen can read. It returns a list of [LocalizationsDelegate]
  /// and [Locale]s.
  ///
  /// Returns: a list of objects containing the current localizations class
  /// and information that Flutter Codegen can read.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    _AppLocalizationsDelegate(),
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ];

  /// A list of this localizations class supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ml')
  ];

  /// Lookup a localized string by its key.
  /// Returns the localized string for the given key.
  ///
  /// Throws an exception if the key is not found.
  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  /// Lookup a localized string by its key.
  /// Returns the localized string for the given key.
  ///
  /// Throws an exception if the key is not found.
  static AppLocalizations? maybeOf(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  /// The current locale of the app.
  static Locale? currentLocale(BuildContext context) {
    return Localizations.localeOf(context);
  }

  /// Set the current locale of the app.
  static void setLocale(BuildContext context, Locale locale) {
    // This is a placeholder implementation.
    // In a real app, you would use a state management solution
    // to update the locale and rebuild the widget tree.
  }

  /// Lookup a localized string by its key.
  /// Returns the localized string for the given key.
  ///
  /// Throws an exception if the key is not found.
  String lookup(String key) {
    throw FlutterError(
        'AppLocalizations.of(context) called with a context that does not contain a Localizations widget.\n'
        'No widget found that provides AppLocalizations.\n'
        'The context used was:\n'
        '  $this');
  }

  /// Lookup a localized string by its key.
  /// Returns the localized string for the given key.
  ///
  /// Throws an exception if the key is not found.
  String lookupByKey(String key) {
    throw FlutterError(
        'AppLocalizations.of(context) called with a context that does not contain a Localizations widget.\n'
        'No widget found that provides AppLocalizations.\n'
        'The context used was:\n'
        '  $this');
  }

  // All the localization keys are defined in the concrete classes
  // This abstract class provides the interface for accessing localized strings

  // Getters for all localization keys
  String get bhashadaan;
  String get home;
  String get bolo;
  String get suno;
  String get likho;
  String get dekho;
  String get boloIndia;
  String get sunoIndia;
  String get likhoIndia;
  String get dekhoIndia;
  String get mStaticLabel;
  String get mStaticValidate;
  String get mStaticSelectLanguage;
  String get mStaticSearch;
  String get mStaticSubmit;
  String get mStaticCancel;
  String get mStaticSkip;
  String get mStaticNoSearchResultFound;
  String get mStaticStartTyping;
  String get mStaticInputSubmitted;
  String get mStaticValidationSuccessMessage;
  String get login;
  String get verifyPhoneNumber;
  String get otpSentMessage;
  String get enterMobileNumber;
  String get getOtp;
  String get invalidPhoneNumber;
  String get otpVerification;
  String get otpSentToNumber;
  String get resendOtp;
  String get submitOtp;
  String get otpExpired;
  String get invalidOtp;
  String get signUp;
  String get forgotPassword;
  String get loginFailed;
  String get networkError;
  String get failedToLoadCaptcha;
  String get pleaseWaitForCaptcha;
  String get refreshCaptcha;
  String get passwordRequired;
  String get passwordMinLength;
  String get passwordComplexity;
  String get emailRequired;
  String get invalidEmail;
  String get acceptTermsAndConditions;
  String get termsAndConditionsComingSoon;
  String get privacyPolicyComingSoon;
  String get otpSentSuccessfully;
  String otpSentToEmail(String email);
  String get quickTips;
  String get report;
  String get testSpeakers;
  String get contributeMore;
  String get validate;
  String get incorrect;
  String get correct;
  String get skippingCurrentSentence;
  String get skippedSuccessfully;
  String get skipFailed;
  String get noValidationItemsAvailable;
  String get failedToFetchValidationItems;
  String get pleaseSelectAgeGroupAndGender;
  String get enterMobileNumberHint;
  String get error;
  String get submit;
  String get cancel;
  String get skip;
  String get label;
  String get search;
  String get selectLanguage;
  String get noResultsFound;
  String get startTyping;
  String get inputSubmitted;
  String get validationSuccessMessage;
  String get completeYourProfile;
  String get personalInformation;
  String get firstName;
  String get lastName;
  String get chooseYourAgeGroup;
  String get emailId;
  String get saveAndContinue;
  String get firstNameRequired;
  String get lastNameRequired;
  String get under18Years;
  String get age18To24;
  String get age25To34;
  String get age35To44;
  String get age45To54;
  String get age55To64;
  String get age65Plus;
  String get male;
  String get female;
  String get nonBinary;
  String get preferNotToSay;
  String get enrichYourLanguage;
  String get selectLanguageForValidation;
  String get pauseRecording;
  String get replayRecording;
  String get markedIncorrect;
  String get markedCorrect;
  String get rejectFailed;
  String get acceptFailed;
  String get validationResult;
  String youMarkedRecordingAs(String result);
  String get continueButton;
  String get pleaseEnterCaptcha;
  String get captchaNotLoaded;
  String get signIn;
  String get createBhashaDaanAccount;
  String get verifyOtp;
  String get otpSentToMail;
  String get namasteContributor;
  String get consentMessage;
  String get iAgree;
  String get india;
  String get maharashtra;
  String get pune;
  String get mumbai;
  String get nashik;
  String get nagpur;
  String get thane;
  String get aurangabad;
  String get english;
  String get hindi;
  String get marathi;
  String get gujarati;
  String get kannada;
  String get telugu;
  String get karnataka;
  String get whatIsAgriDaan;
  String get agriDaanDescription;
  String get empowerIndiasLinguisticDiversity;
  String get joinTheMovementDescription;
  String get letsGetStarted;
  String get digitalIndiaBhashiniDivision;
  String get electronicsNiketanAddress;
  String get poweredBy;
  String get digitalIndiaCorporation;
  String get ministryOfElectronicsIt;
  String get governmentOfIndia;
  String get copyrightNotice;
  String get needMoreInfo;
  String get writeYourConcern;
  String get contactUs;
  String get enterOtpFromSms;
  String get contribute;
  String get speakClearlyAndRecord;
  String get listenAndValidate;
  String get earnCertificate;
  String get earnCertificateDescription;
  String get checkYourSetup;
  String get pleaseTestYourSpeaker;
  String get pleaseTestYourMicrophone;
  String get noBackgroundNoise;
  String get speakNaturally;
  String get recordExactlyAsShown;
  String get dontRecordPunctuations;
  String get tapRecordToStart;
  String get next;
  String get previous;
  String get finish;
  String get pleaseTestYourSpeakerDescription;
  String get pleaseTestYourMicrophoneDescription;
  String get noBackgroundNoiseDescription;
  String get recordExactlyAsShownDescription;
  String get dontRecordPunctuationsDescription;
  String get tapRecordToStartDescription;
  String get tamil;
  String get malayalam;
  String get bengali;
  String get punjabi;
  String get odia;
  String get assamese;
  String get startRecording;
  String get stopRecording;
  String get reRecord;
  String get playContribution;
  String get playRecording;
  String get selectLanguageForContribution;
  String get enrichYourLanguageByDonatingVoice;
  String get downloadCertificate;
  String get validateMore;
  String get downloadPdf;
  String get gender;
  String get alreadyHaveAccount;
  String get fillInYour;
  String get personalDetails;
  String get toCreateYourAccount;
  String get verifyYourPhoneNumber;
  String get weWillSendA;
  String get oneTimePasswordOtp;
  String get toThisMobileNumber;
  String get invalidPhoneNumberMessage;
  String get phoneNumberMustBe10Digits;
  String get otpSentSuccessfullyMessage;
  String get loginIntoYourBhashaDaanAccount;
  String get enterYour;
  String get emailAndPassword;
  String get toAccessYourAccount;
  String get doesntHaveAccount;
  String get howItWorks;
  String get enterYourMobileNumber;
  String get otherInformation;
  String get country;
  String get state;
  String get district;
  String get preferredLanguage;
  String get thisFieldIsRequiredToContinue;
  String get tapToPreviewYourCertificate;
  String get certificatePreview;
  String get pdfPrintReadyIncludesNameAchievement;
  String get ministryOfElectronicsItHindi;
  String get ministryOfElectronicsItEnglish;
  String get digitalIndia;
  String get bhashiniHindi;
  String get bhashiniEnglish;
  String get certificate;
  String get ofAppreciation;
  String get proudlyPresentedTo;
  String get viewProfile;
  String get errorTitle;
  String get errorSubtitle;
  String get errorDesc;
  String get errorButton;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return Future.value(_lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'ml'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations _lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'ml':
      return AppLocalizationsMl();
  }
  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
