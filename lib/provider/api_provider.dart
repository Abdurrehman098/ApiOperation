import 'package:flutter/material.dart';
import 'package:rest_api_practice/Api_services/api_services.dart';
import 'package:rest_api_practice/model/api_model.dart';

class ApiProvider extends ChangeNotifier {
  List<ApiModel> get = [];
  final ApiServices apiServices = ApiServices();
  bool isLoading = false;
  String errorMessage = "";

  String? titleValidate(String? value) {
    if (value == null || value.isEmpty) {
      return "title is required";
    } else {
      return null;
    }
  }

  String? bodyValidate(String? value) {
    if (value == null || value.isEmpty) {
      return "description is required";
    } else {
      return null;
    }
  }

  Future<void> getData() async {
    try {
      isLoading = true;
      errorMessage = "";
      notifyListeners();
      get = await apiServices.getData();
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }


  Future<void> postData(ApiModel model) async {
    try {
      isLoading = true;
      errorMessage = "";
      notifyListeners();
      final newPost = await apiServices.postData(model);

      get.insert(0, newPost);
    } catch (e) {
      throw Exception("Error : $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> putData(ApiModel model) async {
    try {
      isLoading = true;
      errorMessage = "";
      notifyListeners();
      final updatedPost = await apiServices.putData(model);
      final index = get.indexWhere((post) => post.id == model.id);
      if (index != -1) {
        get[index] = updatedPost;
      }
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deleteData(int id) async {
    try {
      isLoading = true;
      errorMessage = "";
      notifyListeners();
      await apiServices.deleteData(id);
      get.removeWhere((post) => post.id == id);
    } catch (e) {
      errorMessage = e.toString();
    } finally {

      isLoading = false;
      notifyListeners();
    }
  }
}
