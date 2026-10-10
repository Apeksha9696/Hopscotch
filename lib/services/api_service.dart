import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;
import 'package:http/http.dart' as http;

import '../config/app_config.dart';
import '../models/homepage_response.dart';

class ApiException implements Exception {
  final String message;
  ApiException(this.message);
  @override
  String toString() => message;
}

class ApiService {
  /// 1. GET the API  2. check status  3. decode JSON  4. build models.
  Future<HomepageResponse> fetchHomepage() async {
    try {
      final String body;

      if (AppConfig.isApiUrlConfigured) {
        final response = await http
            .get(Uri.parse(AppConfig.homepageApiUrl),
                headers: AppConfig.requestHeaders)
            .timeout(const Duration(seconds: 20));

        if (response.statusCode != 200) {
          throw ApiException(
              'The server answered with status ${response.statusCode}.');
        }
        body = utf8.decode(response.bodyBytes);
      } else {
        // No URL set yet -> use the JSON saved in assets/.
        body = await rootBundle.loadString(AppConfig.localJsonAsset);
      }

      final decoded = jsonDecode(body);
      final homepage = HomepageResponse.fromJson(decoded);

      if (homepage.components.isEmpty) {
        throw ApiException(
            'The response was read, but no CustomTiles sections with images '
            'were found. Check assets/homepage_response.json or the API URL.');
      }
      return homepage;
    } on ApiException {
      rethrow;
    } on FormatException {
      throw ApiException('The response is not valid JSON.');
    } on http.ClientException {
      throw ApiException(
          'Could not reach the API. In Chrome this is often a CORS block. '
          'See the README (CORS section).');
    } catch (e) {
      throw ApiException('Something went wrong: $e');
    }
  }
}
