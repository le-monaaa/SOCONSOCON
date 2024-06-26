import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:socon/services/mystore_lists_service.dart';
import 'package:socon/utils/colors.dart';
import 'package:socon/utils/fontSizes.dart';
import 'package:socon/utils/responsive_utils.dart';
import 'package:socon/utils/icons.dart';
import 'package:socon/viewmodels/mystore_detail_menu_list_view_model.dart';
import 'package:socon/views/atoms/tab.dart';
import 'package:socon/views/atoms/tag_icon.dart';
import 'package:socon/views/modules/mystore_menu_management.dart';
import 'package:socon/views/modules/mystore_rigister_menu_lists.dart';
import 'package:socon/views/screens/my_store_list_screen.dart';

class StoreTopCard extends StatefulWidget {
  final int storeId;
  final bool isOwner;


  const StoreTopCard({
    super.key,
    required this.storeId,
    required this.isOwner,
  });

  @override
  State<StoreTopCard> createState() => _StoreTopCardState();
}

class _StoreTopCardState extends State<StoreTopCard> {
  // 내 발급 목록 리스트 불러오기
  Map<String, dynamic> storeInfos = {};

  void initState() {
    super.initState();
    loadMyStores();
  }

  MystoreMenuListViewModel viewModel = MystoreMenuListViewModel();
  void loadMyStores() async {
    debugPrint('내점포 상세조회 - 발행소콘 목록!');
    var infos = await viewModel.storeDetailInfos(widget.storeId);
    // print('njnjnjnjnjnjnjnjnjnjn');
    // print(infos);
    // print('njnjnjnjnjnjnjnjnjnjn');
    setState(() {
      storeInfos = infos['store'];
    });
  }

  @override
  Widget build(BuildContext context) {
    print('7777777777777777777');
    print(storeInfos);
    print(widget.storeId);
    print('77777777777777777777');


    if(viewModel.isLoading == false) {
      return SafeArea(
          child: Container(
            color: AppColors.WHITE,
            child: Stack(
              children: [
                Container(
                  // child: Image.network('https://cataas.com/cat',
                  child: Image.network(storeInfos['image'] ?? '',
                      fit: BoxFit.cover,
                      height: ResponsiveUtils.getHeightWithPixels(context, 160),
                      width: ResponsiveUtils.getWidthPercent(context, 100)),
                ),
                shortStoreInfoWithBar(context, storeInfos),
              ],
            ),
          )
      );
    } else {
      return Center(child: CircularProgressIndicator(),);
    }

    // bottomNavigationBar: null,
  }

  Widget shortStoreInfoWithBar(BuildContext context, storeInfos) {
    return Column(
      children: [
        // 매장 정보에 대한 상단 바
        Container(
          margin: EdgeInsets.all(5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  // Navigator 이동 기능 주석 처리됨
                  Navigator.of(context).pop();
                },
                icon: Icon(
                  AppIcons.LEADING, // 아이콘
                  color: AppColors.WHITE,
                  size: ResponsiveUtils.getWidthWithPixels(
                      context, 28.0), // 아이콘 크기
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  AppIcons.INFO, // 아이콘
                  color: AppColors.WHITE,
                  size: ResponsiveUtils.getWidthWithPixels(
                      context, 24.0), // 아이콘 크기
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: ResponsiveUtils.getHeightWithPixels(context, 50)),
        shortStoreInfoCard(context, storeInfos),
      ],
    );
  }

//////////////////////////////////
  Widget shortStoreInfoCard(BuildContext context, storeInfos) {
    return // 매장 정보 카드
        Container(
      width: ResponsiveUtils.getWidthWithPixels(context, 330),
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.only(top: 10),
      // 상단 바와의 간격 추가
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 매장 이름과 태그
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                storeInfos['name'] ?? '',
                style: TextStyle(
                  fontSize: ResponsiveUtils.calculateResponsiveFontSize(
                      context, FontSizes.XLARGE),
                  fontWeight: FontWeight.w800,
                ),
              ),
              TagIcon(
                buttonText: storeInfos['category'] ?? '',
                buttonColor: Colors.brown,
                buttonTextColor: AppColors.WHITE,
                width: ResponsiveUtils.getWidthWithPixels(context, 42),
                height: ResponsiveUtils.getHeightWithPixels(context, 20),
              ),
            ],
          ),
          SizedBox(height: 2),
          Text(
            storeInfos['address'] ?? '',
            style: TextStyle(color: AppColors.GRAY500),
          ),
          SizedBox(height: 10),
          Text(
            storeInfos['introduction'] ?? '',
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: ResponsiveUtils.calculateResponsiveFontSize(
                  context, FontSizes.XXSMALL),
              fontWeight: FontWeight.w500,
              height: 1.2,
            ),
          ),
          SizedBox(height: 10),

          widget.isOwner?
            GestureDetector(
              onTap: () {
                print("매장 정보 수정 버튼 클릭");
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(
                    AppIcons.EDIT,
                    color: AppColors.BLACK,
                    size: ResponsiveUtils.getWidthWithPixels(context, 16),
                  ),
                  SizedBox(width: 6),
                  Text(
                    '매장 정보 수정',
                    style: TextStyle(
                      color: AppColors.BLACK,
                      fontSize: ResponsiveUtils.calculateResponsiveFontSize(
                          context, FontSizes.XXXSMALL),
                    ),
                  ),
                ],
              ),
            ) :
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {},
                  child: Row(
                    children: [
                      Icon(
                        AppIcons.PHONE,
                        color: AppColors.BLACK,
                        size: ResponsiveUtils.getWidthWithPixels(context, 16),
                      ),
                      SizedBox(width: 6),
                      Text(
                        '전화',
                        style: TextStyle(
                          color: AppColors.BLACK,
                          fontSize: ResponsiveUtils.calculateResponsiveFontSize(
                              context, FontSizes.XXXSMALL),
                        ),
                      ),
                    ],
                  ),
                ),
                Text('|', style: TextStyle(color: AppColors.GRAY300),),
                GestureDetector(
                  onTap: () {},
                  child: Row(
                    children: [
                      Icon(
                        AppIcons.HEARTOFF,
                        // AppIcons.HEARTON,
                        color: AppColors.BLACK,
                        size: ResponsiveUtils.getWidthWithPixels(context, 16),
                      ),
                      SizedBox(width: 6),
                      Text(
                        storeInfos['favorite_count'] ?? 0,
                        style: TextStyle(
                          color: AppColors.BLACK,
                          fontSize: ResponsiveUtils.calculateResponsiveFontSize(
                              context, FontSizes.XXXSMALL),
                        ),
                      ),
                    ],
                  ),
                ),
                Text('|', style: TextStyle(color: AppColors.GRAY300),),
                GestureDetector(
                  onTap: () {},
                  child: Row(
                    children: [
                      Icon(
                        AppIcons.STORE,
                        color: AppColors.BLACK,
                        size: ResponsiveUtils.getWidthWithPixels(context, 16),
                      ),
                      SizedBox(width: 6),
                      Text(
                        '매장정보',
                        style: TextStyle(
                          color: AppColors.BLACK,
                          fontSize: ResponsiveUtils.calculateResponsiveFontSize(
                              context, FontSizes.XXXSMALL),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}

// SizedBox(height: 170, ),
// Expanded(
//   child: Container(
//     padding: EdgeInsets.symmetric(horizontal: 0),
//     child: TabBarScreen(
//         marginTop: 0,
//         contents: {
//           '메뉴 관리': MenuManagement(storeId: storeId),
//           '발행 소콘': RegisteredMenu(),
//         }
//       ),
//   ),
// ),
