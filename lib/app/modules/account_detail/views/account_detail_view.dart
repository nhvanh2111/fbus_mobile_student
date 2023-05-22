import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';

import '../../../core/utils/auth_service.dart';
import '../../../core/values/app_colors.dart';
import '../../../core/values/app_svg_assets.dart';
import '../../../core/values/font_weights.dart';
import '../../../core/values/text_styles.dart';
import '../../../core/widget/status_bar.dart';
import '../../../core/widget/unfocus.dart';
import '../controllers/account_detail_controller.dart';

class AccountDetailView extends GetView<AccountDetailController> {
  const AccountDetailView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StatusBar(
      brightness: Brightness.dark,
      child: Unfocus(
        child: Scaffold(
          body: SafeArea(
            child: SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                          top: 10.h,
                          right: 18.w,
                        ),
                        child: Row(
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                elevation: 0,
                                shape: const CircleBorder(),
                                padding: EdgeInsets.all(11.r),
                                minimumSize: Size.zero, // Set this
                              ),
                              onPressed: () {
                                Get.back();
                              },
                              child: const Icon(
                                Icons.arrow_back_ios_new,
                                color: AppColors.softBlack,
                              ),
                            ),
                            Text(
                              'Tài khoản của tôi',
                              style: h5.copyWith(color: AppColors.softBlack),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: 15.h,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Stack(
                          children: [
                            ClipOval(
                              child: SizedBox.fromSize(
                                size: Size.fromRadius(50.r), // Image radius
                                child: CachedNetworkImage(
                                  fadeInDuration: const Duration(),
                                  fadeOutDuration: const Duration(),
                                  placeholder: (context, url) {
                                    return SvgPicture.asset(AppSvgAssets.male);
                                  },
                                  imageUrl: AuthService.student?.photoUrl ?? '',
                                  fit: BoxFit.cover,
                                  errorWidget: (context, url, error) {
                                    return SvgPicture.asset(AppSvgAssets.male);
                                  },
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 0.h,
                              right: 0.w,
                              child: Container(
                                padding: EdgeInsets.all(6.w),
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.line,
                                ),
                                child: const Icon(Icons.photo_camera),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Column(
                          children: [
                            SizedBox(height: 15.h),
                            TextFormField(
                              enabled: false,
                              initialValue: AuthService.student?.fullName ?? '',
                              enableSuggestions: false,
                              autocorrect: false,
                              decoration: InputDecoration(
                                errorStyle: caption,
                                errorMaxLines: 2,
                                labelText: 'Họ và tên',
                                hintText: 'Chưa cập nhật',
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                counterStyle: const TextStyle(
                                  height: double.minPositive,
                                ),
                                counterText: "",
                              ),
                            ),
                            TextFormField(
                              enabled: false,
                              initialValue: AuthService.student?.address ?? '',
                              enableSuggestions: false,
                              autocorrect: false,
                              decoration: InputDecoration(
                                errorStyle: caption,
                                errorMaxLines: 2,
                                labelText: 'Địa chỉ',
                                hintText: 'Chưa cập nhật',
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                counterStyle: const TextStyle(
                                  height: double.minPositive,
                                ),
                                counterText: "",
                              ),
                            ),
                            TextFormField(
                              enabled: false,
                              initialValue: AuthService.student?.phone ?? '',
                              enableSuggestions: false,
                              autocorrect: false,
                              decoration: InputDecoration(
                                errorStyle: caption,
                                errorMaxLines: 2,
                                labelText: 'Số điện thoại',
                                hintText: 'Chưa cập nhật',
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                counterStyle: const TextStyle(
                                  height: double.minPositive,
                                ),
                                counterText: "",
                              ),
                            ),
                            TextFormField(
                              enabled: false,
                              initialValue: AuthService.student?.email ?? '',
                              enableSuggestions: false,
                              autocorrect: false,
                              decoration: InputDecoration(
                                errorStyle: caption,
                                errorMaxLines: 2,
                                labelText: 'Email',
                                hintText: 'Chưa cập nhật',
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                counterStyle: const TextStyle(
                                  height: double.minPositive,
                                ),
                                counterText: "",
                              ),
                            ),
                            SizedBox(height: 25.h),
                            _confirmButton(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _confirmButton() {
    return ElevatedButton(
      onPressed: null,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary400,
        disabledBackgroundColor: AppColors.onSurface.withOpacity(0.12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(300),
        ),
      ),
      child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 30.h),
              Text(
                'Cập nhật',
                style: subtitle1.copyWith(
                    fontWeight: FontWeights.medium, color: AppColors.white),
              ),
            ],
          )),
    );
  }
}
