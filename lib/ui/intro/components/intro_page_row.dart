// import 'package:flutter/material.dart';
//
// import '../../../shared/widget/dexter_button.dart';
//
// class IntroPageRow extends StatelessWidget {
//   const IntroPageRow({
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
// //    ScreenUtil.defaultSize
//     return Row(
//       children: <Widget>[
//         Expanded(
//           child: Padding(
//             padding: const EdgeInsets.only(right: 8, left: 12),
//             child:
//           ),
//         ),
//         Expanded(
//           child: SizedBox(
//             height: 50,
//             child: Padding(
//               padding: const EdgeInsets.only(right: 12, left: 8),
//               child: DexterButton(
//                 title: "Register",
//                 onPress: () {
//                   // showSheet(context, false);
//                 },
//                 textColor: Colors.red,
//                 color: Colors.white,
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
// // void showSheet(BuildContext ctx, bool isLogin) {
// //   showMaterialModalBottomSheet(
// //     context: ctx,
// //     clipBehavior: Clip.hardEdge,
// //     shape: const RoundedRectangleBorder(
// //         borderRadius:
// //             BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16))),
// //     backgroundColor: AppColors.mBackground,
// //     builder: (context) => IntroSocialWidget(isLogin, (CreateUserObject object) {
// //       Navigator.of(ctx)
// //           .pushNamed(RegisterUsername.username, arguments: {RouteArguments.userObject: object});
// //     }),
// //   );
// // }
// }
