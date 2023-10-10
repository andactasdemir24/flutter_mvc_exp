// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mvc_exp/Models/user_model.dart';

class UserDataService extends ChangeNotifier {
  String userUrl = 'https://reqres.in/api/users';

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<Data> users = [];

  Future<List<Data>?> fetchUsers() async {
    _isLoading = true;
    notifyListeners(); // isLoading değişkeninin değiştiğini bildir

    try {
      final result = await http.get(Uri.parse(userUrl));

      if (result.statusCode == 200) {
        Map<String, dynamic> data = json.decode(result.body);
        var _users = data["data"];
        if (_users != null) {
          users = User.fromJson(data).data!;
        }
        _isLoading = false;
        return users; // Verileri doğru şekilde döndür
      } else {
        _isLoading = false;
        throw Exception('Error - ${result.statusCode}');
      }
    } catch (e) {
      _isLoading = false;
      print('Error Fetching Users: $e');
      return null; // Hata durumunda null döndür
    } finally {
      notifyListeners(); // işlem tamamlandığında isLoading değişkenini güncelle
    }
  }
}
