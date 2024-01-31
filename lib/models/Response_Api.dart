import 'package:newtronic_test_rizky/models/newtronic_data.dart';

class ResponseApi {
  List<NewtronicData>? data;
  int? status;

  ResponseApi({
    this.data,
    this.status,
  });

  factory ResponseApi.fromJson(Map<String, dynamic> json) => ResponseApi(
        data: json["data"] == null ? [] : List<NewtronicData>.from(json["data"]!.map((x) => NewtronicData.fromJson(x))),
        status: json["status"],
      );
}




