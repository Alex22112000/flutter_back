import 'package:stack/stack.dart';
import '../api/i_calculator.dart';

class PostfixCalculator implements ICalculator {
  @override
  double calculate(List<String> tokens) { // передаем tokens - распарсенное выражение
    final locals = Stack<double>();

    for (final token in tokens) {
      if (double.tryParse(token) != null) {
        locals.push(double.parse(token));
      } else if (_isOperator(token)) { // проверка на то, является ли token - оператором или же числом
        if (token == '~') {
          double last = locals.isNotEmpty ? locals.pop() : 0;

          locals.push(_execute("-", 0, last));
          continue;
        }

        double second = locals.isNotEmpty ? locals.pop() : 0,
            first = locals.isNotEmpty ? locals.pop() : 0;

        locals.push(_execute(token, first, second));
      }
    }
    return locals.pop();
  }

  bool _isOperator(String token) { // доступные операторы
    return ["+", "-", "*", "/", "~"].contains(token);
  }

  double _execute(String op, double first, double second) { // что происходит при выборе оператора
    switch (op) {
      case '+':
        return first + second;
      case '-':
        return first - second;
      case '*':
        return first * second;
      case '/':
        return first / second;
      default:
        return 0;
    }
  }
}
