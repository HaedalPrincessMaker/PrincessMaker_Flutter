// import 'package:flutter/material.dart';
//
// /**
//  * RootTab
//  * - 모든 화면의 기본이 되는 페이지입니다.
//  *
//  *
//  * written by dongsu
//  */
// class ViewRootTab extends StatefulWidget {
//   const ViewRootTab({super.key});
//
//   @override
//   State<ViewRootTab> createState() => _ViewRootTabState();
// }
//
// class _ViewRootTabState extends State<ViewRootTab>
//     with SingleTickerProviderStateMixin {
//   late TabController controller;
//   int index = 0;
//
//   @override
//   void dispose() {
//     // TODO: implement dispose
//     controller.removeListener(() {
//       setState(() {
//         index = controller.index;
//       });
//     });
//
//     super.dispose();
//   }
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//
//     controller = TabController(length: 4, vsync: this);
//     controller.addListener(() {
//       setState(() {
//         index = controller.index;
//       });
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     TextStyle baseTextStyle = TextStyle(
//         color: FONT_GRAY4,
//         fontFamily: 'NotoSansKR',
//         fontSize: dwidth(context, 0.02),
//         fontWeight: FontWeight.w500
//     );
//     IconThemeData baseIconTheme = IconThemeData(
//       color: FONT_GRAY4,
//       size: dwidth(context, 0.07),
//     );
//     IconThemeData specialIconTheme = IconThemeData(
//       color: BG_WHITE,
//       size: dwidth(context, 0.07),
//     );
//
//     return DefaultLayout(
//       child: TabBarView(
//         physics: NeverScrollableScrollPhysics(),
//         controller: controller,
//         children: [
//           DozzariInfo(),
//           DozzariResv(),
//           DozzariResvStatus(),
//           DozzariHistory(),
//         ],
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         backgroundColor: (index == 0) ? Colors.transparent : Colors.white,  // index에 따라 투명도 결정
//         unselectedLabelStyle: baseTextStyle,
//         selectedLabelStyle: baseTextStyle.copyWith(color: BRAND_SECONDARY_COLOR),
//         unselectedIconTheme: (index != 0) ? baseIconTheme : specialIconTheme,
//         selectedIconTheme: baseIconTheme.copyWith(color: BRAND_SECONDARY_COLOR),
//         type: BottomNavigationBarType.fixed,
//         onTap: (int index) {
//           setState(() {
//             controller.animateTo(index);
//           });
//         },
//         currentIndex: index,
//         items: [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home_outlined),
//             label: '도짜리 소개',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.shopping_cart_outlined),
//             label: '예약하기',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.description_outlined),
//             label: '예약 현황',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.person_3_rounded),
//             label: '히스토리',
//           ),
//         ],
//         enableFeedback: false,
//       ),
//       transparent : (index == 0) ? true : false,
//     );
//   }
// }