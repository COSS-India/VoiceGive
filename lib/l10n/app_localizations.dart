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
  /// **'BOLO India'**
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

  /// No description provided for @completeYourProfile.
  ///
  /// In en, this message translates to:
  /// **'Complete your profile'**
  String get completeYourProfile;

  /// No description provided for @personalInformation.
  ///
  /// In en, this message translates to:
  /// **'Personal Information'**
  String get personalInformation;

  /// No description provided for @firstName.
  ///
  /// In en, this message translates to:
  /// **'First Name'**
  String get firstName;

  /// No description provided for @lastName.
  ///
  /// In en, this message translates to:
  /// **'Last Name'**
  String get lastName;

  /// No description provided for @chooseYourAgeGroup.
  ///
  /// In en, this message translates to:
  /// **'Choose your age group'**
  String get chooseYourAgeGroup;

  /// No description provided for @emailId.
  ///
  /// In en, this message translates to:
  /// **'Email ID'**
  String get emailId;

  /// No description provided for @saveAndContinue.
  ///
  /// In en, this message translates to:
  /// **'Save & Continue'**
  String get saveAndContinue;

  /// No description provided for @firstNameRequired.
  ///
  /// In en, this message translates to:
  /// **'First name is required'**
  String get firstNameRequired;

  /// No description provided for @lastNameRequired.
  ///
  /// In en, this message translates to:
  /// **'Last name is required'**
  String get lastNameRequired;

  /// No description provided for @under18Years.
  ///
  /// In en, this message translates to:
  /// **'Under 18 years'**
  String get under18Years;

  /// No description provided for @age18To24.
  ///
  /// In en, this message translates to:
  /// **'18-24 years'**
  String get age18To24;

  /// No description provided for @age25To34.
  ///
  /// In en, this message translates to:
  /// **'25-34 years'**
  String get age25To34;

  /// No description provided for @age35To44.
  ///
  /// In en, this message translates to:
  /// **'35-44 years'**
  String get age35To44;

  /// No description provided for @age45To54.
  ///
  /// In en, this message translates to:
  /// **'45-54 years'**
  String get age45To54;

  /// No description provided for @age55To64.
  ///
  /// In en, this message translates to:
  /// **'55-64 years'**
  String get age55To64;

  /// No description provided for @age65Plus.
  ///
  /// In en, this message translates to:
  /// **'65+ years'**
  String get age65Plus;

  /// No description provided for @male.
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get male;

  /// No description provided for @female.
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get female;

  /// No description provided for @nonBinary.
  ///
  /// In en, this message translates to:
  /// **'Non-binary'**
  String get nonBinary;

  /// No description provided for @preferNotToSay.
  ///
  /// In en, this message translates to:
  /// **'Prefer not to say'**
  String get preferNotToSay;

  /// No description provided for @enrichYourLanguage.
  ///
  /// In en, this message translates to:
  /// **'Enrich your language by donating your voice.'**
  String get enrichYourLanguage;

  /// No description provided for @selectLanguageForValidation.
  ///
  /// In en, this message translates to:
  /// **'Select the language for validation'**
  String get selectLanguageForValidation;

  /// No description provided for @pauseRecording.
  ///
  /// In en, this message translates to:
  /// **'Pause Recording'**
  String get pauseRecording;

  /// No description provided for @replayRecording.
  ///
  /// In en, this message translates to:
  /// **'Replay Recording'**
  String get replayRecording;

  /// No description provided for @markedIncorrect.
  ///
  /// In en, this message translates to:
  /// **'Marked Incorrect'**
  String get markedIncorrect;

  /// No description provided for @markedCorrect.
  ///
  /// In en, this message translates to:
  /// **'Marked Correct'**
  String get markedCorrect;

  /// No description provided for @rejectFailed.
  ///
  /// In en, this message translates to:
  /// **'Reject failed'**
  String get rejectFailed;

  /// No description provided for @acceptFailed.
  ///
  /// In en, this message translates to:
  /// **'Accept failed'**
  String get acceptFailed;

  /// No description provided for @validationResult.
  ///
  /// In en, this message translates to:
  /// **'Validation Result'**
  String get validationResult;

  /// No description provided for @youMarkedRecordingAs.
  ///
  /// In en, this message translates to:
  /// **'You marked this recording as \'{result}\'. Thank you for your validation!'**
  String youMarkedRecordingAs(Object result);

  /// No description provided for @continueButton.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueButton;

  /// No description provided for @pleaseEnterCaptcha.
  ///
  /// In en, this message translates to:
  /// **'Please enter CAPTCHA'**
  String get pleaseEnterCaptcha;

  /// No description provided for @captchaNotLoaded.
  ///
  /// In en, this message translates to:
  /// **'CAPTCHA not loaded'**
  String get captchaNotLoaded;

  /// No description provided for @signIn.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get signIn;

  /// No description provided for @createBhashaDaanAccount.
  ///
  /// In en, this message translates to:
  /// **'Create a BhashaDaan Account'**
  String get createBhashaDaanAccount;

  /// No description provided for @verifyOtp.
  ///
  /// In en, this message translates to:
  /// **'Verify OTP'**
  String get verifyOtp;

  /// No description provided for @otpSentToMail.
  ///
  /// In en, this message translates to:
  /// **'An OTP has been sent to your mail'**
  String get otpSentToMail;

  /// No description provided for @namasteContributor.
  ///
  /// In en, this message translates to:
  /// **'Namaste Contributor/Validator'**
  String get namasteContributor;

  /// No description provided for @consentMessage.
  ///
  /// In en, this message translates to:
  /// **'Before you begin contributing or validating on AgriDaan, please take a moment to review our Privacy Policy and Terms of Use. We kindly ask for your consent to continue.'**
  String get consentMessage;

  /// No description provided for @iAgree.
  ///
  /// In en, this message translates to:
  /// **'I agree'**
  String get iAgree;

  /// No description provided for @india.
  ///
  /// In en, this message translates to:
  /// **'India'**
  String get india;

  /// No description provided for @maharashtra.
  ///
  /// In en, this message translates to:
  /// **'Maharashtra'**
  String get maharashtra;

  /// No description provided for @pune.
  ///
  /// In en, this message translates to:
  /// **'Pune'**
  String get pune;

  /// No description provided for @mumbai.
  ///
  /// In en, this message translates to:
  /// **'Mumbai'**
  String get mumbai;

  /// No description provided for @nashik.
  ///
  /// In en, this message translates to:
  /// **'Nashik'**
  String get nashik;

  /// No description provided for @nagpur.
  ///
  /// In en, this message translates to:
  /// **'Nagpur'**
  String get nagpur;

  /// No description provided for @thane.
  ///
  /// In en, this message translates to:
  /// **'Thane'**
  String get thane;

  /// No description provided for @aurangabad.
  ///
  /// In en, this message translates to:
  /// **'Aurangabad'**
  String get aurangabad;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @hindi.
  ///
  /// In en, this message translates to:
  /// **'Hindi'**
  String get hindi;

  /// No description provided for @marathi.
  ///
  /// In en, this message translates to:
  /// **'Marathi'**
  String get marathi;

  /// No description provided for @gujarati.
  ///
  /// In en, this message translates to:
  /// **'Gujarati'**
  String get gujarati;

  /// No description provided for @kannada.
  ///
  /// In en, this message translates to:
  /// **'Kannada'**
  String get kannada;

  /// No description provided for @telugu.
  ///
  /// In en, this message translates to:
  /// **'Telugu'**
  String get telugu;

  /// No description provided for @karnataka.
  ///
  /// In en, this message translates to:
  /// **'Karnataka'**
  String get karnataka;

  /// No description provided for @whatIsAgriDaan.
  ///
  /// In en, this message translates to:
  /// **'What is AgriDaan?'**
  String get whatIsAgriDaan;

  /// No description provided for @agriDaanDescription.
  ///
  /// In en, this message translates to:
  /// **'Agridaan is an initiative to crowdsource agriculture-related knowledge from citizens across India as part of Project BHASHINI. It calls upon people to contribute local terms, practices, and insights to build an open repository of agricultural data, helping to digitally enrich and preserve India\'s diverse farming heritage.'**
  String get agriDaanDescription;

  /// No description provided for @empowerIndiasLinguisticDiversity.
  ///
  /// In en, this message translates to:
  /// **'Empower India\'s \nLinguistic Diversity'**
  String get empowerIndiasLinguisticDiversity;

  /// No description provided for @joinTheMovementDescription.
  ///
  /// In en, this message translates to:
  /// **'Join the movement to enhance language understanding and accessibility for all 22 official languages in India'**
  String get joinTheMovementDescription;

  /// No description provided for @letsGetStarted.
  ///
  /// In en, this message translates to:
  /// **'Let\'s Get Started'**
  String get letsGetStarted;

  /// No description provided for @digitalIndiaBhashiniDivision.
  ///
  /// In en, this message translates to:
  /// **'Digital India Bhashini Division'**
  String get digitalIndiaBhashiniDivision;

  /// No description provided for @electronicsNiketanAddress.
  ///
  /// In en, this message translates to:
  /// **'Electronics Niketan, 6-CGO Complex, New Delhi - 110003'**
  String get electronicsNiketanAddress;

  /// No description provided for @poweredBy.
  ///
  /// In en, this message translates to:
  /// **'Powered by'**
  String get poweredBy;

  /// No description provided for @digitalIndiaCorporation.
  ///
  /// In en, this message translates to:
  /// **'Digital India Corporation(DIC)'**
  String get digitalIndiaCorporation;

  /// No description provided for @ministryOfElectronicsIt.
  ///
  /// In en, this message translates to:
  /// **'Ministry of Electronics & IT (MeitY)'**
  String get ministryOfElectronicsIt;

  /// No description provided for @governmentOfIndia.
  ///
  /// In en, this message translates to:
  /// **'Government of India®'**
  String get governmentOfIndia;

  /// No description provided for @copyrightNotice.
  ///
  /// In en, this message translates to:
  /// **'© 2025 - Copyright All rights reserved.'**
  String get copyrightNotice;

  /// No description provided for @needMoreInfo.
  ///
  /// In en, this message translates to:
  /// **'Need More Information?'**
  String get needMoreInfo;

  /// No description provided for @writeYourConcern.
  ///
  /// In en, this message translates to:
  /// **'Write your concern to us and we will get back to you.'**
  String get writeYourConcern;

  /// No description provided for @contactUs.
  ///
  /// In en, this message translates to:
  /// **'Contact Us'**
  String get contactUs;

  /// No description provided for @enterOtpFromSms.
  ///
  /// In en, this message translates to:
  /// **'Enter the OTP from the sms we sent to +91'**
  String get enterOtpFromSms;

  /// No description provided for @contribute.
  ///
  /// In en, this message translates to:
  /// **'Contribute'**
  String get contribute;

  /// No description provided for @speakClearlyAndRecord.
  ///
  /// In en, this message translates to:
  /// **'Speak clearly and record the displayed sentence'**
  String get speakClearlyAndRecord;

  /// No description provided for @listenAndValidate.
  ///
  /// In en, this message translates to:
  /// **'Listen to recordings and validate their accuracy'**
  String get listenAndValidate;

  /// No description provided for @earnCertificate.
  ///
  /// In en, this message translates to:
  /// **'Earn Certificate'**
  String get earnCertificate;

  /// No description provided for @earnCertificateDescription.
  ///
  /// In en, this message translates to:
  /// **'Earn a certificate for your contributions'**
  String get earnCertificateDescription;

  /// No description provided for @checkYourSetup.
  ///
  /// In en, this message translates to:
  /// **'Check Your Setup'**
  String get checkYourSetup;

  /// No description provided for @pleaseTestYourSpeaker.
  ///
  /// In en, this message translates to:
  /// **'Please Test Your Speaker'**
  String get pleaseTestYourSpeaker;

  /// No description provided for @pleaseTestYourMicrophone.
  ///
  /// In en, this message translates to:
  /// **'Please Test Your Microphone'**
  String get pleaseTestYourMicrophone;

  /// No description provided for @noBackgroundNoise.
  ///
  /// In en, this message translates to:
  /// **'No background noise'**
  String get noBackgroundNoise;

  /// No description provided for @speakNaturally.
  ///
  /// In en, this message translates to:
  /// **'Speak Naturally'**
  String get speakNaturally;

  /// No description provided for @recordExactlyAsShown.
  ///
  /// In en, this message translates to:
  /// **'Record exactly as shown'**
  String get recordExactlyAsShown;

  /// No description provided for @dontRecordPunctuations.
  ///
  /// In en, this message translates to:
  /// **'Don\'t record Punctuations'**
  String get dontRecordPunctuations;

  /// No description provided for @tapRecordToStart.
  ///
  /// In en, this message translates to:
  /// **'Tap record to start'**
  String get tapRecordToStart;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @previous.
  ///
  /// In en, this message translates to:
  /// **'Previous'**
  String get previous;

  /// No description provided for @finish.
  ///
  /// In en, this message translates to:
  /// **'Finish'**
  String get finish;

  /// No description provided for @pleaseTestYourSpeakerDescription.
  ///
  /// In en, this message translates to:
  /// **'Play the sample audio and confirm you can hear it clearly before starting the task'**
  String get pleaseTestYourSpeakerDescription;

  /// No description provided for @pleaseTestYourMicrophoneDescription.
  ///
  /// In en, this message translates to:
  /// **'Speak a few words to check if your voice is being recorded properly and without distortion'**
  String get pleaseTestYourMicrophoneDescription;

  /// No description provided for @noBackgroundNoiseDescription.
  ///
  /// In en, this message translates to:
  /// **'Choose a quiet environment. Avoid background sounds like fans, traffic, or other voices while recording'**
  String get noBackgroundNoiseDescription;

  /// No description provided for @recordExactlyAsShownDescription.
  ///
  /// In en, this message translates to:
  /// **'Speak clearly, exactly following the text displayed, so your contribution is accurate and usable'**
  String get recordExactlyAsShownDescription;

  /// No description provided for @dontRecordPunctuationsDescription.
  ///
  /// In en, this message translates to:
  /// **'Read only the words shown on screen. Do not say commas, full stops, or other punctuations marks.'**
  String get dontRecordPunctuationsDescription;

  /// No description provided for @tapRecordToStartDescription.
  ///
  /// In en, this message translates to:
  /// **'Press the record button once you are ready, and speak clearly and naturally.'**
  String get tapRecordToStartDescription;

  /// No description provided for @tamil.
  ///
  /// In en, this message translates to:
  /// **'Tamil'**
  String get tamil;

  /// No description provided for @malayalam.
  ///
  /// In en, this message translates to:
  /// **'Malayalam'**
  String get malayalam;

  /// No description provided for @bengali.
  ///
  /// In en, this message translates to:
  /// **'Bengali'**
  String get bengali;

  /// No description provided for @punjabi.
  ///
  /// In en, this message translates to:
  /// **'Punjabi'**
  String get punjabi;

  /// No description provided for @odia.
  ///
  /// In en, this message translates to:
  /// **'Odia'**
  String get odia;

  /// No description provided for @assamese.
  ///
  /// In en, this message translates to:
  /// **'Assamese'**
  String get assamese;

  /// No description provided for @startRecording.
  ///
  /// In en, this message translates to:
  /// **'Start Recording'**
  String get startRecording;

  /// No description provided for @stopRecording.
  ///
  /// In en, this message translates to:
  /// **'Stop Recording'**
  String get stopRecording;

  /// No description provided for @reRecord.
  ///
  /// In en, this message translates to:
  /// **'Re-record'**
  String get reRecord;

  /// No description provided for @playContribution.
  ///
  /// In en, this message translates to:
  /// **'Play Contribution'**
  String get playContribution;

  /// No description provided for @playRecording.
  ///
  /// In en, this message translates to:
  /// **'Play Recording'**
  String get playRecording;

  /// No description provided for @selectLanguageForContribution.
  ///
  /// In en, this message translates to:
  /// **'Select the language for contribution'**
  String get selectLanguageForContribution;

  /// No description provided for @enrichYourLanguageByDonatingVoice.
  ///
  /// In en, this message translates to:
  /// **'Enrich your language by donating your voice.'**
  String get enrichYourLanguageByDonatingVoice;

  /// No description provided for @downloadCertificate.
  ///
  /// In en, this message translates to:
  /// **'Download Certificate'**
  String get downloadCertificate;

  /// No description provided for @validateMore.
  ///
  /// In en, this message translates to:
  /// **'Validate More'**
  String get validateMore;

  /// No description provided for @downloadPdf.
  ///
  /// In en, this message translates to:
  /// **'Download PDF'**
  String get downloadPdf;

  /// No description provided for @gender.
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get gender;

  /// No description provided for @alreadyHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get alreadyHaveAccount;

  /// No description provided for @fillInYour.
  ///
  /// In en, this message translates to:
  /// **'Fill in your '**
  String get fillInYour;

  /// No description provided for @personalDetails.
  ///
  /// In en, this message translates to:
  /// **'personal details '**
  String get personalDetails;

  /// No description provided for @toCreateYourAccount.
  ///
  /// In en, this message translates to:
  /// **'to create your account'**
  String get toCreateYourAccount;

  /// No description provided for @verifyYourPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Verify your\nphone number'**
  String get verifyYourPhoneNumber;

  /// No description provided for @weWillSendA.
  ///
  /// In en, this message translates to:
  /// **'We will send a '**
  String get weWillSendA;

  /// No description provided for @oneTimePasswordOtp.
  ///
  /// In en, this message translates to:
  /// **'One Time Password (OTP)'**
  String get oneTimePasswordOtp;

  /// No description provided for @toThisMobileNumber.
  ///
  /// In en, this message translates to:
  /// **' to this mobile number.'**
  String get toThisMobileNumber;

  /// No description provided for @invalidPhoneNumberMessage.
  ///
  /// In en, this message translates to:
  /// **'Invalid phone number'**
  String get invalidPhoneNumberMessage;

  /// No description provided for @phoneNumberMustBe10Digits.
  ///
  /// In en, this message translates to:
  /// **'Phone number must be 10 digits'**
  String get phoneNumberMustBe10Digits;

  /// No description provided for @otpSentSuccessfullyMessage.
  ///
  /// In en, this message translates to:
  /// **'OTP sent successfully!'**
  String get otpSentSuccessfullyMessage;

  /// No description provided for @loginIntoYourBhashaDaanAccount.
  ///
  /// In en, this message translates to:
  /// **'Login into your\nBhashaDaan Account'**
  String get loginIntoYourBhashaDaanAccount;

  /// No description provided for @enterYour.
  ///
  /// In en, this message translates to:
  /// **'Enter your '**
  String get enterYour;

  /// No description provided for @emailAndPassword.
  ///
  /// In en, this message translates to:
  /// **'email and password '**
  String get emailAndPassword;

  /// No description provided for @toAccessYourAccount.
  ///
  /// In en, this message translates to:
  /// **'to access your account'**
  String get toAccessYourAccount;

  /// No description provided for @doesntHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account? '**
  String get doesntHaveAccount;

  /// No description provided for @howItWorks.
  ///
  /// In en, this message translates to:
  /// **'How it Works'**
  String get howItWorks;

  /// No description provided for @enterYourMobileNumber.
  ///
  /// In en, this message translates to:
  /// **'Enter your mobile number'**
  String get enterYourMobileNumber;

  /// No description provided for @otherInformation.
  ///
  /// In en, this message translates to:
  /// **'Other Information'**
  String get otherInformation;

  /// No description provided for @country.
  ///
  /// In en, this message translates to:
  /// **'Country'**
  String get country;

  /// No description provided for @state.
  ///
  /// In en, this message translates to:
  /// **'State'**
  String get state;

  /// No description provided for @district.
  ///
  /// In en, this message translates to:
  /// **'District'**
  String get district;

  /// No description provided for @preferredLanguage.
  ///
  /// In en, this message translates to:
  /// **'Preferred Language'**
  String get preferredLanguage;

  /// No description provided for @thisFieldIsRequiredToContinue.
  ///
  /// In en, this message translates to:
  /// **'This field is required to continue.'**
  String get thisFieldIsRequiredToContinue;

  /// No description provided for @tapToPreviewYourCertificate.
  ///
  /// In en, this message translates to:
  /// **'Tap to preview your certificate'**
  String get tapToPreviewYourCertificate;

  /// No description provided for @certificatePreview.
  ///
  /// In en, this message translates to:
  /// **'Certificate Preview'**
  String get certificatePreview;

  /// No description provided for @pdfPrintReadyIncludesNameAchievement.
  ///
  /// In en, this message translates to:
  /// **'PDF (print-ready, includes your name & achievement)'**
  String get pdfPrintReadyIncludesNameAchievement;

  /// No description provided for @ministryOfElectronicsItHindi.
  ///
  /// In en, this message translates to:
  /// **'इलेक्ट्रॉनिकी एवं सूचना प्रौद्योगिकी मंत्रालय'**
  String get ministryOfElectronicsItHindi;

  /// No description provided for @ministryOfElectronicsItEnglish.
  ///
  /// In en, this message translates to:
  /// **'MINISTRY OF ELECTRONICS AND INFORMATION TECHNOLOGY'**
  String get ministryOfElectronicsItEnglish;

  /// No description provided for @digitalIndia.
  ///
  /// In en, this message translates to:
  /// **'Digital India'**
  String get digitalIndia;

  /// No description provided for @bhashiniHindi.
  ///
  /// In en, this message translates to:
  /// **'भाषिणी'**
  String get bhashiniHindi;

  /// No description provided for @bhashiniEnglish.
  ///
  /// In en, this message translates to:
  /// **'BHASHINI'**
  String get bhashiniEnglish;

  /// No description provided for @certificate.
  ///
  /// In en, this message translates to:
  /// **'CERTIFICATE'**
  String get certificate;

  /// No description provided for @ofAppreciation.
  ///
  /// In en, this message translates to:
  /// **'OF APPRECIATION'**
  String get ofAppreciation;

  /// No description provided for @proudlyPresentedTo.
  ///
  /// In en, this message translates to:
  /// **'PROUDLY PRESENTED TO'**
  String get proudlyPresentedTo;

  /// No description provided for @viewProfile.
  ///
  /// In en, this message translates to:
  /// **'View Profile'**
  String get viewProfile;

  /// No description provided for @errorDesc.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong. Please try again.'**
  String get errorDesc;

  /// No description provided for @errorSubtitle.
  ///
  /// In en, this message translates to:
  /// **'We encountered an error while processing your request.'**
  String get errorSubtitle;

  /// No description provided for @errorButton.
  ///
  /// In en, this message translates to:
  /// **'Try Again'**
  String get errorButton;
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
