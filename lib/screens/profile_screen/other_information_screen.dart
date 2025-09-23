import 'package:bhashadaan/common_widgets/custom_app_bar.dart';
import 'package:bhashadaan/common_widgets/primary_button_widget.dart';
import 'package:bhashadaan/common_widgets/searchable_bottom_sheet/searchable_boottosheet_content.dart';
import 'package:bhashadaan/constants/app_colors.dart';
import 'package:bhashadaan/screens/bolo_screen/bolo_get_started/bolo_get_started.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class OtherInformationScreen extends StatefulWidget {
  const OtherInformationScreen({super.key});

  @override
  State<OtherInformationScreen> createState() => _OtherInformationScreenState();
}

class _OtherInformationScreenState extends State<OtherInformationScreen> {
  String _country = 'India';
  String _state = 'Maharashtra';
  String? _district;
  String? _preferredLanguage;
  final GlobalKey _districtFieldKey = GlobalKey();
  bool _showDistrictError = false;
  final TextEditingController _districtController = TextEditingController();
  final TextEditingController _languageController = TextEditingController();

  final List<String> _countries = const ['India'];
  final List<String> _states = const ['Maharashtra'];
  final List<String> _districts = const [
    'Pune', 'Mumbai', 'Nashik', 'Nagpur', 'Thane', 'Aurangabad',
  ];
  final List<String> _languages = const [
    'English', 'Hindi', 'Marathi', 'Gujarati', 'Kannada', 'Telugu',
  ];

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
      builder: (bottomCtx) => SearchableBottomSheetContent(
        items: items,
        hasMore: false,
        initialQuery: '',
        defaultItem: defaultItem,
        onItemSelected: (value) {
          onPicked(value);
          Navigator.of(bottomCtx).pop();
        },
        parentContext: bottomCtx,
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Other Information',
                        style: GoogleFonts.notoSans(
                          color: AppColors.greys87,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 16.h),
                      // Country
                      GestureDetector(
                        onTap: () => _pickFromList(
                          items: _countries,
                          defaultItem: _country,
                          onPicked: (v) => setState(() => _country = v),
                        ),
                        child: InputDecorator(
                          decoration: InputDecoration(
                            labelText: 'Country',
                            labelStyle: GoogleFonts.notoSans(color: AppColors.greys60, fontSize: 14.sp),
                            border: _outline(AppColors.darkGrey),
                            enabledBorder: _outline(AppColors.darkGrey),
                            focusedBorder: _outline(AppColors.darkGrey),
                            contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.w),
                            suffixIcon: Icon(Icons.keyboard_arrow_down, color: AppColors.greys87, size: 20.w),
                          ),
                          child: Text(
                            _country,
                            style: GoogleFonts.notoSans(color: AppColors.greys87, fontSize: 14.sp, fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                      SizedBox(height: 16.h),
                      // State
                      GestureDetector(
                        onTap: () => _pickFromList(
                          items: _states,
                          defaultItem: _state,
                          onPicked: (v) => setState(() => _state = v),
                        ),
                        child: InputDecorator(
                          decoration: InputDecoration(
                            labelText: 'State',
                            labelStyle: GoogleFonts.notoSans(color: AppColors.greys60, fontSize: 14.sp),
                            border: _outline(AppColors.darkGrey),
                            enabledBorder: _outline(AppColors.darkGrey),
                            focusedBorder: _outline(AppColors.darkGrey),
                            contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.w),
                            suffixIcon: Icon(Icons.keyboard_arrow_down, color: AppColors.greys87, size: 20.w),
                          ),
                          child: Text(
                            _state,
                            style: GoogleFonts.notoSans(color: AppColors.greys87, fontSize: 14.sp, fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                      SizedBox(height: 16.h),
                      // District (required) as read-only TextField
                      KeyedSubtree(
                        key: _districtFieldKey,
                        child: TextFormField(
                          controller: _districtController,
                          readOnly: true,
                          onTap: () => _pickFromList(
                            items: _districts,
                            defaultItem: _district,
                            onPicked: (v) => setState(() {
                              _district = v;
                              _districtController.text = v;
                              _showDistrictError = false;
                            }),
                          ),
                          decoration: InputDecoration(
                            label: RichText(
                              text: TextSpan(children: [
                                TextSpan(text: '*', style: GoogleFonts.notoSans(color: AppColors.negativeLight, fontSize: 14.sp)),
                                TextSpan(text: 'District', style: GoogleFonts.notoSans(color: AppColors.greys60, fontSize: 14.sp)),
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
                      if (_showDistrictError && _district == null)
                        Padding(
                          padding: EdgeInsets.only(top: 6.w, left: 8.w),
                          child: Text(
                            'This field is required to continue.',
                            style: GoogleFonts.notoSans(
                              color: AppColors.negativeLight,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      SizedBox(height: 16.h),
                      // Preferred Language as read-only TextField
                      TextFormField(
                        controller: _languageController,
                        readOnly: true,
                        onTap: () => _pickFromList(
                          items: _languages,
                          defaultItem: _preferredLanguage,
                          onPicked: (v) => setState(() {
                            _preferredLanguage = v;
                            _languageController.text = v;
                          }),
                        ),
                        decoration: InputDecoration(
                          labelText: 'Preferrered Language',
                          labelStyle: GoogleFonts.notoSans(color: AppColors.greys60, fontSize: 14.sp),
                          border: _outline(AppColors.darkGrey),
                          enabledBorder: _outline(AppColors.darkGrey),
                          focusedBorder: _outline(AppColors.darkGrey),
                          suffixIcon: Icon(Icons.keyboard_arrow_down, color: AppColors.greys87, size: 20.w),
                          contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.w),
                        ),
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
                            if (_district == null) {
                              setState(() => _showDistrictError = true);
                              final ctx = _districtFieldKey.currentContext;
                              if (ctx != null) {
                                Future.microtask(() => Scrollable.ensureVisible(
                                      ctx,
                                      duration: const Duration(milliseconds: 250),
                                      alignment: 0.1,
                                    ));
                              }
                              return;
                            }
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (_) => const BoloGetStarted(),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
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


