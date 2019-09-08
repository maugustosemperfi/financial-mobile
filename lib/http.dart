import 'dart:io';
import 'package:dio/dio.dart';

var dio = Dio(BaseOptions(
  baseUrl: "http://localhost:3000/",
  connectTimeout: 5000,
  receiveTimeout: 100000,
  headers: {
    HttpHeaders.userAgentHeader: "dio",
    "api": "1.0.0",
  },
  contentType: ContentType.json,
  // Transform the response data to a String encoded with UTF8.
  // The default value is [ResponseType.JSON].
  responseType: ResponseType.json,
));
