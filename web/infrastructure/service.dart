import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import 'api.dart';

class Service {

  Handler get handler {
    final router = Router();

    router.mount('/api/', Api().router);

    router.all('/<ignored|.*>', (Request request) {
      return Response.notFound('Page not found');
    });

    return router;
  }
}