import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

const String myserver = "http://10.0.2.2:8080";

Dio pmdio = new Dio();

final pmLogger = new Logger();

String fffcm = "";

List<String> notice = [];