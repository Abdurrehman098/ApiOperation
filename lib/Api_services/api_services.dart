import 'dart:convert';

import 'package:rest_api_practice/model/api_model.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  final String baseUrl = "https://jsonplaceholder.typicode.com";

  Future<List<ApiModel>> getData() async {
    try {
      final response = await http.get(Uri.parse("$baseUrl/posts"));
      if (response.statusCode == 200) {
        final List data = jsonDecode(response.body);
        return data.map((json) => ApiModel.fromJson(json)).toList();
      } else {
        throw Exception("Failed to load Posts: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error $e");
    }
  }

  Future<ApiModel> postData(ApiModel model) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/posts"),

        headers: {"Content-Type": "Application/json"},
        body: jsonEncode(model.toJson()),
      );
      if (response.statusCode == 201) {
        final data = jsonDecode(response.body);
        return ApiModel.fromJson(data);
      } else {
        throw Exception("Failed to post data : ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error : $e");
    }
  }

  Future<ApiModel> putData(ApiModel model) async {
    try {
      final response = await http.put(
        Uri.parse("$baseUrl/posts/${model.id}"),
        headers: {"Content-Type": "Application/json"},
        body: jsonEncode(model.toJson()),
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return ApiModel.fromJson(data);
      } else {
        throw Exception("Failed to update data ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("error : $e");
    }
  }

  Future<void> deleteData(int id) async {
    try {
      final response = await http.delete(Uri.parse("$baseUrl/posts/$id"));
      if (response.statusCode == 200) {
        return;
      } else {
        throw Exception("Failed to delete data: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }
}
