import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/theme/app_theme.dart';
import 'edit_profile_source_option.dart';

class EditProfileImageSourceSheet extends StatelessWidget {
  const EditProfileImageSourceSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            SizedBox(height: 20.h,),
            Text(
              'Change Profile Photo',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w800,
                color: AppTheme.textDarkNavy,
                fontFamily: 'Inter',
              ),
            ),
            SizedBox(height: 24.h,),
            Row(
              children: [
                Expanded(
                  child: EditProfileSourceOption(
                    icon: Icons.photo_library_rounded,
                    label: 'Gallery',
                    onTap: () => Navigator.pop(context, ImageSource.gallery),
                  ),
                ),
                SizedBox(width: 16.w,),
                Expanded(
                  child: EditProfileSourceOption(
                    icon: Icons.camera_alt_rounded,
                    label: 'Camera',
                    onTap: () => Navigator.pop(context, ImageSource.camera),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.h,),
          ],
        ),
      ),
    );
  }
}
