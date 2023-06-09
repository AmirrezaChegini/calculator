import 'package:get/get.dart';
import 'package:math_expressions/math_expressions.dart';

class CalController extends GetxController {
  var exp = ''.obs;
  var result = ''.obs;

  void calculate(String x) {
    List<String> clearsResult = ['C', 'DE', '='];

    if (!clearsResult.contains(x) && result.isNotEmpty) {
      exp.value = result.value;
      result.value = '';
      exp.value += x;
    } else if (!clearsResult.contains(x)) {
      exp.value += x;
    } else if (x == 'DE') {
      if (exp.value.isNotEmpty) {
        exp.value = exp.value.substring(0, exp.value.length - 1);
      }
    } else if (x == 'C') {
      exp.value = '';
      result.value = '';
    } else {
      try {
        Parser parser = Parser();
        Expression e = parser.parse(exp.replaceAll('x', '*'));
        ContextModel cm = ContextModel();
        String temp = e.evaluate(EvaluationType.REAL, cm).toString();
        result.value = temp == 'Infinity' ? '' : temp;
      } catch (_) {}
    }
  }
}
