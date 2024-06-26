// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'image_card.dart';
// import 'tag_icon.dart';
// import 'dart:math';
//
// // 필요 없을수도???
// class SoconManagement extends StatelessWidget {
//   final String soconName;
//   final bool isMain;
//   final int maxQuantity;    // 설정된 최대 발행량
//   final int issuedQuantity;   // 현재 발행 개수
//   final int price;     // 상품가격(정가)
//   final bool isDiscounted;
//   final int discountedPrice;    // 할인된 가격. 없을 경우 null
//   final String imageUrl;
//   final DateTime createdAt;
//
//
//   const SoconManagement({
//     super.key,
//     required this.soconName,
//     required this.isMain,
//     required this.maxQuantity,
//     required this.issuedQuantity,
//     required this.price,
//     required this.isDiscounted,
//     required this.discountedPrice,
//     required this.imageUrl,
//     required this.createdAt,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width / 2;
//     final remainQuantity = maxQuantity - issuedQuantity;
//     final discountPercent = isDiscounted ? ((price - discountedPrice) / price * 100).toStringAsFixed(0) : '0';
//     final isNew = DateTime.now().difference(createdAt).inDays < 1 && DateTime.now().difference(createdAt).isNegative == false;
//
//     final List<String> images = ['assets/images/backgroundImg_1.JPG', 'assets/images/backgroundImg_2.png'];
//     final random = Random();
//     final String randomImage = images[random.nextInt(images.length)];
//
//     return Container(
//       width: screenWidth,
//       margin: EdgeInsets.all(5),
//       padding: EdgeInsets.only(top: 10),
//       decoration: BoxDecoration(
//           color: isMain ? null : Colors.white,
//           image: isMain ? DecorationImage(
//             image: AssetImage(randomImage),
//             fit: BoxFit.cover,
//           ) : null,
//           borderRadius: BorderRadius.circular(10),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.grey.withOpacity(0.7),
//               spreadRadius: 0,
//               blurRadius: 5.0,
//               offset: Offset(0, 5), // changes position of shadow
//             ),
//           ]),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           Container(
//             margin: EdgeInsets.symmetric(horizontal: 15),
//             child: Row(
//               children: [
//                 isNew? TagIcon.NEW() : Text(''),
//                 // isNew? TagIcon.NEW() : Text(''),
//                 isDiscounted? TagIcon.SALE() : Text(''),
//               ],
//             ),
//           ),
//           Container(
//             margin: EdgeInsets.symmetric(horizontal: 15),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       soconName,
//                       textAlign: TextAlign.start,
//                       style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black, ),
//                     ),
//                     if (maxQuantity != null) Container(
//                         padding: EdgeInsets.only(bottom: 20),
//                         child: Text(
//                           '잔여수량 $remainQuantity \n발행수량 $maxQuantity',
//                           style: TextStyle(
//                           fontSize: 10,
//                           color: Colors.black),
//                         maxLines: 2,
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                     ),
//                   ],
//                 ),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.end,
//                   children: [
//                     if (isDiscounted) ...[ // 할인된 경우
//                       Text('($discountPercent%)', style: TextStyle(fontSize: 11, color: Colors.red), ),
//                       Text('$discountedPrice원', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.red)),
//                       Text('$price원', style: TextStyle(fontSize: 12, decoration: TextDecoration.lineThrough ,decorationColor: Colors.red, decorationThickness: 2.0, fontWeight: FontWeight.bold)),
//                     ] else ...[ // 할인되지 않은 경우
//                       Text('$price원', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87)),
//                     ]
//                   ],
//                 )
//               ],
//             ),
//           ),
//           // SizedBox(height: 5),
//           Expanded(
//             child: ImageCard(
//               imgUrl: imageUrl,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
//
