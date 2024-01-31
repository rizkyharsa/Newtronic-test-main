import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:newtronic_test_rizky/configs/constant.dart';
import 'package:newtronic_test_rizky/models/newtronic_data.dart';
import 'package:newtronic_test_rizky/services/rest_service.dart';

class BerandaRepository {
  Dio get dio => RestService().dio;

  Future<List<NewtronicData>> getNewtronicData() async {
    var response = await dio.get(baseUrl);
    // return NewtronicData.fromJson(response.data["data"]);
    if (response.statusCode == 200) {
      final List rawData = jsonDecode(jsonEncode(response.data['data']));
      return rawData.map((e) => NewtronicData.fromJson(e)).toList();
    } else {
      return [];
    }
  }
}
