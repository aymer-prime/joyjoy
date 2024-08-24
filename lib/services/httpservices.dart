import 'dart:convert';

import 'package:tryt/config/config.dart';
import 'package:http/http.dart' as http;

class Httpservices {
  String serverUrl = Config.siteUrl;
  postMethod(String urlm, Object data) async {
    try {
      http.Response sonuc = await http.post(Uri.parse(serverUrl + urlm),
          headers: {
            'Authorization': 'Basic ${Config.basetoken}',
          },
          body: data);
      if (sonuc.statusCode == 200) {
        return sonuc.body;
      } else {
        return false;
      }
    } catch (error) {
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
        return sonuc.body;
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
        return false;
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
        return sonuc.body;
      } else {
        return "";
      }
    } catch (error) {
      return false;
    }
  }
}
