import 'package:bhashadaan/common_widgets/custom_app_bar.dart';
import 'package:bhashadaan/common_widgets/primary_button_widget.dart';
import 'package:bhashadaan/common_widgets/searchable_bottom_sheet/searchable_boottosheet_content.dart';
import 'package:bhashadaan/constants/app_colors.dart';
import 'package:bhashadaan/screens/profile_screen/other_information_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileScreen extends StatefulWidget {
  final String phoneNumber;

  const ProfileScreen({super.key, required this.phoneNumber});

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

  final List<String> _ageGroups = const [
    'Under 18 years', '18-24 years', '25-34 years', '35-44 years', '45-54 years', '55-64 years', '65+ years',
  ];

  final List<String> _genders = const [
    'Male', 'Female', 'Non-binary', 'Prefer not to say',
  ];

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      onTap: () => Navigator.pop(context),
                      child: Icon(Icons.arrow_back, color: Colors.white, size: 20.sp),
                    ),
                  ),
                  Text(
                    'Complete your profile',
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
                    'Personal Information',
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
                              text: 'First Name',
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
                    validator: (v) => (v == null || v.trim().isEmpty) ? 'First name is required' : null,
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
                              text: 'Last Name',
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
                    validator: (v) => (v == null || v.trim().isEmpty) ? 'Last name is required' : null,
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
                              text: 'choose your age group',
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
                              text: 'Gender',
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
                  // Phone number (read-only)
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
                      labelText: 'Email ID',
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
                      title: 'Save & Continue',
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
                            SnackBar(content: Text('Please select age group and gender')),
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
    );
  }
}


