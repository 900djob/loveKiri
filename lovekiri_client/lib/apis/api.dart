import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import '../utils/util_format.dart';

typedef JsonParser<T> = T Function(dynamic body);

class SResponse<T> {
  int statusCode = 0;
  bool get isSuccess => statusCode == 200 || statusCode == 201 || statusCode == 204;
  T? body;
  ResponseMessage? message;
  String? failedBody;
}

class ResponseMessage {
  ResponseMessage(this.body);
  final String body;
  factory ResponseMessage.fromJson(Map<String, dynamic> json) => ResponseMessage(json['body'] as String);
}

class Api {
  static const bool testApi = kDebugMode && false;
  static const bool _logRequest = kDebugMode && true;
  static const bool _logHeader = kDebugMode && true;
  static const bool _logResponse = kDebugMode && true;
  static const bool _logVerbose = kDebugMode && false;
  static const bool _logResponseFail = kDebugMode && true;

  static String get apiServer => 'http://localhost:4000';
  static Client client = Client();

  static Map<String, String> headers = {
    "Content-Type": "application/json",
  };

  static set accessToken(String? token) {
    if (token == null) {
      headers.remove("Authorization");
    } else {
      headers["Authorization"] = 'Token $token';
    }
  }

  static Future<SResponse<T>> post<T>({
    required String api,
    required JsonParser<T> parser,
    dynamic params,
    required bool isVerboseLog,
  }) async {
    try {
      final body = json.encode(params ?? {});
      _printRequest("POST", api, body);
      return _getResponse<T>(
        api,
        await client.post(
          Uri.parse(Api.apiServer + api),
          headers: Api.headers,
          body: json.encode(params ?? {}),
        ),
        parser,
        isVerboseLog,
      );
    } catch (e, stackTrace) {
      debugPrint(e.toString());
      await Sentry.captureException(e, stackTrace: stackTrace);
      return SResponse<T>();
    }
  }

  static Future<SResponse<T>> get<T>({
    required String api,
    required JsonParser<T> parser,
    required bool isVerboseLog,
  }) async {
    try {
      _printRequest("GET", api);
      return await _getResponse<T>(
        api,
        await client.get(
          Uri.parse(Api.apiServer + api),
          headers: Api.headers,
        ),
        parser,
        isVerboseLog,
      );
    } catch (e) {
      return SResponse<T>();
    }
  }

  static Future<SResponse<T>> patch<T>({
    required String api,
    required JsonParser<T> parser,
    dynamic params,
    required bool isVerboseLog,
  }) async {
    try {
      final body = json.encode(params ?? {});
      _printRequest("PATCH", api, body);
      return _getResponse<T>(
        api,
        await client.patch(
          Uri.parse(Api.apiServer + api),
          headers: Api.headers,
          body: body,
        ),
        parser,
        isVerboseLog,
      );
    } catch (e) {
      return SResponse<T>();
    }
  }

  static Future<SResponse<T>> delete<T>({
    required String api,
    required JsonParser<T> parser,
    Map<String, dynamic>? params,
    required bool isVerboseLog,
  }) async {
    try {
      final body = json.encode(params ?? {});
      _printRequest("DELETE", api, body);
      return _getResponse<T>(
        api,
        await client.delete(
          Uri.parse(Api.apiServer + api),
          headers: Api.headers,
          body: body,
        ),
        parser,
        isVerboseLog,
      );
    } catch (e) {
      return SResponse<T>();
    }
  }

  static Future<SResponse<T>> _getResponse<T>(
    String api,
    Response response,
    JsonParser<T> parse,
    bool isVerboseLog,
  ) async {
    final ret = SResponse<T>();
    final int statusCode = ret.statusCode = response.statusCode;
    if (statusCode == 200 || statusCode == 201 || statusCode == 204 || statusCode == 400 || statusCode == 404) {
      dynamic jsonbody;
      try {
        if (response.bodyBytes.isNotEmpty) {
          jsonbody = json.decode(utf8.decode(response.bodyBytes));
        }
      } catch (_) {
        ret.failedBody = response.body;
      }
      if (jsonbody is Map<String, dynamic>) {
        if (ret.isSuccess) {
          final data = jsonbody["data"];
          try {
            ret.body = parse(data ?? jsonbody);
          } catch (e, stacktrace) {
            ret.failedBody = stacktrace.toString();
          }
        } else {
          ret.failedBody = response.body;
        }
        if (jsonbody["message"] != null) {
          ret.message = ResponseMessage.fromJson(jsonbody["message"]);
        }
      } else {
        ret.failedBody = response.body;
      }
    } else {
      ret.failedBody = response.body;
    }
    if (ret.message != null) {
      debugPrint('message: ${ret.message!.body}');
    }
    if (ret.isSuccess && _logResponse) {
      final body = ret.body;
      debugPrint('[API][$statusCode] $api ${ret.failedBody ?? ''}${ret.failedBody != null ? ' ' : ''}${UtilFormat.bzRuntimeType(body)} ${_logVerbose || isVerboseLog ? json.encode(body) : ""}');
    } else if (!ret.isSuccess && _logResponseFail) {
      final failedMessage = '[API][$statusCode] $api ${ret.failedBody}';
      debugPrint(failedMessage);
    }
    return ret;
  }

  static void _printRequest(String method, String api, [String? body]) {
    if (_logRequest) {
      debugPrint('[API][$method] $api ${_logHeader ? "[HEADER] ${json.encode(Api.headers)}" : ""}${body != null ? ((_logHeader ? ", [BODY] " : "") + body) : ""}');
    }
  }
}
