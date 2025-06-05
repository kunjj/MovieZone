import 'package:logger/logger.dart';

final _logger = Logger(
    filter: DevelopmentFilter(), printer: PrettyPrinter(printEmojis: true, colors: true, methodCount: 0), output: ConsoleOutput());

void printLog({dynamic message, dynamic error, StackTrace? stackTrace}) =>
    error == null ? _logger.d(message) : _logger.e(message, error: error, stackTrace: stackTrace);
