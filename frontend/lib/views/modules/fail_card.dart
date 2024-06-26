import 'package:flutter/material.dart';
import 'package:socon/utils/colors.dart';
import 'package:socon/utils/fontSizes.dart';
import 'package:socon/utils/icons.dart';
import 'package:socon/utils/responsive_utils.dart';
import 'package:socon/utils/result_msg_type.dart';
import 'package:socon/views/atoms/buttons.dart';
import 'package:socon/views/atoms/icon_loader.dart';
import 'package:fluentui_emoji_icon/fluentui_emoji_icon.dart';

class FailCard extends StatelessWidget {
  final Message resultMsg;
  final VoidCallback onPressed;
  FailCard({required this.resultMsg, required this.onPressed});



  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.WHITE,
      alignment: Alignment.center,
      child: Column(

        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: ResponsiveUtils.getHeightPercent(context, 65),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                FluentUiEmojiIcon(
                  fl: AppIcons.FAIL, // 클래스명.변수명
                  w: ResponsiveUtils.getWidthWithPixels(context, 60),
                  h: ResponsiveUtils.getHeightWithPixels(context, 60),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  resultMsg.failTitle,
                  style: TextStyle(
                    fontSize: ResponsiveUtils.calculateResponsiveFontSize(
                        context, FontSizes.XXLARGE),
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Container(
                  alignment: Alignment.center,
                  width: ResponsiveUtils.getWidthWithPixels(context, 235),
                  // 너비를 원하는 값으로 지정합니다.
                  child: Text(
                    resultMsg.failComment,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: ResponsiveUtils.calculateResponsiveFontSize(
                          context, FontSizes.XSMALL),
                      fontWeight: FontWeight.w400,
                      height: 1.2,
                    ),
                  ),
                ), // 나머지 공간을 차지하기 위해 Spacer 추가
              ],
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: BasicButton(text: '완료', color: "yellow", onPressed : onPressed),
            ),
          ),
          SizedBox(height: 25.0),
        ],
      ),
    );
  }
}
