import 'dart:convert';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import '../domain/calculator_sevice_factory.dart';

class Api {

  final _calculatorService = CalculatorServiceFactory.create(CalculatorServiceType.postfix);

  Future<Response> _calculations(Request request) async {
    print("back");
    await Future.delayed(Duration(seconds: 3));
    final jsonBody = await request.readAsString();
    final body = json.decode(jsonBody);

    final expression = body['expression'];
    try {
      final result = _calculatorService.calculate(expression);
      return Response.ok(result.toString());
    } catch (e) {
      return Response.badRequest();
    }
  }

  Router get router {
    final router = Router();

    router.post('/calculations', _calculations);

    router.all('/<ignored|.*>', (Request request) => Response.notFound('null'));
    return router;
  }
}