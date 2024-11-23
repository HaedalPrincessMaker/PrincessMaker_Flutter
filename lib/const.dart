import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

const String myserver = "http://172.20.78.126:8080";

Dio pmdio = new Dio();

final pmLogger = new Logger();