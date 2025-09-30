import 'package:bhashadaan/constants/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ActionsSection extends StatelessWidget {
  const ActionsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16).r,
      decoration: BoxDecoration(
        color: AppColors.lightGreen2,
        border: Border.all(color: AppColors.lightGreen),
        borderRadius: BorderRadius.circular(12).r,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          actionButton(
              onTap: () {},
              title: AppLocalizations.of(context)!.quickTips,
              icon: Icons.lightbulb_outline),
          actionButton(
              onTap: () {},
              title: AppLocalizations.of(context)!.report,
              icon: Icons.report_outlined),
          actionButton(
              onTap: () {},
              title: AppLocalizations.of(context)!.testSpeakers,
              icon: Icons.volume_up_outlined),
        ],
      ),
    );
  }

  Widget actionButton(
      {required VoidCallback? onTap,
      required String title,
      required IconData icon}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.only(left: 12, right: 12, top: 8, bottom: 8).r,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: AppColors.darkGreen),
          borderRadius: BorderRadius.circular(8).r,
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: AppColors.darkGreen,
              size: 16.sp,
              weight: 600,
            ),
            SizedBox(width: 4.w),
            Text(title,
                style: GoogleFonts.notoSans(
                    color: AppColors.darkGreen,
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }
}
