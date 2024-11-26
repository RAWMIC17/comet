import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  final String _baseUrl = "http://127.0.0.1:5000/"; // Replace with your actual API base URL

  // Function to fetch college data
  Future<List<Map<String, dynamic>>> fetchCollegeData() async {
    try {
      final response = await http
          .get(Uri.parse(_baseUrl))
          .timeout(Duration(seconds: 10)); // Set a timeout for the request

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        if (data == null) {
          return []; // Return an empty list if the response body is null
        }
        return data.map((college) => Map<String, dynamic>.from(college)).toList();
      } else {
        print('Failed to load college data: ${response.statusCode}');
        throw Exception('Failed to load college data');
      }
    } catch (e) {
      print("Error fetching college data: $e");
      return []; // Return an empty list in case of error
    }
  }
}
