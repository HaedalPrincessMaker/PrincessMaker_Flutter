import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

const String myserver = "http://172.30.1.47:8080";

Dio pmdio = new Dio();

final pmLogger = new Logger();