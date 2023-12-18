import 'api/i_calculator.dart';
import 'api/i_calculator_service.dart';
import 'api/i_expression_parser.dart';
import 'calculator_service.dart';
import 'postfix/postfix_calculator.dart';
import 'postfix/postfix_expression_parser.dart';

enum CalculatorServiceType { postfix }

class CalculatorServiceFactory {
  static ICalculatorService create(CalculatorServiceType type) {
    IExpressionParser parser;
    ICalculator calculator;

    switch (type) {
      case CalculatorServiceType.postfix:
        {
          parser = PostfixExpressionParser();
          calculator = PostfixCalculator();
          break;
        }
      default:
        {
          parser = PostfixExpressionParser();
          calculator = PostfixCalculator();
          break;
        }
    }

    return CalculatorService(parser, calculator);
  }
}
