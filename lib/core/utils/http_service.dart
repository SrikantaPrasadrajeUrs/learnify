import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:developer';
import '../constants/api_config.dart';
import '../exceptions/no_method_exception.dart';
import '../exceptions/status_code_exception.dart';

class HTTPService {
  static const Map<String, String> headers = {
    "Content-Type": "application/json",
  };

  static Future<dynamic> get(String endPoint, {int? statusCode}) async {
    return await _sendRequest(null, null, http.get, endPoint, null, statusCode);
  }

  static Future<dynamic> post(String endPoint, Map<String, dynamic>? data,
      {int? statusCode}) async {
    return await _sendRequest(
        null, http.post, null, endPoint, data, statusCode);
  }

  static Future<dynamic> put(String endPoint, Map<String, dynamic>? data,
      {int? statusCode}) async {
    return await _sendRequest(null, http.put, null, endPoint, data, statusCode);
  }

  static Future<dynamic> delete(String endPoint,
      {int? statusCode, bool wantErrorData = false}) async {
    return await _sendRequest(
        http.delete, null, null, endPoint, null, statusCode,
        wantErrorData: wantErrorData);
  }

  static Future<dynamic> _sendRequest(
      Future<http.Response> Function(Uri url, {Map<String,
          String>? headers, Object? body})?
      delete,
      Future<http.Response> Function(Uri url, {Map<String,
          String>? headers, Object? body})?
      putOrPost,
      Future<http.Response> Function(Uri url, {Map<String,
          String>? headers})? get,
      String endPoint,
      Map<String, dynamic>? data,
      int? statusCode, {bool wantErrorData = false}) async {
    try {
      // Default status code to 200 if null
      if (putOrPost != null && get != null && delete != null) {
        throw Exception("Please pass either put or post or get method");
      }
      statusCode ??= 200;
      final http.Response? response;
      if (putOrPost != null) {
        response = await putOrPost(
          Uri.parse(endPoint),
          body: jsonEncode(data),
          headers: {
            ...headers,
            "Authorization": "Bearer $token",
          },
        );
      } else if (get != null) {
        response = await get.call(
          Uri.parse(endPoint),
          headers: {
            ...headers,
            "Authorization": "Bearer $token",
          },
        );
      } else {
        response = await delete?.call(
          Uri.parse(endPoint),
          headers: {
            ...headers,
            "Authorization": "Bearer $token",
          },
        );
      }

      if (response == null) throw NoMethodException();
      // Check response status code
      if (response.statusCode == statusCode) {
        return jsonDecode(response.body);
      } else {
        if (wantErrorData) {
          return jsonDecode(response.body);
        } else {
          throw StatusCodeException(
              statusCode: response.statusCode,
              message: (jsonDecode(response.body))?['message'] ??
                  response.reasonPhrase ?? "Unknown error occurred");
        }
      }
    } catch (e, stackTrace) {
      log("Error while calling $endPoint", error: e, stackTrace: stackTrace);
      return null;
    }
  }
}