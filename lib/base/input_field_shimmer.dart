// import 'package:flutter/material.dart';
// import 'package:get/get_utils/src/extensions/internacionalization.dart';
// import 'package:shimmer/shimmer.dart';
// import 'package:sanaa_fi_saas/helper/price_converter.dart';
// import 'package:sanaa_fi_saas/utils/color_resources.dart';
// import 'package:sanaa_fi_saas/utils/dimensions.dart';
// import 'package:sanaa_fi_saas/utils/images.dart';
// import 'package:sanaa_fi_saas/utils/styles.dart';

// class InputFieldShimmer extends StatelessWidget {
//   const InputFieldShimmer({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Shimmer.fromColors(
//       baseColor: Colors.grey, highlightColor: Colors.grey[200]!,
//       child: Column(children: [
//         Stack(children: [
//           Column(children: [
//             Padding(
//               padding: const EdgeInsets.only(top: Dimensions.paddingSizeExtraLarge, bottom: Dimensions.paddingSizeLarge),
//               child: TextField(
//                 enabled: false,
//                 textAlignVertical: TextAlignVertical.center,
//                 textAlign: TextAlign.center, style: rubikMedium.copyWith(fontSize: 34, color: Theme.of(context).primaryColor),
//                 decoration: InputDecoration(border: InputBorder.none, hintText:PriceConverter.balanceInputHint(), hintStyle: rubikMedium.copyWith(fontSize: 34, color: Theme.of(context).primaryColor) ),
//               ),
//             ),

//             Center(child: Text('${'available_balance'.tr} ${PriceConverter.availableBalance()}', style: rubikRegular.copyWith(fontSize: Dimensions.fontSizeLarge, color: ColorResources.getGreyBaseGray1()))),
//             const SizedBox(height: Dimensions.paddingSizeDefault),
//           ]),

//           Positioned(left: Dimensions.paddingSizeLarge, bottom: Dimensions.paddingSizeExtraLarge, child: Image.asset(Images.logo,width: 50.0)),

//           Positioned(right: 10, bottom: 5, child: Image.asset(Images.inputStackDesing, width: 150.0,filterQuality: FilterQuality.high)),
//         ]),

//         const SizedBox(height: Dimensions.dividerSizeMedium),

//       ]),
//     );
//   }
// }
