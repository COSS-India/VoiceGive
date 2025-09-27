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
/// import 'gen_l10n/app_localizations.dart';
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
/// To configure the locales supported by your app, you'll need to edit this
/// file.
///
/// First, open your project's ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project's Runner folder.
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
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

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
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en')
  ];

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

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @verifyPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Verify your phone number'**
  String get verifyPhoneNumber;

  /// No description provided for @otpSentMessage.
  ///
  /// In en, this message translates to:
  /// **'We will send a One Time Password(OTP) to this mobile number.'**
  String get otpSentMessage;

  /// No description provided for @enterMobileNumber.
  ///
  /// In en, this message translates to:
  /// **'Enter mobile no.*'**
  String get enterMobileNumber;

  /// No description provided for @getOtp.
  ///
  /// In en, this message translates to:
  /// **'Get OTP'**
  String get getOtp;

  /// No description provided for @invalidPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid phone number'**
  String get invalidPhoneNumber;

  /// No description provided for @otpVerification.
  ///
  /// In en, this message translates to:
  /// **'OTP Verification'**
  String get otpVerification;

  /// No description provided for @otpSentToNumber.
  ///
  /// In en, this message translates to:
  /// **'Enter the OTP from the sms we sent to +91'**
  String get otpSentToNumber;

  /// No description provided for @resendOtp.
  ///
  /// In en, this message translates to:
  /// **'I didn\'t receive any OTP. RESEND'**
  String get resendOtp;

  /// No description provided for @submitOtp.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get submitOtp;

  /// No description provided for @otpExpired.
  ///
  /// In en, this message translates to:
  /// **'OTP has expired. Please request a new one.'**
  String get otpExpired;

  /// No description provided for @invalidOtp.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid OTP'**
  String get invalidOtp;

  /// No description provided for @signUp.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signUp;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot password functionality coming soon!'**
  String get forgotPassword;

  /// No description provided for @loginFailed.
  ///
  /// In en, this message translates to:
  /// **'Login failed'**
  String get loginFailed;

  /// No description provided for @networkError.
  ///
  /// In en, this message translates to:
  /// **'Network error. Please check your connection.'**
  String get networkError;

  /// No description provided for @failedToLoadCaptcha.
  ///
  /// In en, this message translates to:
  /// **'Failed to load captcha'**
  String get failedToLoadCaptcha;

  /// No description provided for @pleaseWaitForCaptcha.
  ///
  /// In en, this message translates to:
  /// **'Please wait for captcha to load'**
  String get pleaseWaitForCaptcha;

  /// No description provided for @refreshCaptcha.
  ///
  /// In en, this message translates to:
  /// **'Refresh Captcha'**
  String get refreshCaptcha;

  /// No description provided for @passwordRequired.
  ///
  /// In en, this message translates to:
  /// **'Password is required'**
  String get passwordRequired;

  /// No description provided for @passwordMinLength.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 8 characters'**
  String get passwordMinLength;

  /// No description provided for @passwordComplexity.
  ///
  /// In en, this message translates to:
  /// **'Password must contain uppercase, lowercase and number'**
  String get passwordComplexity;

  /// No description provided for @emailRequired.
  ///
  /// In en, this message translates to:
  /// **'Email is required'**
  String get emailRequired;

  /// No description provided for @invalidEmail.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email'**
  String get invalidEmail;

  /// No description provided for @acceptTermsAndConditions.
  ///
  /// In en, this message translates to:
  /// **'Please accept the Terms & Conditions and Privacy Policy'**
  String get acceptTermsAndConditions;

  /// No description provided for @termsAndConditionsComingSoon.
  ///
  /// In en, this message translates to:
  /// **'Terms & Conditions page coming soon!'**
  String get termsAndConditionsComingSoon;

  /// No description provided for @privacyPolicyComingSoon.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy page coming soon!'**
  String get privacyPolicyComingSoon;

  /// No description provided for @otpSentSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'OTP sent successfully'**
  String get otpSentSuccessfully;

  /// No description provided for @otpSentToEmail.
  ///
  /// In en, this message translates to:
  /// **'OTP sent successfully to {email}'**
  String otpSentToEmail(Object email);

  /// No description provided for @quickTips.
  ///
  /// In en, this message translates to:
  /// **'Quick Tips'**
  String get quickTips;

  /// No description provided for @report.
  ///
  /// In en, this message translates to:
  /// **'Report'**
  String get report;

  /// No description provided for @testSpeakers.
  ///
  /// In en, this message translates to:
  /// **'Test Speakers'**
  String get testSpeakers;

  /// No description provided for @contributeMore.
  ///
  /// In en, this message translates to:
  /// **'Contribute More'**
  String get contributeMore;

  /// No description provided for @validate.
  ///
  /// In en, this message translates to:
  /// **'Validate'**
  String get validate;

  /// No description provided for @incorrect.
  ///
  /// In en, this message translates to:
  /// **'Incorrect'**
  String get incorrect;

  /// No description provided for @correct.
  ///
  /// In en, this message translates to:
  /// **'Correct'**
  String get correct;

  /// No description provided for @skippingCurrentSentence.
  ///
  /// In en, this message translates to:
  /// **'Skipping current sentence...'**
  String get skippingCurrentSentence;

  /// No description provided for @skippedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Skipped successfully'**
  String get skippedSuccessfully;

  /// No description provided for @skipFailed.
  ///
  /// In en, this message translates to:
  /// **'Skip failed'**
  String get skipFailed;

  /// No description provided for @noValidationItemsAvailable.
  ///
  /// In en, this message translates to:
  /// **'No validation items available'**
  String get noValidationItemsAvailable;

  /// No description provided for @failedToFetchValidationItems.
  ///
  /// In en, this message translates to:
  /// **'Failed to fetch validation items'**
  String get failedToFetchValidationItems;

  /// No description provided for @pleaseSelectAgeGroupAndGender.
  ///
  /// In en, this message translates to:
  /// **'Please select age group and gender'**
  String get pleaseSelectAgeGroupAndGender;

  /// No description provided for @enterMobileNumberHint.
  ///
  /// In en, this message translates to:
  /// **'Enter mobile number'**
  String get enterMobileNumberHint;

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// No description provided for @submit.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get submit;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip;

  /// No description provided for @label.
  ///
  /// In en, this message translates to:
  /// **'Label'**
  String get label;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @selectLanguage.
  ///
  /// In en, this message translates to:
  /// **'Select the language for contribution:'**
  String get selectLanguage;

  /// No description provided for @noResultsFound.
  ///
  /// In en, this message translates to:
  /// **'No results found'**
  String get noResultsFound;

  /// No description provided for @startTyping.
  ///
  /// In en, this message translates to:
  /// **'Start typing here...'**
  String get startTyping;

  /// No description provided for @inputSubmitted.
  ///
  /// In en, this message translates to:
  /// **'Thanks for your contribution! we have received your input.'**
  String get inputSubmitted;

  /// No description provided for @validationSuccessMessage.
  ///
  /// In en, this message translates to:
  /// **'Thank you for validating the input.'**
  String get validationSuccessMessage;

  // New strings added for localization
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
  String get youMarkedRecordingAs;
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
  String get gender;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {

  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
