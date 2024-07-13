import 'dart:convert';
import 'package:financial/models/leave_model.dart';
import 'package:http/http.dart' as http;

class LeaveService {
  Future<List<LeaveModel>> getLeave() async {
    try {
      final response = await http.get(
        Uri.parse('http://your-api-link/api/employee-leaves'),
      );
      if (response.statusCode == 200) {
        return List<LeaveModel>.from(
          jsonDecode(response.body)['data'].map(
            (leave) => LeaveModel.fromJson(leave),
          ),
        ).toList();
      }

      throw Exception('Failed to load leave data');
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addLeave(LeaveModel leave) async {
    try {
      final response = await http.post(
        Uri.parse('http://your-api-link/api/employee-leaves'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(leave.toJson()),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
      } else {
        throw Exception('Failed to Ajuin Cuti record: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to Ajuin Cuti record: $e');
    }
  }

  Future<void> deleteLeave(int id) async {
    try {
      final response = await http.delete(
        Uri.parse('http://your-api-link/api/employee-leaves/$id'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (response.statusCode == 200 || response.statusCode == 204) {
      } else {
        throw Exception(
            'Failed to delete leave record: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to delete leave record: $e');
    }
  }
}
