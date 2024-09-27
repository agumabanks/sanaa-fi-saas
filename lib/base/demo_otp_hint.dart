import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sanaa_fi_saas/utils/app_constants.dart';
import 'package:sanaa_fi_saas/utils/dimensions.dart';
import 'package:sanaa_fi_saas/utils/styles.dart';

class DemoOtpHint extends StatelessWidget {
  const DemoOtpHint({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppConstants.demo ? Padding(
      padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
      child: Text(
        'for_demo_1234'.tr,
        style: rubikMedium.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).highlightColor),
      ),
    ) : const SizedBox();
  }
}
