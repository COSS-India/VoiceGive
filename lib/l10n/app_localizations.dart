import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'app_localizations_en.dart';
import 'app_localizations_ml.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = [
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ];

  static const List<Locale> supportedLocales = [
    Locale('en'),
    Locale('ml'),
  ];

  AppLocalizationsEn get en => AppLocalizationsEn(locale.languageCode);
  AppLocalizationsMl get ml => AppLocalizationsMl(locale.languageCode);

  // Fallback to English if locale not found
  dynamic get _localizedValues {
    switch (locale.languageCode) {
      case 'en':
        return en;
      case 'ml':
        return ml;
      default:
        return en;
    }
  }

  // All the getter methods
  String get bhashadaan => _localizedValues.bhashadaan;
  String get home => _localizedValues.home;
  String get bolo => _localizedValues.bolo;
  String get suno => _localizedValues.suno;
  String get likho => _localizedValues.likho;
  String get dekho => _localizedValues.dekho;
  String get boloIndia => _localizedValues.boloIndia;
  String get sunoIndia => _localizedValues.sunoIndia;
  String get likhoIndia => _localizedValues.likhoIndia;
  String get dekhoIndia => _localizedValues.dekhoIndia;
  String get mStaticLabel => _localizedValues.mStaticLabel;
  String get mStaticValidate => _localizedValues.mStaticValidate;
  String get mStaticSelectLanguage => _localizedValues.mStaticSelectLanguage;
  String get mStaticSearch => _localizedValues.mStaticSearch;
  String get mStaticSubmit => _localizedValues.mStaticSubmit;
  String get mStaticCancel => _localizedValues.mStaticCancel;
  String get mStaticSkip => _localizedValues.mStaticSkip;
  String get mStaticNoSearchResultFound => _localizedValues.mStaticNoSearchResultFound;
  String get mStaticStartTyping => _localizedValues.mStaticStartTyping;
  String get mStaticInputSubmitted => _localizedValues.mStaticInputSubmitted;
  String get mStaticValidationSuccessMessage => _localizedValues.mStaticValidationSuccessMessage;
  String get login => _localizedValues.login;
  String get verifyPhoneNumber => _localizedValues.verifyPhoneNumber;
  String get otpSentMessage => _localizedValues.otpSentMessage;
  String get enterMobileNumber => _localizedValues.enterMobileNumber;
  String get getOtp => _localizedValues.getOtp;
  String get invalidPhoneNumber => _localizedValues.invalidPhoneNumber;
  String get otpVerification => _localizedValues.otpVerification;
  String get otpSentToNumber => _localizedValues.otpSentToNumber;
  String get resendOtp => _localizedValues.resendOtp;
  String get submitOtp => _localizedValues.submitOtp;
  String get otpExpired => _localizedValues.otpExpired;
  String get invalidOtp => _localizedValues.invalidOtp;
  String get signUp => _localizedValues.signUp;
  String get forgotPassword => _localizedValues.forgotPassword;
  String get loginFailed => _localizedValues.loginFailed;
  String get networkError => _localizedValues.networkError;
  String get failedToLoadCaptcha => _localizedValues.failedToLoadCaptcha;
  String get pleaseWaitForCaptcha => _localizedValues.pleaseWaitForCaptcha;
  String get refreshCaptcha => _localizedValues.refreshCaptcha;
  String get passwordRequired => _localizedValues.passwordRequired;
  String get passwordMinLength => _localizedValues.passwordMinLength;
  String get passwordComplexity => _localizedValues.passwordComplexity;
  String get emailRequired => _localizedValues.emailRequired;
  String get invalidEmail => _localizedValues.invalidEmail;
  String get acceptTermsAndConditions => _localizedValues.acceptTermsAndConditions;
  String get termsAndConditionsComingSoon => _localizedValues.termsAndConditionsComingSoon;
  String get privacyPolicyComingSoon => _localizedValues.privacyPolicyComingSoon;
  String get otpSentSuccessfully => _localizedValues.otpSentSuccessfully;
  String get otpSentToEmail => _localizedValues.otpSentToEmail;
  String get quickTips => _localizedValues.quickTips;
  String get report => _localizedValues.report;
  String get testSpeakers => _localizedValues.testSpeakers;
  String get contributeMore => _localizedValues.contributeMore;
  String get validate => _localizedValues.validate;
  String get incorrect => _localizedValues.incorrect;
  String get correct => _localizedValues.correct;
  String get skippingCurrentSentence => _localizedValues.skippingCurrentSentence;
  String get skippedSuccessfully => _localizedValues.skippedSuccessfully;
  String get skipFailed => _localizedValues.skipFailed;
  String get noValidationItemsAvailable => _localizedValues.noValidationItemsAvailable;
  String get failedToFetchValidationItems => _localizedValues.failedToFetchValidationItems;
  String get pleaseSelectAgeGroupAndGender => _localizedValues.pleaseSelectAgeGroupAndGender;
  String get enterMobileNumberHint => _localizedValues.enterMobileNumberHint;
  String get error => _localizedValues.error;
  String get submit => _localizedValues.submit;
  String get cancel => _localizedValues.cancel;
  String get skip => _localizedValues.skip;
  String get label => _localizedValues.label;
  String get search => _localizedValues.search;
  String get selectLanguage => _localizedValues.selectLanguage;
  String get noResultsFound => _localizedValues.noResultsFound;
  String get startTyping => _localizedValues.startTyping;
  String get inputSubmitted => _localizedValues.inputSubmitted;
  String get validationSuccessMessage => _localizedValues.validationSuccessMessage;
  String get completeYourProfile => _localizedValues.completeYourProfile;
  String get personalInformation => _localizedValues.personalInformation;
  String get firstName => _localizedValues.firstName;
  String get lastName => _localizedValues.lastName;
  String get chooseYourAgeGroup => _localizedValues.chooseYourAgeGroup;
  String get emailId => _localizedValues.emailId;
  String get saveAndContinue => _localizedValues.saveAndContinue;
  String get firstNameRequired => _localizedValues.firstNameRequired;
  String get lastNameRequired => _localizedValues.lastNameRequired;
  String get under18Years => _localizedValues.under18Years;
  String get age18To24 => _localizedValues.age18To24;
  String get age25To34 => _localizedValues.age25To34;
  String get age35To44 => _localizedValues.age35To44;
  String get age45To54 => _localizedValues.age45To54;
  String get age55To64 => _localizedValues.age55To64;
  String get age65Plus => _localizedValues.age65Plus;
  String get male => _localizedValues.male;
  String get female => _localizedValues.female;
  String get nonBinary => _localizedValues.nonBinary;
  String get preferNotToSay => _localizedValues.preferNotToSay;
  String get enrichYourLanguage => _localizedValues.enrichYourLanguage;
  String get selectLanguageForValidation => _localizedValues.selectLanguageForValidation;
  String get pauseRecording => _localizedValues.pauseRecording;
  String get replayRecording => _localizedValues.replayRecording;
  String get markedIncorrect => _localizedValues.markedIncorrect;
  String get markedCorrect => _localizedValues.markedCorrect;
  String get rejectFailed => _localizedValues.rejectFailed;
  String get acceptFailed => _localizedValues.acceptFailed;
  String get validationResult => _localizedValues.validationResult;
  String youMarkedRecordingAs(String result) => _localizedValues.youMarkedRecordingAs(result);
  String get continueButton => _localizedValues.continueButton;
  String get pleaseEnterCaptcha => _localizedValues.pleaseEnterCaptcha;
  String get captchaNotLoaded => _localizedValues.captchaNotLoaded;
  String get signIn => _localizedValues.signIn;
  String get createBhashaDaanAccount => _localizedValues.createBhashaDaanAccount;
  String get verifyOtp => _localizedValues.verifyOtp;
  String get otpSentToMail => _localizedValues.otpSentToMail;
  String get namasteContributor => _localizedValues.namasteContributor;
  String get consentMessage => _localizedValues.consentMessage;
  String get iAgree => _localizedValues.iAgree;
  String get india => _localizedValues.india;
  String get maharashtra => _localizedValues.maharashtra;
  String get pune => _localizedValues.pune;
  String get mumbai => _localizedValues.mumbai;
  String get nashik => _localizedValues.nashik;
  String get nagpur => _localizedValues.nagpur;
  String get thane => _localizedValues.thane;
  String get aurangabad => _localizedValues.aurangabad;
  String get english => _localizedValues.english;
  String get hindi => _localizedValues.hindi;
  String get marathi => _localizedValues.marathi;
  String get gujarati => _localizedValues.gujarati;
  String get kannada => _localizedValues.kannada;
  String get telugu => _localizedValues.telugu;
  String get karnataka => _localizedValues.karnataka;
  String get whatIsAgriDaan => _localizedValues.whatIsAgriDaan;
  String get agriDaanDescription => _localizedValues.agriDaanDescription;
  String get empowerIndiasLinguisticDiversity => _localizedValues.empowerIndiasLinguisticDiversity;
  String get joinTheMovementDescription => _localizedValues.joinTheMovementDescription;
  String get letsGetStarted => _localizedValues.letsGetStarted;
  String get digitalIndiaBhashiniDivision => _localizedValues.digitalIndiaBhashiniDivision;
  String get electronicsNiketanAddress => _localizedValues.electronicsNiketanAddress;
  String get poweredBy => _localizedValues.poweredBy;
  String get digitalIndiaCorporation => _localizedValues.digitalIndiaCorporation;
  String get ministryOfElectronicsIt => _localizedValues.ministryOfElectronicsIt;
  String get governmentOfIndia => _localizedValues.governmentOfIndia;
  String get copyrightNotice => _localizedValues.copyrightNotice;
  String get needMoreInfo => _localizedValues.needMoreInfo;
  String get writeYourConcern => _localizedValues.writeYourConcern;
  String get contactUs => _localizedValues.contactUs;
  String get enterOtpFromSms => _localizedValues.enterOtpFromSms;
  String get contribute => _localizedValues.contribute;
  String get speakClearlyAndRecord => _localizedValues.speakClearlyAndRecord;
  String get listenAndValidate => _localizedValues.listenAndValidate;
  String get earnCertificate => _localizedValues.earnCertificate;
  String get earnCertificateDescription => _localizedValues.earnCertificateDescription;
  String get checkYourSetup => _localizedValues.checkYourSetup;
  String get pleaseTestYourSpeaker => _localizedValues.pleaseTestYourSpeaker;
  String get pleaseTestYourMicrophone => _localizedValues.pleaseTestYourMicrophone;
  String get noBackgroundNoise => _localizedValues.noBackgroundNoise;
  String get speakNaturally => _localizedValues.speakNaturally;
  String get recordExactlyAsShown => _localizedValues.recordExactlyAsShown;
  String get dontRecordPunctuations => _localizedValues.dontRecordPunctuations;
  String get tapRecordToStart => _localizedValues.tapRecordToStart;
  String get next => _localizedValues.next;
  String get previous => _localizedValues.previous;
  String get finish => _localizedValues.finish;
  String get pleaseTestYourSpeakerDescription => _localizedValues.pleaseTestYourSpeakerDescription;
  String get pleaseTestYourMicrophoneDescription => _localizedValues.pleaseTestYourMicrophoneDescription;
  String get noBackgroundNoiseDescription => _localizedValues.noBackgroundNoiseDescription;
  String get recordExactlyAsShownDescription => _localizedValues.recordExactlyAsShownDescription;
  String get dontRecordPunctuationsDescription => _localizedValues.dontRecordPunctuationsDescription;
  String get tapRecordToStartDescription => _localizedValues.tapRecordToStartDescription;
  String get tamil => _localizedValues.tamil;
  String get malayalam => _localizedValues.malayalam;
  String get bengali => _localizedValues.bengali;
  String get punjabi => _localizedValues.punjabi;
  String get odia => _localizedValues.odia;
  String get assamese => _localizedValues.assamese;
  String get startRecording => _localizedValues.startRecording;
  String get stopRecording => _localizedValues.stopRecording;
  String get reRecord => _localizedValues.reRecord;
  String get playContribution => _localizedValues.playContribution;
  String get playRecording => _localizedValues.playRecording;
  String get selectLanguageForContribution => _localizedValues.selectLanguageForContribution;
  String get enrichYourLanguageByDonatingVoice => _localizedValues.enrichYourLanguageByDonatingVoice;
  String get downloadCertificate => _localizedValues.downloadCertificate;
  String get validateMore => _localizedValues.validateMore;
  String get downloadPdf => _localizedValues.downloadPdf;
  String get gender => _localizedValues.gender;
  String get alreadyHaveAccount => _localizedValues.alreadyHaveAccount;
  String get fillInYour => _localizedValues.fillInYour;
  String get personalDetails => _localizedValues.personalDetails;
  String get toCreateYourAccount => _localizedValues.toCreateYourAccount;
  String get verifyYourPhoneNumber => _localizedValues.verifyYourPhoneNumber;
  String get weWillSendA => _localizedValues.weWillSendA;
  String get oneTimePasswordOtp => _localizedValues.oneTimePasswordOtp;
  String get toThisMobileNumber => _localizedValues.toThisMobileNumber;
  String get invalidPhoneNumberMessage => _localizedValues.invalidPhoneNumberMessage;
  String get phoneNumberMustBe10Digits => _localizedValues.phoneNumberMustBe10Digits;
  String get otpSentSuccessfullyMessage => _localizedValues.otpSentSuccessfullyMessage;
  String get loginIntoYourBhashaDaanAccount => _localizedValues.loginIntoYourBhashaDaanAccount;
  String get enterYour => _localizedValues.enterYour;
  String get emailAndPassword => _localizedValues.emailAndPassword;
  String get toAccessYourAccount => _localizedValues.toAccessYourAccount;
  String get doesntHaveAccount => _localizedValues.doesntHaveAccount;
  String get howItWorks => _localizedValues.howItWorks;
  String get enterYourMobileNumber => _localizedValues.enterYourMobileNumber;
  String get otherInformation => _localizedValues.otherInformation;
  String get country => _localizedValues.country;
  String get state => _localizedValues.state;
  String get district => _localizedValues.district;
  String get preferredLanguage => _localizedValues.preferredLanguage;
  String get thisFieldIsRequiredToContinue => _localizedValues.thisFieldIsRequiredToContinue;
  String get tapToPreviewYourCertificate => _localizedValues.tapToPreviewYourCertificate;
  String get certificatePreview => _localizedValues.certificatePreview;
  String get pdfPrintReadyIncludesNameAchievement => _localizedValues.pdfPrintReadyIncludesNameAchievement;
  String get ministryOfElectronicsItHindi => _localizedValues.ministryOfElectronicsItHindi;
  String get ministryOfElectronicsItEnglish => _localizedValues.ministryOfElectronicsItEnglish;
  String get digitalIndia => _localizedValues.digitalIndia;
  String get bhashiniHindi => _localizedValues.bhashiniHindi;
  String get bhashiniEnglish => _localizedValues.bhashiniEnglish;
  String get certificate => _localizedValues.certificate;
  String get ofAppreciation => _localizedValues.ofAppreciation;
  String get proudlyPresentedTo => _localizedValues.proudlyPresentedTo;
  String get viewProfile => _localizedValues.viewProfile;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'ml'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
