import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:servxpert_frontend/constant/api_constants.dart';
import '../models/service_model.dart';
import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';


Future<List<ServiceModel>> fetchServices(String token) async {
  final response = await http.get(
    Uri.parse('http://10.226.212.30:8000/api/services/'),
    headers: {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    },
  );

  print('STATUS: ${response.statusCode}');
  print('BODY: ${response.body}');

  if (response.statusCode == 200) {
    List<dynamic> data = jsonDecode(response.body);
    return data.map((json) => ServiceModel.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load services');
  }
}
Future<String?> getAccessToken() async {
  final storage = FlutterSecureStorage();
  return await storage.read(key: 'access_token');
}

Future<Response> getProtectedData() async {
  final token = await getAccessToken();
  return await Dio().get(
    'http://your-backend-url/api/protected/',
    options: Options(
      headers: {'Authorization': 'Bearer $token'},
    ),
  );
}
Future<void> submitServiceProviderForm({
  required String fullName,
  required String dob,
  required String contactNo,
  required String address,
  required String gender,
  required String area,
  required String city,
  required String state,
  required String country,
  required String pincode,
  required String aadharNumber,
  required String panNumber,
  required File aadharFile,
  required File profileImageFile,
  required List<int> selectedCategoryIDs,
  required String experience,
  required String jwtToken,
}) async {
  final dio = Dio();

  try {
    final formData = FormData.fromMap({
      'name': fullName,
      'dob': dob,
      'contact_no': contactNo,
      'address': address,
      'gender': gender,
      'area': area,
      'city': city,
      'state': state,
      'country': country,
      'pincode': pincode,
      'adhar_number': aadharNumber,
      'pan_number': panNumber,
      'experience': experience,
      'SelectedCategoryIDs': selectedCategoryIDs.isNotEmpty
          ? jsonEncode(selectedCategoryIDs)
          : 'false',

      'adhar_card_pic_url': await MultipartFile.fromFile(
        aadharFile.path,
        filename: aadharFile.path.split('/').last,
      ),
      'captured_pic_url': await MultipartFile.fromFile(
        profileImageFile.path,
        filename: profileImageFile.path.split('/').last,
      ),
    });

    final response = await dio.post(

      submitUrl, // make sure it's 'service_provider_details/' endpoint
      data: formData,

      options: Options(
        headers: {
          'Authorization': 'Bearer $jwtToken',
          'Content-Type': 'multipart/form-data',
        },
        sendTimeout: Duration(seconds: 30),
        receiveTimeout: Duration(seconds: 30),
      ),
    );

    if (response.statusCode == 201) {
      print('JWT being used1: $jwtToken');
      print('✅ Form submitted successfully');
    } else {
      print('JWT being used2: $jwtToken');
      print('❌ Failed to submit form: ${response.statusCode}');
      print('Response body: ${response.data}');
    }
  } on DioException catch (e) {
    print('JWT being used3: $jwtToken');
    print('❌ Dio error: ${e.response?.statusCode}');
    print('Error data: ${e.response?.data}');
  } catch (e) {
    print('JWT being used4: $jwtToken');
    print('❌ Unexpected error: $e');
  }
}

