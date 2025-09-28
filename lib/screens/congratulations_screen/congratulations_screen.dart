import 'package:bhashadaan/common_widgets/custom_app_bar.dart';
import 'package:bhashadaan/common_widgets/image_widget.dart';
import 'package:bhashadaan/common_widgets/primary_button_widget.dart';
import 'package:bhashadaan/constants/app_colors.dart';
import 'package:bhashadaan/l10n/app_localizations.dart';
import 'package:bhashadaan/screens/home_screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui';

class CongratulationsScreen extends StatefulWidget {
  final String recordedText;
  final String selectedLanguage;
  final int currentIndex;
  final int totalItems;

  const CongratulationsScreen({
    super.key,
    required this.recordedText,
    required this.selectedLanguage,
    required this.currentIndex,
    required this.totalItems,
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
    return WillPopScope(
      onWillPop: _navigateBackToHome,
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
                          "BOLO India",
                          style: GoogleFonts.notoSans(
                            color: Colors.white,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "Enrich your language by donating your voice.",
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
              Container(
                width: 120.w,
                height: 120.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.darkGreen.withValues(alpha: 0.3),
                      spreadRadius: 4,
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ClipOval(
                  child: Container(
                    height: 120.w,
                    width: 120.w,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                    ),
                    child: ImageWidget(
                      height: 120.w,
                      width: 120.w,
                      imageUrl: "assets/images/logo.svg",
                      boxFit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 24.w),
              // Congratulations Text
              Text(
                "Congratulations!",
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
                    const TextSpan(text: "You've contributed "),
                    TextSpan(
                      text: "5 sentences",
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
        decoration: BoxDecoration(
          color: Colors.white,
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
            Container(
              padding: EdgeInsets.all(12).r,
              decoration: BoxDecoration(
                color: AppColors.lightGreen3,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12).r,
                  topRight: Radius.circular(12).r,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.visibility,
                    color: AppColors.darkGreen,
                    size: 16.sp,
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    "Tap to preview your certificate",
                    style: GoogleFonts.notoSans(
                      color: AppColors.darkGreen,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
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
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Government Ministry Header
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("🏛️",
                                          style: TextStyle(fontSize: 12.sp)),
                                      Text(
                                        "इलेक्ट्रॉनिकी एवं सूचना प्रौद्योगिकी मंत्रालय",
                                        style: GoogleFonts.notoSans(
                                          fontSize: 6.sp,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black87,
                                        ),
                                      ),
                                      Text(
                                        "MINISTRY OF ELECTRONICS AND INFORMATION TECHNOLOGY",
                                        style: GoogleFonts.notoSans(
                                          fontSize: 4.sp,
                                          color: Colors.grey[600],
                                        ),
                                      ),
                                      Text(
                                        "Digital India",
                                        style: GoogleFonts.notoSans(
                                          fontSize: 5.sp,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.orange,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(6).r,
                                  decoration: BoxDecoration(
                                    color: AppColors.lightGreen3,
                                    borderRadius: BorderRadius.circular(4).r,
                                    border: Border.all(
                                        color: AppColors.darkGreen, width: 1),
                                  ),
                                  child: Column(
                                    children: [
                                      Text("🌿",
                                          style: TextStyle(fontSize: 8.sp)),
                                      Text(
                                        "BHASHINI",
                                        style: GoogleFonts.notoSans(
                                          fontSize: 6.sp,
                                          fontWeight: FontWeight.w700,
                                          color: AppColors.darkGreen,
                                        ),
                                      ),
                                      Text(
                                        "भाषिणी",
                                        style: GoogleFonts.notoSans(
                                          fontSize: 4.sp,
                                          color: AppColors.orange,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 12.w),
                            // Certificate Title
                            Text(
                              "CERTIFICATE",
                              style: GoogleFonts.notoSans(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w700,
                                color: Colors.black87,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              "OF APPRECIATION",
                              style: GoogleFonts.notoSans(
                                fontSize: 8.sp,
                                fontWeight: FontWeight.w600,
                                color: AppColors.orange,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 8.w),
                            Text(
                              "PROUDLY PRESENTED TO",
                              style: GoogleFonts.notoSans(
                                fontSize: 6.sp,
                                color: Colors.black87,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 6.w),
                            Text(
                              "Animesh Patil",
                              style: GoogleFonts.notoSans(
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w700,
                                color: Colors.black87,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 6.w),
                            // Golden line with circles
                            Row(
                              children: [
                                Expanded(
                                    child: Container(
                                        height: 1.5, color: Colors.amber[600])),
                                Container(
                                  width: 6.w,
                                  height: 6.w,
                                  decoration: BoxDecoration(
                                    color: Colors.amber[600],
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                SizedBox(width: 6.w),
                                Container(
                                  width: 6.w,
                                  height: 6.w,
                                  decoration: BoxDecoration(
                                    color: Colors.amber[600],
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                SizedBox(width: 6.w),
                                Expanded(
                                    child: Container(
                                        height: 1.5, color: Colors.amber[600])),
                              ],
                            ),
                            SizedBox(height: 6.w),
                            Text(
                              "Recognized as a Agri Bhasha Samarthak",
                              style: GoogleFonts.notoSans(
                                fontSize: 6.sp,
                                color: Colors.black87,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 8.w),
                            Text(
                              "For contributing to AgriDaan under BhashaDaan by BHASHINI, strengthening agricultural knowledge in Indian languages and advancing the vision of an inclusive, self-reliant Bharat.",
                              style: GoogleFonts.notoSans(
                                fontSize: 4.sp,
                                color: Colors.grey[600],
                                height: 1.2,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 12.w),
                            Text(
                              "CEO, BHASHINI",
                              style: GoogleFonts.notoSans(
                                fontSize: 6.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            Container(
                              width: 40.w,
                              height: 1.5,
                              color: Colors.amber[600],
                              margin: EdgeInsets.only(top: 3.w),
                            ),
                          ],
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
      width: double.infinity,
      height: 48.w,
      child: PrimaryButtonWidget(
        title: AppLocalizations.of(context).downloadCertificate,
        textFontSize: 16.sp,
        onTap: () {
          // Download certificate as PDF
          // _downloadCertificate();
        },
        textColor: Colors.white,
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
    );
  }

  Widget _buildCertificateDetails() {
    return Container(
      padding: EdgeInsets.all(12).r,
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(8).r,
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: [
          Text(
            "PDF (print-ready, includes your name & achievement)",
            style: GoogleFonts.notoSans(
              fontSize: 12.sp,
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 4.w),
          Text(
            "Issued on: 17 Sep 2025. Certificate ID: DIC-20250917-0123",
            style: GoogleFonts.notoSans(
              fontSize: 10.sp,
              color: Colors.grey[500],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 40.w,
            child: PrimaryButtonWidget(
              title: AppLocalizations.of(context).validateMore,
              textFontSize: 14.sp,
              onTap: () {
                // Navigate back to validation
                Navigator.of(context).pop();
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
              title: AppLocalizations.of(context).contributeMore,
              textFontSize: 14.sp,
              onTap: () {
                // Navigate back to home
                Navigator.of(context).popUntil((route) => route.isFirst);
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
                      title: AppLocalizations.of(context).downloadPdf,
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
          Text(
            "For contributing to AgriDaan under BhashaDaan by BHASHINI, strengthening agricultural knowledge in Indian languages and advancing the vision of an inclusive, self-reliant Bharat.",
            style: GoogleFonts.notoSans(
              fontSize: 12.sp,
              color: Colors.black87,
              height: 1.5,
            ),
            textAlign: TextAlign.center,
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

  // void _downloadCertificate() {
  //   // Create a simple HTML certificate and trigger download
  //   final certificateHtml = '''
  //   <!DOCTYPE html>
  //   <html>
  //   <head>
  //       <title>Certificate of Appreciation - Animesh Patil</title>
  //       <style>
  //           body {
  //               font-family: Arial, sans-serif;
  //               margin: 0;
  //               padding: 40px;`
  //               background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
  //           }
  //           .certificate {
  //               background: white;
  //               padding: 60px;
  //               border: 3px solid #2E7D32;
  //               border-radius: 15px;
  //               box-shadow: 0 10px 30px rgba(0,0,0,0.3);
  //               text-align: center;
  //               max-width: 800px;
  //               margin: 0 auto;
  //           }
  //           .header {
  //               display: flex;
  //               justify-content: space-between;
  //               align-items: center;
  //               margin-bottom: 40px;
  //           }
  //           .ministry {
  //               text-align: left;
  //           }
  //           .government-emblem {
  //               font-size: 24px;
  //               margin-bottom: 8px;
  //           }
  //           .ministry h3 {
  //               margin: 0;
  //               color: #333;
  //               font-size: 14px;
  //           }
  //           .ministry p {
  //               margin: 5px 0;
  //               color: #666;
  //               font-size: 12px;
  //           }
  //           .digital-india {
  //               color: #FF6B35;
  //               font-weight: bold;
  //               font-size: 16px;
  //           }
  //           .bhashini-logo {
  //               background: #E8F5E8;
  //               padding: 15px;
  //               border-radius: 10px;
  //               border: 2px solid #2E7D32;
  //               text-align: center;
  //           }
  //           .bhashini-icon {
  //               font-size: 20px;
  //               margin-bottom: 5px;
  //           }
  //           .bhashini-logo h2 {
  //               margin: 0;
  //               color: #2E7D32;
  //               font-size: 18px;
  //           }
  //           .bhashini-logo p {
  //               margin: 5px 0 0 0;
  //               color: #FF6B35;
  //               font-size: 14px;
  //           }
  //           .title {
  //               margin: 40px 0;
  //           }
  //           .title h1 {
  //               font-size: 36px;
  //               margin: 0;
  //               color: #333;
  //               letter-spacing: 2px;
  //           }
  //           .title h2 {
  //               font-size: 24px;
  //               margin: 10px 0 0 0;
  //               color: #FF6B35;
  //           }
  //           .presented {
  //               font-size: 16px;
  //               color: #333;
  //               margin: 30px 0;
  //           }
  //           .name {
  //               font-size: 32px;
  //               font-weight: bold;
  //               color: #333;
  //               margin: 20px 0;
  //               letter-spacing: 3px;
  //           }
  //           .line {
  //               display: flex;
  //               align-items: center;
  //               margin: 30px 0;
  //           }
  //           .line div {
  //               flex: 1;
  //               height: 3px;
  //               background: #FFD700;
  //           }
  //           .line span {
  //               width: 15px;
  //               height: 15px;
  //               background: #FFD700;
  //               border-radius: 50%;
  //               margin: 0 20px;
  //           }
  //           .recognition {
  //               font-size: 16px;
  //               color: #333;
  //               margin: 20px 0;
  //           }
  //           .recognition strong {
  //               color: #2E7D32;
  //           }
  //           .description {
  //               font-size: 14px;
  //               color: #555;
  //               line-height: 1.6;
  //               margin: 30px 0;
  //               text-align: center;
  //           }
  //           .signature {
  //               margin-top: 50px;
  //           }
  //           .signature p {
  //               font-size: 16px;
  //               font-weight: bold;
  //               color: #333;
  //               margin: 0;
  //           }
  //           .signature-line {
  //               width: 150px;
  //               height: 3px;
  //               background: #FFD700;
  //               margin: 10px auto;
  //           }
  //           .decorative-lines {
  //               position: absolute;
  //               bottom: 0;
  //               left: 0;
  //               right: 0;
  //               height: 60px;
  //               overflow: hidden;
  //               pointer-events: none;
  //           }
  //           .wave-left {
  //               position: absolute;
  //               bottom: 0;
  //               left: 0;
  //               width: 100px;
  //               height: 60px;
  //               background: linear-gradient(45deg, #FF6B35, #FF8C42);
  //               border-radius: 0 0 0 50px;
  //               opacity: 0.3;
  //           }
  //           .wave-right {
  //               position: absolute;
  //               bottom: 0;
  //               right: 0;
  //               width: 100px;
  //               height: 60px;
  //               background: linear-gradient(135deg, #4CAF50, #66BB6A);
  //               border-radius: 0 0 50px 0;
  //               opacity: 0.3;
  //           }
  //       </style>
  //   </head>
  //   <body>
  //       <div class="certificate">
  //           <div class="header">
  //               <div class="ministry">
  //                   <div class="government-emblem">🏛️</div>
  //                   <h3>इलेक्ट्रॉनिकी एवं सूचना प्रौद्योगिकी मंत्रालय</h3>
  //                   <p>MINISTRY OF ELECTRONICS AND INFORMATION TECHNOLOGY</p>
  //                   <p class="digital-india">Digital India</p>
  //               </div>
  //               <div class="bhashini-logo">
  //                   <div class="bhashini-icon">🌿</div>
  //                   <h2>BHASHINI</h2>
  //                   <p>भाषिणी</p>
  //               </div>
  //           </div>

  //           <div class="title">
  //               <h1>CERTIFICATE</h1>
  //               <h2>OF APPRECIATION</h2>
  //           </div>

  //           <div class="presented">PROUDLY PRESENTED TO</div>

  //           <div class="name">Animesh Patil</div>

  //           <div class="line">
  //               <div></div>
  //               <span></span>
  //               <div></div>
  //           </div>

  //           <div class="recognition">
  //               Recognized as a <strong>Agri Bhasha Samarthak</strong>
  //           </div>

  //           <div class="description">
  //               For contributing to AgriDaan under BhashaDaan by BHASHINI, strengthening agricultural knowledge in Indian languages and advancing the vision of an inclusive, self-reliant Bharat.
  //           </div>

  //           <div class="signature">
  //               <p>CEO, BHASHINI</p>
  //               <div class="signature-line"></div>
  //           </div>

  //           <!-- Decorative Lines -->
  //           <div class="decorative-lines">
  //               <div class="wave-left"></div>
  //               <div class="wave-right"></div>
  //           </div>
  //       </div>
  //   </body>
  //   </html>
  //   ''';

  //   try {
  //     // Create blob and trigger download
  //     final blob = html.Blob([certificateHtml], 'text/html');
  //     final url = html.Url.createObjectUrlFromBlob(blob);
  //     final anchor = html.AnchorElement(href: url)
  //       ..setAttribute('download', 'Certificate_Animesh_Patil.html')
  //       ..click();
  //     html.Url.revokeObjectUrl(url);

  //     // Show success message
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text(
  //           "Certificate downloaded successfully!",
  //           style: GoogleFonts.notoSans(),
  //         ),
  //         backgroundColor: AppColors.darkGreen,
  //         duration: const Duration(seconds: 3),
  //       ),
  //     );
  //   } catch (e) {
  //     // Show error message
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text(
  //           "Error downloading certificate: $e",
  //           style: GoogleFonts.notoSans(),
  //         ),
  //         backgroundColor: Colors.red,
  //         duration: const Duration(seconds: 3),
  //       ),
  //     );
  //   }
  // }
}
