import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

import '../utils/api/api_utils.dart';

class MySoconService {

  Future<Map<String, dynamic>> getMySoconList() async {
    try {
      final response = await ApiUtils.getDataWithToken('/api/v1/socons/book');

      Map<String, dynamic> data = jsonDecode(response);

      Map<String, dynamic> dataBody = data['data_body'];
      print("[service] 소콘북 소콘 목록 가져오기 성공 ${dataBody}");
      return dataBody;
    } catch (error) {
      print("[service] 소콘북 소콘 목록 가져오기 실패 $error");
      throw error; // 예외를 다시 던져서 상위 레벨에서 처리하도록 함
    }
  }


  // 사용 가능한 소콘 목록 (unused, sogon)
  Future<void> getUnusedMySocon() async {
    try {
      print("사용 가능한 소콘들");
    } catch (error) {
      print("소콘북 소콘 목록 가져오기 실패 $error");
    }
  }

  // 사용 완료한 소콘 목록 (used, expired)
  Future<void> getUsedMySocon() async {
    try {
      print("사용 완료한 소콘들");
    } catch (error) {
      print("소콘북 소콘 목록 가져오기 실패 $error");
    }
  }
}
