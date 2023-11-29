import 'package:logger/logger.dart';

// 애플리케이션 개발에 필요한 Logger 객체 정의

var logger = Logger(
  printer: PrettyPrinter(
    methodCount: 1,
    lineLength: 160,
    colors: false,
    printEmojis: true,
    noBoxingByDefault: false,
  ),
);
