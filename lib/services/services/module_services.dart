import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:tutor_me/services/models/modules.dart';

class ModuleServices {
  static getModules() async {
    Uri modulesURL =
        Uri.http('tutorme-prod.us-east-1.elasticbeanstalk.com', '/api/Modules');
    try {
      final response = await http.get(modulesURL, headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Access-Control-Allow-Origin": "*"
      });

      if (response.statusCode == 200) {
        String j = "";
        if (response.body[0] != "[") {
          j = "[" + response.body + "]";
        } else {
          j = response.body;
        }
        final List list = json.decode(j);
        return list.map((json) => Modules.fromObject(json)).toList();
      } else {
        throw Exception('Failed to load');
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  static updateModule(Modules module) async {
    String data = jsonEncode({
      'code': module.getCode,
      'moduleName': module.getModuleName,
      'institution': module.getInstitution,
      'faculty': module.getFaculty,
      'year': module.getYear,
    });
    final header = <String, String>{
      'Content-Type': 'application/json; charset=utf-8',
    };
    try {
      final code = module.getCode;
      final modulesURL = Uri.parse(
          'http://tutorme-prod.us-east-1.elasticbeanstalk.com/api/Modules/$code');
      final response = await http.put(modulesURL, headers: header, body: data);
      if (response.statusCode == 204) {
        return module;
      } else {
        throw Exception('Failed to upload ' + response.statusCode.toString());
      }
    } catch (e) {
      rethrow;
    }
  }

  static deleteModule(String code) async {
    final header = <String, String>{
      'Content-Type': 'application/json; charset=utf-8',
    };
    try {
      final modulesURL = Uri.parse(
          'http://tutorme-prod.us-east-1.elasticbeanstalk.com/api/Modules/$code');
      final response = await http.delete(modulesURL, headers: header);
      if (response.statusCode == 204) {
        Fluttertoast.showToast(
            msg: "Module Deleted",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        Fluttertoast.showToast(
            msg: "Failed to delete module",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        throw Exception(
            'Failed to delete module' + response.statusCode.toString());
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future getModule(String id) async {
    Uri tutorURL = Uri.http(
        'tutorme-prod.us-east-1.elasticbeanstalk.com', '/api/Modules/$id');
    try {
      final response = await http.get(tutorURL, headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Access-Control-Allow-Origin": "*"
      });
      if (response.statusCode == 200) {
        String j = "";
        if (response.body[0] != "[") {
          j = "[" + response.body + "]";
        } else {
          j = response.body;
        }
        final List list = json.decode(j);
        return list.map((json) => Modules.fromObject(json)).toList();
      } else {
        throw Exception('Failed to load');
      }
    } catch (e) {
      return null;
    }
  }

  static getModulesByInstitution(String institution) async {
    List<Modules> modules = await getModules();
    List<Modules> modulesByInstitution = [];
    for (int i = 0; i < modules.length; i++) {
      if (modules[i].getInstitution == institution) {
        modulesByInstitution.add(modules[i]);
      }
    }
    return modulesByInstitution;
  }

  static getInstitutions() async {
    final modules = await getModules();
    List institutions = [];
    for (final item in modules) {
      if (!institutions.contains(item.getInstitution)) {
        institutions.add(item.getInstitution);
      }
    }
    return institutions;
  }
}
