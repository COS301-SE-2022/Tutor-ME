import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:tutor_me/services/models/groups.dart';

class GroupServices {
  static createGroup(
    String moduleCode,
    String moduleName,
    String tutorId,
  ) async {
    final groupsURL =
        Uri.http('tutorme-prod.us-east-1.elasticbeanstalk.com', '/api/Groups');

    String data = jsonEncode({
      'moduleCode': moduleCode,
      'moduleName': moduleName,
      'tutees': '',
      'tutorId': tutorId,
      'description': 'No description added'
    });

    final header = <String, String>{
      'Content-Type': 'application/json; charset=utf-8',
    };
    try {
      final response = await http.post(groupsURL, headers: header, body: data);
      if (response.statusCode == 201) {
        String j = "";
        if (response.body[0] != "[") {
          j = "[" + response.body + "]";
        } else {
          j = response.body;
        }
      } else {
        throw Exception('Failed to create ' + response.statusCode.toString());
      }
    } catch (e) {
      rethrow;
    }
  }

  static getGroups() async {
    Uri groupsURL =
        Uri.http('tutorme-prod.us-east-1.elasticbeanstalk.com', '/api/Groups');
    try {
      final response = await http.get(groupsURL, headers: {
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
        return list.map((json) => Groups.fromObject(json)).toList();
      } else {
        throw Exception('Failed to load');
      }
    } catch (e) {
      throw Exception(e);
    }
  }

 
}
