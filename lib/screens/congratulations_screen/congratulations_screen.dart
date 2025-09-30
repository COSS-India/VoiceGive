import 'package:bhashadaan/common_widgets/branding_alignment_widget.dart';
import 'package:bhashadaan/common_widgets/custom_app_bar.dart';
import 'package:bhashadaan/common_widgets/image_widget.dart';
import 'package:bhashadaan/common_widgets/primary_button_widget.dart';
import 'package:bhashadaan/constants/app_colors.dart';
import 'package:bhashadaan/screens/bolo_india/bolo_contribute/bolo_contribute.dart';
import 'package:bhashadaan/screens/bolo_india/bolo_validation_screen/bolo_validation_screen.dart';
import 'package:bhashadaan/screens/home_screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CongratulationsScreen extends StatefulWidget {
  const CongratulationsScreen({
    super.key,
  });

  @override
  State<CongratulationsScreen> createState() => _CongratulationsScreenState();
}

class _CongratulationsScreenState extends State<CongratulationsScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.elasticOut,
    ));
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<bool> _navigateBackToHome() async {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const HomeScreen()),
    );
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          return;
        }
        _navigateBackToHome();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              // Header Section
              Container(
                padding: EdgeInsets.all(16).r,
                decoration: BoxDecoration(color: AppColors.orange),
                child: Row(
                  children: [
                    InkWell(
                      onTap: _navigateBackToHome,
                      child: Icon(
                        Icons.arrow_circle_left_outlined,
                        color: Colors.white,
                        size: 36.sp,
                      ),
                    ),
                    SizedBox(width: 24.w),
                    ImageWidget(
                      height: 40.w,
                      width: 40.w,
                      imageUrl: "assets/images/bolo_icon_white.svg",
                    ),
                    SizedBox(width: 8.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.boloIndia,
                          style: GoogleFonts.notoSans(
                            color: Colors.white,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          AppLocalizations.of(context)!
                              .enrichYourLanguageByDonatingVoice,
                          style: GoogleFonts.notoSans(
                            color: Colors.white,
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Content Section
              Padding(
                padding: const EdgeInsets.all(16.0).r,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Congratulations Section
                    _buildCongratulationsSection(),
                    SizedBox(height: 32.w),
                    // Certificate Preview
                    _buildCertificatePreview(),
                    SizedBox(height: 24.w),
                    // Download Certificate Button
                    _buildDownloadButton(),
                    SizedBox(height: 16.w),
                    // Certificate Details
                    _buildCertificateDetails(),
                    SizedBox(height: 32.w),
                    // Action Buttons
                    _buildActionButtons(),
                    // Add extra bottom padding to ensure buttons are above navigation bar
                    SizedBox(
                        height: MediaQuery.of(context).padding.bottom + 20.w),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCongratulationsSection() {
    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Column(
            children: [
              // Badge
              ImageWidget(
                height: 120.w,
                width: 120.w,
                imageUrl: 'assets/images/bolo_logo.png',
                boxFit: BoxFit.contain,
              ),
              SizedBox(height: 24.w),
              // Congratulations Text
              Text(
                '${AppLocalizations.of(context)!.congratulations}!',
                style: GoogleFonts.notoSans(
                  fontSize: 28.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16.w),
              // Achievement Text
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: GoogleFonts.notoSans(
                    fontSize: 16.sp,
                    color: Colors.black87,
                    height: 1.4,
                  ),
                  children: [
                    const TextSpan(text: "You've "),
                    TextSpan(
                      text: "contributed 5 sentences",
                      style: GoogleFonts.notoSans(
                        color: AppColors.darkGreen,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const TextSpan(text: " and "),
                    TextSpan(
                      text: "validated 25",
                      style: GoogleFonts.notoSans(
                        color: AppColors.darkGreen,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const TextSpan(text: " in your language"),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCertificatePreview() {
    return GestureDetector(
      onTap: () {
        _showCertificatePreview();
      },
      child: Container(
        width: double.infinity,
        height: 200.w,
        padding: EdgeInsets.symmetric(vertical: 12).r,
        decoration: BoxDecoration(
          color: AppColors.lightGreen3,
          borderRadius: BorderRadius.circular(12).r,
          border: Border.all(color: Colors.grey.shade300, width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.2),
              spreadRadius: 2,
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            // Certificate Header
            Text(
              AppLocalizations.of(context)!.tapToPreviewCertificate,
              style: GoogleFonts.notoSans(
                  color: AppColors.greys,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500),
            ),
            // Certificate Preview Content (Blurred)
            Expanded(
              child: Container(
                padding: EdgeInsets.all(12).r,
                child: ClipRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.9),
                        borderRadius: BorderRadius.circular(8).r,
                        border:
                            Border.all(color: AppColors.darkGreen, width: 2),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8).r,
                        child: Image.asset(
                          'assets/images/certificate.jpg',
                          fit: BoxFit.contain,
                        ),
                      ),
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

  Widget _buildDownloadButton() {
    return SizedBox(
      height: 48.w,
      child: IntrinsicWidth(
        child: PrimaryButtonWidget(
          title: AppLocalizations.of(context)!.downloadCertificate,
          textFontSize: 16.sp,
          horizontalPadding: 32.r,
          fontWeight: FontWeight.w600,
          onTap: () {
            // Download certificate as PDF
            // _downloadCertificate();
          },
          textColor: AppColors.appBarBackground,
          decoration: BoxDecoration(
            color: AppColors.darkGreen,
            borderRadius: BorderRadius.circular(8).r,
            boxShadow: [
              BoxShadow(
                color: AppColors.darkGreen.withValues(alpha: 0.3),
                spreadRadius: 2,
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCertificateDetails() {
    return Column(
      children: [
        Text(
          "PDF (print-ready, includes your name & achievement)",
          style: GoogleFonts.notoSans(
              fontSize: 10.sp,
              fontWeight: FontWeight.w400,
              color: AppColors.disabledTextGrey),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 2.w),
        Text(
          "Issued on: 17 Sep 2025. Certificate ID: DIC-20250917-0123",
          style: GoogleFonts.notoSans(
              fontSize: 10.sp,
              fontWeight: FontWeight.w400,
              color: AppColors.disabledTextGrey),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 40.w,
            child: PrimaryButtonWidget(
              title: AppLocalizations.of(context)!.validateMore,
              textFontSize: 14.sp,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => BoloValidationScreen()),
                );
              },
              textColor: AppColors.orange,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: AppColors.orange, width: 1.5),
                borderRadius: BorderRadius.circular(6).r,
              ),
            ),
          ),
        ),
        SizedBox(width: 16.w),
        Expanded(
          child: SizedBox(
            height: 40.w,
            child: PrimaryButtonWidget(
              title: AppLocalizations.of(context)!.contributeMore,
              textFontSize: 14.sp,
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => BoloContribute()),
                );
              },
              textColor: Colors.white,
              decoration: BoxDecoration(
                color: AppColors.orange,
                border: Border.all(color: AppColors.orange, width: 1.5),
                borderRadius: BorderRadius.circular(6).r,
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _showCertificatePreview() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.8,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12).r,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.3),
                  spreadRadius: 5,
                  blurRadius: 15,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              children: [
                // Header
                Container(
                  padding: EdgeInsets.all(16).r,
                  decoration: BoxDecoration(
                    color: AppColors.orange,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12).r,
                      topRight: Radius.circular(12).r,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Certificate Preview",
                        style: GoogleFonts.notoSans(
                          color: Colors.white,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      IconButton(
                        onPressed: () => Navigator.of(context).pop(),
                        icon: Icon(
                          Icons.close,
                          color: Colors.white,
                          size: 24.sp,
                        ),
                      ),
                    ],
                  ),
                ),
                // Certificate Content
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(24).r,
                    child: _buildFullCertificate(),
                  ),
                ),
                // Download Button
                Padding(
                  padding: EdgeInsets.all(16).r,
                  child: SizedBox(
                    width: double.infinity,
                    height: 48.w,
                    child: PrimaryButtonWidget(
                      title: AppLocalizations.of(context)!.downloadPdf,
                      textFontSize: 16.sp,
                      onTap: () {
                        Navigator.of(context).pop();
                        //  _downloadCertificate();
                      },
                      textColor: Colors.white,
                      decoration: BoxDecoration(
                        color: AppColors.darkGreen,
                        borderRadius: BorderRadius.circular(8).r,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildFullCertificate() {
    return Container(
      padding: EdgeInsets.all(32).r,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300, width: 2),
        borderRadius: BorderRadius.circular(8).r,
      ),
      child: Column(
        children: [
          // Government Logo and Ministry
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "इलेक्ट्रॉनिकी एवं सूचना प्रौद्योगिकी मंत्रालय",
                      style: GoogleFonts.notoSans(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4.w),
                    Text(
                      "MINISTRY OF ELECTRONICS AND INFORMATION TECHNOLOGY",
                      style: GoogleFonts.notoSans(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[600],
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 8.w),
                    Text(
                      "Digital India",
                      style: GoogleFonts.notoSans(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.orange,
                      ),
                    ),
                  ],
                ),
              ),
              // BHASHINI Logo
              Flexible(
                flex: 1,
                child: Container(
                  padding: EdgeInsets.all(8).r,
                  decoration: BoxDecoration(
                    color: AppColors.lightGreen3,
                    borderRadius: BorderRadius.circular(8).r,
                  ),
                  child: Column(
                    children: [
                      Text(
                        "BHASHINI",
                        style: GoogleFonts.notoSans(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                          color: AppColors.darkGreen,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        "भाषिणी",
                        style: GoogleFonts.notoSans(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.orange,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 32.w),

          // Certificate Title
          Text(
            "CERTIFICATE",
            style: GoogleFonts.notoSans(
              fontSize: 28.sp,
              fontWeight: FontWeight.w700,
              color: Colors.black87,
            ),
          ),
          Text(
            "OF APPRECIATION",
            style: GoogleFonts.notoSans(
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.orange,
            ),
          ),
          SizedBox(height: 24.w),

          // Presentation Text
          Text(
            "PROUDLY PRESENTED TO",
            style: GoogleFonts.notoSans(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 16.w),

          // Recipient Name
          Text(
            "Animesh Patil",
            style: GoogleFonts.notoSans(
              fontSize: 24.sp,
              fontWeight: FontWeight.w700,
              color: Colors.black87,
              letterSpacing: 1.2,
            ),
          ),
          SizedBox(height: 16.w),

          // Decorative Line
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 2.w,
                  color: Colors.amber[600],
                ),
              ),
              Container(
                width: 12.w,
                height: 12.w,
                decoration: BoxDecoration(
                  color: Colors.amber[600],
                  shape: BoxShape.circle,
                ),
              ),
              Expanded(
                child: Container(
                  height: 2.w,
                  color: Colors.amber[600],
                ),
              ),
            ],
          ),
          SizedBox(height: 16.w),

          // Recognition Text
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: GoogleFonts.notoSans(
                fontSize: 14.sp,
                color: Colors.black87,
              ),
              children: [
                const TextSpan(text: "Recognized as a "),
                TextSpan(
                  text: "Agri Bhasha Samarthak",
                  style: GoogleFonts.notoSans(
                    color: AppColors.darkGreen,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 24.w),

          // Description
          Column(
            children: [
              Text(
                "For contributing to",
                style: GoogleFonts.notoSans(
                  fontSize: 12.sp,
                  color: Colors.black87,
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8.w),
              BrandingAlignmentWidget(
                fontSize: 12.sp,
                textColor: Colors.black87,
              ),
              SizedBox(height: 8.w),
              Text(
                "strengthening agricultural knowledge in Indian languages and advancing the vision of an inclusive, self-reliant Bharat.",
                style: GoogleFonts.notoSans(
                  fontSize: 12.sp,
                  color: Colors.black87,
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          SizedBox(height: 32.w),

          // Signatory
          Text(
            "CEO, BHASHINI",
            style: GoogleFonts.notoSans(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          Container(
            width: 100.w,
            height: 2.w,
            color: Colors.amber[600],
          ),
        ],
      ),
    );
  }
}
