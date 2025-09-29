import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/app_colors.dart';
import '../l10n/app_localizations.dart';

class InformedConsentModal extends StatefulWidget {
  final VoidCallback onApprove;
  final VoidCallback onDeny;

  const InformedConsentModal({
    super.key,
    required this.onApprove,
    required this.onDeny,
  });

  @override
  State<InformedConsentModal> createState() => _InformedConsentModalState();
}

class _InformedConsentModalState extends State<InformedConsentModal> {
  bool _termsAccepted = false;
  bool _privacyAccepted = false;
  bool _copyrightAccepted = false;

  bool get _allAccepted =>
      _termsAccepted && _privacyAccepted && _copyrightAccepted;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.85,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Column(
          children: [
            // Header
            Container(
              padding: EdgeInsets.fromLTRB(16.w, 24.w, 16.w, 20.w),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: widget.onDeny,
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                      size: 20.w,
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        "We Respect Your Privacy",
                        style: GoogleFonts.notoSans(
                          color: AppColors.darkGreen,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 20.w), // To balance the back button
                ],
              ),
            ),

            // Fixed Content
            Padding(
              padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Greeting
                  Row(
                    children: [
                      Text(
                        AppLocalizations.of(context).namasteContributor,
                        style: GoogleFonts.notoSans(
                          color: Colors.black,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        "🙏",
                        style: TextStyle(fontSize: 16.sp),
                      ),
                    ],
                  ),
                  SizedBox(height: 12.w),

                  // Introduction paragraph
                  Text(
                    AppLocalizations.of(context).consentMessage,
                    style: GoogleFonts.notoSans(
                      color: Colors.black,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      height: 1.4,
                    ),
                  ),
                  SizedBox(height: 20.w),
                ],
              ),
            ),

            // Scrollable Content - Only the green container
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      AppColors.lightGreen2,
                      Colors.white,
                    ],
                  ),
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  padding: EdgeInsets.all(16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "By clicking \"${AppLocalizations.of(context).iAgree}\", you confirm that:",
                        style: GoogleFonts.notoSans(
                          color: Colors.black,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 16.w),

                      // Numbered list
                      _buildNumberedItem(
                        "1.",
                        "are authorized to contribute and validate data provided by [Organisation/ Department/ DIBD], and acknowledge that the submission of personal information is voluntary and provided with your full consent.",
                      ),
                      SizedBox(height: 12.w),

                      _buildNumberedItem(
                        "2.",
                        "You grant DIBD a perpetual, royalty-free, irrevocable license to use submitted data for training, research, validation, model development, and open datasets within the BHASHINI ecosystem.",
                      ),
                      SizedBox(height: 12.w),

                      _buildNumberedItem(
                        "3.",
                        "Except for personal information, submitted data is non-confidential, free of third-party restrictions, and cleared for public use.",
                      ),
                      SizedBox(height: 12.w),

                      _buildNumberedItem(
                        "4.",
                        "You waive any claim to ownership, compensation, or restriction on use of submitted data.",
                      ),
                      SizedBox(height: 12.w),

                      _buildNumberedItem(
                        "5.",
                        "You have read, understood, and accepted the following governing documents on the BhashaDaan portal:",
                      ),
                      SizedBox(height: 16.w),

                      // Checkboxes for documents
                      _buildCheckboxItem(
                        "Terms of Use/ Contribution Terms",
                        _termsAccepted,
                        (value) => setState(() => _termsAccepted = value!),
                      ),
                      SizedBox(height: 8.w),

                      _buildCheckboxItem(
                        "Privacy Policy",
                        _privacyAccepted,
                        (value) => setState(() => _privacyAccepted = value!),
                      ),
                      SizedBox(height: 8.w),

                      _buildCheckboxItem(
                        "Copyright & Licensing Policy",
                        _copyrightAccepted,
                        (value) => setState(() => _copyrightAccepted = value!),
                      ),
                      SizedBox(height: 40.h),
                    ],
                  ),
                ),
              ),
            ),

            // Action buttons
            Container(
              padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 16.w),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: widget.onDeny,
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 14.w),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8.r),
                          border: Border.all(color: AppColors.lightGrey),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.close,
                              color: AppColors.grey84,
                              size: 18.w,
                            ),
                            SizedBox(width: 8.w),
                            Text(
                              "Deny",
                              style: GoogleFonts.notoSans(
                                color: AppColors.grey84,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 20.h),
                  Expanded(
                    child: GestureDetector(
                      onTap: _allAccepted ? widget.onApprove : null,
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 14.w),
                        decoration: BoxDecoration(
                          color: _allAccepted
                              ? AppColors.orange
                              : AppColors.lightGrey,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.check,
                              color: _allAccepted
                                  ? Colors.white
                                  : AppColors.grey84,
                              size: 18.w,
                            ),
                            SizedBox(width: 8.w),
                            Text(
                              AppLocalizations.of(context).iAgree,
                              style: GoogleFonts.notoSans(
                                color: _allAccepted
                                    ? Colors.white
                                    : AppColors.grey84,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
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
          ],
        ),
      ),
    );
  }

  Widget _buildNumberedItem(String number, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          number,
          style: GoogleFonts.notoSans(
            color: Colors.black,
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(width: 8.w),
        Expanded(
          child: Text(
            text,
            style: GoogleFonts.notoSans(
              color: Colors.black,
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              height: 1.4,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCheckboxItem(
      String text, bool value, ValueChanged<bool?> onChanged) {
    return InkWell(
      onTap: () => onChanged(!value),
      borderRadius: BorderRadius.circular(4),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: value ? AppColors.darkGreen : AppColors.lightBackground,
                border: Border.all(
                  color: AppColors.darkGreen,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(4),
              ),
              child: value
                  ? const Icon(
                      Icons.check,
                      size: 16,
                      color: Colors.white,
                    )
                  : null,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                text,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF047857),
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
