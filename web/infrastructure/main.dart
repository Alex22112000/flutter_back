import 'dart:io';

import 'package:shelf/shelf_io.dart' as shelf_io;
import 'service.dart';

void main() async {
  final service = Service();

  final server = await shelf_io.serve(service.handler, InternetAddress.anyIPv4, 8080);
  
  print('Serving at http://${InternetAddress.anyIPv4.toString()}:${server.port}');
}