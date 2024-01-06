import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// Define the KML URL

// Fetch the KML content
Future<String> fetchKmlString(String url) async {
  Uri uri = Uri.parse(url);
  String? mapId = uri.queryParameters["mid"];
  String kmlUrl = "https://www.google.com/maps/d/u/0/kml?forcekml=1&mid=$mapId";
  debugPrint(kmlUrl);

  try {
    final response = await http
        .get(Uri.parse(kmlUrl), headers: {"Accept": "application/json"});
    debugPrint(response.statusCode.toString());
    if (response.statusCode == 200) {
      debugPrint(response.body); // KML content as a string
      return response.body;
    } else {
      throw Exception("Failed to fetch KML file");
    }
  } catch (e) {
    print("Error: $e");
    throw Exception("Failed to fetch KML file");
  }
}
