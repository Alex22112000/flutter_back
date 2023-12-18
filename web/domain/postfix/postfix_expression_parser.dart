import 'package:stack/stack.dart';
import '../api/i_expression_parser.dart';

class PostfixExpressionParser implements IExpressionParser {
  late int _pos;

  final Map<String, int> _operationPriority = { // приоритеты операторов
    '(': 0,
    '+': 1,
    '-': 1,
    '*': 2,
    '/': 2,
    '~': 3,
  };

  @override
  List<String> parse(String infixExpr) { // перевод в постфиксную запись, путем разбиения строки на tokens
    List<String> tokens = <String>[];
    Stack<String> stack = Stack<String>();

    for (_pos = 0; _pos < infixExpr.length; _pos++) {
      String c = infixExpr[_pos];

      if (double.tryParse(c) != null) {
        tokens.add(_getStringNumber(infixExpr));
      } else if (c == '(') {
        stack.push(c);
      } else if (c == ')') {
        while (stack.isNotEmpty && stack.top() != '(') {
          tokens.add(stack.pop());
        }

        stack.pop();
      } else if (_operationPriority.keys.contains(c)) {
        String op = c;

        if (op == '-' &&
            (_pos == 0 ||
                (_pos > 1 &&
                    _operationPriority.keys.contains(infixExpr[_pos - 1])))) {
          op = '~';
        }

        while (stack.isNotEmpty &&
            _operationPriority[stack.top()]! >= _operationPriority[op]!) {
          tokens.add(stack.pop());
        }

        stack.push(op);
      }
    }

    while (stack.isNotEmpty) {
      tokens.add(stack.pop());
    }

    return tokens;
  }

  String _getStringNumber(String expr) {
    String strNumber = '';

    for (; _pos < expr.length; _pos++) {
      String num = expr[_pos];
      if (double.tryParse(num) != null || num == ".") {
        strNumber += num;
      } else {
        _pos--;
        break;
      }
    }

    return strNumber;
  }
}
