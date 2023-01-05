import 'dart:io';

import 'package:flutter_erp/app/data/exceptions/api_exception.dart';
import 'package:flutter_erp/app/data/services/token_service.dart';
import 'package:flutter_erp/app/data/utils/keys.dart';
import 'package:get/get.dart';

abstract class Provider<T> extends GetConnect {
  final String path;

  Provider({required this.path});

  @override
  void onInit() {
    httpClient.baseUrl = "$host$path";
    String token = Get.find<TokenService>().readToken();
    httpClient.addRequestModifier<Object?>((request) {
      request.headers['Authorization'] = "Bearer $token";
      return request;
    });
    httpClient.addAuthenticator<Object?>((request) {
      request.headers['Authorization'] = "Bearer $token";
      return request;
    });
    super.onInit();
  }

  Future insert(T value);
  Future<List<T>> fetch({int? limit, int? offset});
  Future<T> fetchOne(int id);
  Future update(T value);
  Future destroy(T value);
  Future destroyMany(List<T> value);

  @override
  Future<Response<T>> get<T>(String url,
      {Map<String, String>? headers,
      String? contentType,
      Map<String, dynamic>? query,
      Decoder<T>? decoder}) async {
    Response<T> response = await super.get<T>(url,
        headers: headers,
        query: query,
        decoder: decoder,
        contentType: contentType);
    _verifyStatus(response, [HttpStatus.ok]);
    return response;
  }

  @override
  Future<Response<T>> post<T>(String? url, body,
      {String? contentType,
      Map<String, String>? headers,
      Map<String, dynamic>? query,
      Decoder<T>? decoder,
      Progress? uploadProgress}) async {
    Response<T> response = await super.post(
      url,
      body,
      contentType: contentType,
      headers: headers,
      query: query,
      decoder: decoder,
      uploadProgress: uploadProgress,
    );
    _verifyStatus(response, [HttpStatus.ok, HttpStatus.created]);
    return response;
  }

  @override
  Future<Response<T>> put<T>(String url, body,
      {String? contentType,
      Map<String, String>? headers,
      Map<String, dynamic>? query,
      Decoder<T>? decoder,
      Progress? uploadProgress}) async {
    Response<T> response = await super.put(url, body,
        contentType: contentType,
        headers: headers,
        query: query,
        decoder: decoder,
        uploadProgress: uploadProgress);
    _verifyStatus(response, [HttpStatus.ok]);
    return response;
  }

  @override
  Future<Response<T>> delete<T>(String url,
      {Map<String, String>? headers,
      String? contentType,
      Map<String, dynamic>? query,
      Decoder<T>? decoder}) async {
    Response<T> response = await super.delete(url,
        headers: headers,
        contentType: contentType,
        query: query,
        decoder: decoder);
    _verifyStatus(response, [HttpStatus.ok, HttpStatus.accepted]);
    return response;
  }

  void _verifyStatus(Response response, List<int> allowedStatuses) {
    if (!allowedStatuses.contains(response.statusCode)) {
      throw ApiException(
        status: response.statusCode ?? HttpStatus.internalServerError,
        message: (response.body as Map)[messageKey],
      );
    }
  }
}
