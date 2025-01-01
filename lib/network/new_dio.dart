import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

String baseURL = "https://inventory-app-1-7daj.onrender.com/";

connect({bool? useFormData}) {
  BaseOptions options = BaseOptions(
      baseUrl: baseURL,
      connectTimeout: const Duration(seconds: 60),
      receiveTimeout: const Duration(seconds: 60),
      responseType: ResponseType.plain);
  Dio dio = Dio(options);
  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) async {
        debugPrint(options.uri.path);
        debugPrint(options.data.toString());
        options.headers['Content-Type'] = useFormData == true? 'multipart/form-data': "application/json";
        return handler.next(options);
      },
      onResponse: (response, handler) async {
        debugPrint("SERVER RESPONSE::: ${response.data}");
        return handler.next(response);
      },
      onError: (DioError e, handler) async {
        try{
          ResModel resModel = ResModel.fromJson(jsonDecode(e.response?.data));
          if(resModel.message!=null){
            log("ERROR MESSAGE::::<1>:::: ${resModel.message??""}, from ${e.requestOptions.path}");
          }else if(resModel.error!=null){
            log("ERROR MESSAGE::::<2>:::: ${jsonEncode(resModel.data)}, from ${e.requestOptions.path}");
          }else{
            log("ERROR MESSAGE::::<3>:::: ${resModel.message??""}, from ${e.requestOptions.path}");
          }
          // return handler.next(e.response?.data);
          return handler.next(DioException(requestOptions: RequestOptions(data: jsonDecode(e.response?.data)))) ;
        }on DioException catch (err){
          log("Error ${options.method}ing data from ${options.baseUrl} :: ${err.message} :: ${err.error?.toString()}");
          return handler.next(DioException(requestOptions: RequestOptions(data: err)));
        }catch (err){
          log("Error ${options.method}ing data from ${options.baseUrl} :: ${err.toString()}");
          return handler.next(DioException(requestOptions: RequestOptions(data: err)));
        }
      },
    ),
  );

  return dio;
}

privateConnect({bool? useFormData}) {
  BaseOptions options = BaseOptions(
      baseUrl: baseURL,
      connectTimeout: const Duration(seconds: 60),
      receiveTimeout: const Duration(seconds: 60),
      responseType: ResponseType.plain);
  Dio dio = Dio(options);
  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) async {

        options.headers['Content-Type'] = "application/json";
        return handler.next(options);
      },
      onResponse: (response, handler) async {
        return handler.next(response);
      },
      onError: (DioError e, handler) async {
        try{
          ResModel resModel = ResModel.fromJson(jsonDecode(jsonEncode(e.response?.data)));
          // if(resModel.message!=null){
          //   toastBar(resModel.message??"", AppStrings.error);
          // }else if(resModel.error!=null){
          //   toastBar(resModel.error??"", AppStrings.error);
          // }else{
          //   toastBar(resModel.data.toString(), AppStrings.error);
          // }
          // return handler.next(e);
          throw Exception("Error ${options.method}ing data from ${options.baseUrl} :: ${e.response?.toString()}");
        }catch (err){
          throw Exception("Error ${options.method}ing data from ${options.baseUrl} :: ${err.toString()}");
        }
      },
    ),
  );

  return dio;
}







ResModel resModelFromJson(String str) => ResModel.fromJson(json.decode(str));
String resModelToJson(ResModel data) => json.encode(data.toJson());

String resModelDataToString(dynamic data) => json.encode(data);
dynamic resModelDataToJson(String data) => json.decode(data);

class ResModel {
  String? message;
  bool? success;
  dynamic status;
  String? error;
  String? token;
  dynamic data;

  ResModel({this.message, this.success, this.error, this.token, this.status, this.data});

  ResModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    success = json['success'];
    token = json['token'];
    error = json['error'];
    data = json["data"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['status'] = status;
    data['token'] = token;
    data['success'] = success;
    data['error'] = error;
    data['data'] = data;
    return data;
  }
}
