import 'package:bhashadaan/common_widgets/custom_app_bar.dart';
import 'package:bhashadaan/common_widgets/primary_button_widget.dart';
import 'package:bhashadaan/common_widgets/searchable_bottom_sheet/searchable_boottosheet_content.dart';
import 'package:bhashadaan/constants/app_colors.dart';
import 'package:bhashadaan/l10n/app_localizations.dart';
import 'package:bhashadaan/screens/auth/otp_login/otp_verification_screen.dart';
import 'package:bhashadaan/screens/home_screen/home_screen.dart';
import 'package:bhashadaan/screens/profile_screen/other_information_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileScreen extends StatefulWidget {
  final String? phoneNumber;

  const ProfileScreen({super.key, this.phoneNumber});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey _ageFieldKey = GlobalKey();
  final GlobalKey _genderFieldKey = GlobalKey();

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();

  String? _selectedAgeGroup;
  String? _selectedGender;

  List<String> _ageGroups = [];
  List<String> _genders = [];

  @override
  void initState() {
    super.initState();
  }

  void _initializeLocalizedStrings() {
    final l10n = AppLocalizations.of(context)!;
    _ageGroups = [
      l10n.under18Years,
      l10n.age18To24,
      l10n.age25To34,
      l10n.age35To44,
      l10n.age45To54,
      l10n.age55To64,
      l10n.age65Plus,
    ];
    _genders = [
      l10n.male,
      l10n.female,
      l10n.nonBinary,
      l10n.preferNotToSay,
    ];
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _ageController.dispose();
    _genderController.dispose();
    super.dispose();
  }

  Future<void> _pickFromList({
    required List<String> items,
    required ValueChanged<String> onPicked,
    String? defaultItem,
  }) async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
      ),
      builder: (bottomSheetContext) => SearchableBottomSheetContent(
        items: items,
        hasMore: false,
        initialQuery: '',
        defaultItem: defaultItem,
        onItemSelected: (value) {
          onPicked(value);
          Navigator.of(bottomSheetContext).pop();
        },
        parentContext: bottomSheetContext,
      ),
    );
  }

  InputBorder _outline(Color color) => OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.r),
        borderSide: BorderSide(color: color),
      );

  Future<bool> _navigateBackToOtp() async {
    if (widget.phoneNumber != null && !widget.phoneNumber!.contains('@')) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => OtpVerificationScreen(phoneNumber: widget.phoneNumber!),
        ),
      );
    } else {
      // If no phone number or email, go to home screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        ),
      );
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    // Initialize localized strings if not already done
    if (_ageGroups.isEmpty) {
      _initializeLocalizedStrings();
    }
    
    return WillPopScope(
      onWillPop: _navigateBackToOtp,
      child: Scaffold(
        appBar: const CustomAppBar(),
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            children: [
              // Full-width orange header outside content padding
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 14.w, horizontal: 16.w),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColors.orange, AppColors.saffron],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: InkWell(
                        onTap: _navigateBackToOtp,
                        child: Icon(Icons.arrow_back, color: Colors.white, size: 20.sp),
                      ),
                    ),
                    Text(
                      AppLocalizations.of(context)!.completeYourProfile,
                      style: GoogleFonts.notoSans(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(24.w),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 16.h),
                          Text(
                            AppLocalizations.of(context)!.personalInformation,
                            style: GoogleFonts.notoSans(
                              color: AppColors.greys87,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(height: 16.h),
                          // First name
                          TextFormField(
                            controller: _firstNameController,
                            decoration: InputDecoration(
                              label: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: '*',
                                      style: GoogleFonts.notoSans(
                                        color: AppColors.negativeLight,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    TextSpan(
                                      text: AppLocalizations.of(context)!.firstName,
                                      style: GoogleFonts.notoSans(
                                        color: AppColors.greys60,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              enabledBorder: _outline(AppColors.darkGrey),
                              focusedBorder: _outline(AppColors.darkGrey),
                              errorBorder: _outline(AppColors.negativeLight),
                              focusedErrorBorder: _outline(AppColors.negativeLight),
                              contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.w),
                            ),
                            validator: (v) => (v == null || v.trim().isEmpty) ? AppLocalizations.of(context)!.firstNameRequired : null,
                            style: GoogleFonts.notoSans(color: AppColors.greys87, fontSize: 14.sp, fontWeight: FontWeight.w500),
                          ),
                          SizedBox(height: 16.h),
                          // Last name
                          TextFormField(
                            controller: _lastNameController,
                            decoration: InputDecoration(
                              label: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: '*',
                                      style: GoogleFonts.notoSans(
                                        color: AppColors.negativeLight,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    TextSpan(
                                      text: AppLocalizations.of(context)!.lastName,
                                      style: GoogleFonts.notoSans(
                                        color: AppColors.greys60,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              enabledBorder: _outline(AppColors.darkGrey),
                              focusedBorder: _outline(AppColors.darkGrey),
                              errorBorder: _outline(AppColors.negativeLight),
                              focusedErrorBorder: _outline(AppColors.negativeLight),
                              contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.w),
                            ),
                            validator: (v) => (v == null || v.trim().isEmpty) ? AppLocalizations.of(context)!.lastNameRequired : null,
                            style: GoogleFonts.notoSans(color: AppColors.greys87, fontSize: 14.sp, fontWeight: FontWeight.w500),
                          ),
                          SizedBox(height: 16.h),
                          // Age group picker (read-only TextField with in-box label)
                          KeyedSubtree(
                            key: _ageFieldKey,
                            child: TextFormField(
                              controller: _ageController,
                              readOnly: true,
                              onTap: () => _pickFromList(
                                items: _ageGroups,
                                defaultItem: _selectedAgeGroup,
                                onPicked: (value) {
                                  setState(() {
                                    _selectedAgeGroup = value;
                                    _ageController.text = value;
                                  });
                                  final ctx = _ageFieldKey.currentContext;
                                  if (ctx != null) {
                                    Future.microtask(() => Scrollable.ensureVisible(
                                          ctx,
                                          duration: const Duration(milliseconds: 250),
                                          alignment: 0.1,
                                        ));
                                  }
                                },
                              ),
                              decoration: InputDecoration(
                                label: RichText(
                                  text: TextSpan(children: [
                                    TextSpan(
                                      text: '*',
                                      style: GoogleFonts.notoSans(color: AppColors.negativeLight, fontSize: 14.sp),
                                    ),
                                    TextSpan(
                                      text: AppLocalizations.of(context)!.chooseYourAgeGroup,
                                      style: GoogleFonts.notoSans(color: AppColors.greys60, fontSize: 14.sp),
                                    ),
                                  ]),
                                ),
                                border: _outline(AppColors.darkGrey),
                                enabledBorder: _outline(AppColors.darkGrey),
                                focusedBorder: _outline(AppColors.darkGrey),
                                suffixIcon: Icon(Icons.keyboard_arrow_down, color: AppColors.greys87, size: 20.w),
                                contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.w),
                              ),
                              style: GoogleFonts.notoSans(color: AppColors.greys87, fontSize: 14.sp, fontWeight: FontWeight.w500),
                            ),
                          ),
                          SizedBox(height: 16.h),
                          // Gender picker (read-only TextField with in-box label)
                          KeyedSubtree(
                            key: _genderFieldKey,
                            child: TextFormField(
                              controller: _genderController,
                              readOnly: true,
                              onTap: () => _pickFromList(
                                items: _genders,
                                defaultItem: _selectedGender,
                                onPicked: (value) {
                                  setState(() {
                                    _selectedGender = value;
                                    _genderController.text = value;
                                  });
                                  final ctx = _genderFieldKey.currentContext;
                                  if (ctx != null) {
                                    Future.microtask(() => Scrollable.ensureVisible(
                                          ctx,
                                          duration: const Duration(milliseconds: 250),
                                          alignment: 0.1,
                                        ));
                                  }
                                },
                              ),
                              decoration: InputDecoration(
                                label: RichText(
                                  text: TextSpan(children: [
                                    TextSpan(
                                      text: '*',
                                      style: GoogleFonts.notoSans(color: AppColors.negativeLight, fontSize: 14.sp),
                                    ),
                                    TextSpan(
                                      text: AppLocalizations.of(context)!.gender,
                                      style: GoogleFonts.notoSans(color: AppColors.greys60, fontSize: 14.sp),
                                    ),
                                  ]),
                                ),
                                border: _outline(AppColors.darkGrey),
                                enabledBorder: _outline(AppColors.darkGrey),
                                focusedBorder: _outline(AppColors.darkGrey),
                                suffixIcon: Icon(Icons.keyboard_arrow_down, color: AppColors.greys87, size: 20.w),
                                contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.w),
                              ),
                              style: GoogleFonts.notoSans(color: AppColors.greys87, fontSize: 14.sp, fontWeight: FontWeight.w500),
                            ),
                          ),
                          SizedBox(height: 16.h),
                          // Phone number (read-only) - only show if phone number is provided and not an email
                          if (widget.phoneNumber != null && !widget.phoneNumber!.contains('@'))
                            TextFormField(
                              initialValue: '+91 ${widget.phoneNumber}',
                              readOnly: true,
                              decoration: InputDecoration(
                                enabled: false,
                                enabledBorder: _outline(AppColors.darkGrey),
                                disabledBorder: _outline(AppColors.darkGrey),
                                contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.w),
                              ),
                              style: GoogleFonts.notoSans(color: AppColors.darkGreen, fontSize: 14.sp, fontWeight: FontWeight.w600),
                            ),
                          SizedBox(height: 16.h),
                          // Email
                          TextFormField(
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              labelText: AppLocalizations.of(context)!.emailId,
                              labelStyle: GoogleFonts.notoSans(color: AppColors.greys60, fontSize: 14.sp),
                              enabledBorder: _outline(AppColors.darkGrey),
                              focusedBorder: _outline(AppColors.darkGrey),
                              errorBorder: _outline(AppColors.negativeLight),
                              focusedErrorBorder: _outline(AppColors.negativeLight),
                              contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.w),
                            ),
                            // No strict validation required; accept any value (dummy emails)
                            validator: (v) => null,
                            style: GoogleFonts.notoSans(color: AppColors.greys87, fontSize: 14.sp, fontWeight: FontWeight.w500),
                          ),
                          SizedBox(height: 32.h),
                          SizedBox(
                            width: double.infinity,
                            child: PrimaryButtonWidget(
                              title: AppLocalizations.of(context)!.saveAndContinue,
                              textColor: Colors.white,
                              decoration: BoxDecoration(
                                color: AppColors.orange,
                                borderRadius: BorderRadius.circular(6.r),
                              ),
                              verticalPadding: 14.w,
                              onTap: () {
                                final valid = _formKey.currentState?.validate() ?? false;
                                final selectionsValid = _ageController.text.isNotEmpty && _genderController.text.isNotEmpty;
                                setState(() {});
                                if (valid && selectionsValid) {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (_) => const OtherInformationScreen(),
                                    ),
                                  );
                                } else if (!selectionsValid) {
                                  // Do not change border color; just show inline message
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(AppLocalizations.of(context)!.pleaseSelectAgeGroupAndGender)),
                                  );
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


