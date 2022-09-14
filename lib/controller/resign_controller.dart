import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:device_information/device_information.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:package_info/package_info.dart';
import 'package:rtl/utils/helper/pref_utils.dart';
import 'package:rtl/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../utils/constants/app_constants.dart';
import '../utils/myconnectivity.dart';
import 'GetxNetworkManager.dart';

class ResignController extends GetxController {
  final _isLoading = false.obs;

  get isLoading => _isLoading;
  final GetXNetworkManager _networkManager = Get.find<GetXNetworkManager>();

  Future applyResignation(
    BuildContext context,
    dynamic profileImage,
    String signatureImage,
    String lastworkingDate,
    comment,
  ) async {
    if (_networkManager.connectionType != 0) {
      var postUri = Uri.parse(AppConstants.registration);
      Map<String, String> headers = {
        "Content-Type": 'multipart/form-data; boundary=<calculated when request is sent>',
        "Content-Length": '<calculated when request is sent>',
        "Authorization": 'Bearer ${PrefUtils.getUserToken()}'
      };
      var request = http.MultipartRequest('POST', postUri);

      request.fields['inputJsonString'] =
          '{"employee": {"id": "${PrefUtils.getuserID()}"},"strLastWorkingDate": "${DateFormat('dd-MM-yyyy').format(DateTime.parse(lastworkingDate))}","reason": "$comment"}';
      /*request.fields.addAll({
        'inputJsonString': '{"employee": {"id": "${PrefUtils.getuserID()}"},"strLastWorkingDate": "${DateFormat('dd-MM-yyyy').format(DateTime.parse(lastworkingDate))}","reason": "$comment"}'
      });*/
      request.files
          .add(await http.MultipartFile.fromPath('files', signatureImage));
      request.files
          .add(await http.MultipartFile.fromPath('files', profileImage.path));
      request.headers.addAll(headers);
      print(request.fields);
      print(request.headers);

      http.StreamedResponse response = await request.send();

      var responseData =
          await response.stream.asBroadcastStream().bytesToString();
      print(responseData);
      print("response>>>>>>>>>>>" + responseData.toString());
      Map mapRes = json.decode(responseData);
      if (response.statusCode == 200) {
        if (mapRes['status'] == 'success') {
          // Utils.showSuccessMessage(context, mapRes['message']);
          return mapRes;
        } else {
          Utils.hideLoader();
          Utils.showErrorMessage(context, mapRes['message']);
          return mapRes;
        }
      } else {
        Utils.hideLoader();
        Utils.showErrorMessage(context, "Error");
        return mapRes;
      }
    } else {
      Get.snackbar(AppConstants.title, AppConstants.message);
    }
  }

  Future<File> changeFileNameOnly(File file, String newFileName) {
    var path = file.path;
    var lastSeparator = path.lastIndexOf(Platform.pathSeparator);
    var newPath = path.substring(0, lastSeparator + 1) + newFileName;
    print(file.rename(newPath));
    return file.rename(newPath);
  }
}
