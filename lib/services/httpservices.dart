import 'dart:convert';
import 'package:get/get.dart';
import 'package:tryt/config/config.dart';
import 'package:http/http.dart' as http;
import 'package:tryt/services/prefservice.dart';

class Httpservices {
  String serverUrl = Config.siteUrl;
  static bool _logoutCalled = false;

  postMethod(String urlm, Object data) async {
    try {
      http.Response sonuc = await http.post(Uri.parse(serverUrl + urlm),
          headers: {
            'Authorization': 'Basic ${Config.basetoken}',
          },
          body: data);
      //print('responseCode:${sonuc.statusCode}');
      //print('responseBody:${sonuc.body}');
      if (sonuc.statusCode == 200) {
        return  await _handleResponse(sonuc);
      } else {
        return false;
      }
    } catch (error) {
      //print('responceError:$error');
      return false;
    }
  }

  putMethod(String urlm, Object data) async {
    try {
      http.Response sonuc = await http.put(Uri.parse(serverUrl + urlm),
          headers: {
            // 'Content-Type': 'application/x-www-form-urlencoded',
            'Content-Type': 'application/json',
            'Authorization': 'Basic ${Config.basetoken}',
          },
          body: json.encode(data));
      if (sonuc.statusCode == 200) {
        return  await _handleResponse(sonuc);
      } else {
        return false;
      }
    } catch (error) {
      return false;
    }
  }

  getMethod(String urlm) async {
    try {
      var sonuc = await http.get(Uri.parse(serverUrl + urlm), headers: {
        'Authorization': 'Basic ${Config.basetoken}',
      });
      if (sonuc.statusCode == 200) {
        return sonuc.body;
      } else {
        return  await _handleResponse(sonuc);
      }
    } catch (error) {
      return false;
    }
  }

  deleteMethod(String urlm) async {
    try {
      var sonuc = await http.delete(Uri.parse(serverUrl + urlm), headers: {
        'Authorization': 'Basic ${Config.basetoken}',
      });
      if (sonuc.statusCode == 200) {
        return  await _handleResponse(sonuc);
      } else {
        return "";
      }
    } catch (error) {
      return false;
    }
  }

  // Private method to handle responses and check for logout
  Future<dynamic> _handleResponse(http.Response response) async {
    if (response.statusCode == 200) {
      var body = json.decode(response.body);
      if (body['logout'] == true && !_logoutCalled) {
        _logoutCalled = true;
        await PrefService().setString("email", "");
        await PrefService().setString("password", "");
        Get.offAllNamed('/');
        // reset logout
        Future.delayed(Duration(seconds: 5), () {
          _logoutCalled = false;
        });
        return true;
      }

      return response.body;
    } else {
      return false;
    }
  }
}
