import 'package:get/get.dart';

class CalculatorController extends GetxController {
  
  // .bs con el getx para convertir las varialbes en observables
  // ayudan a getx a saber si hay cambios en los valores redibujen lo que se necesite

  // Se puede poner RxTypeData en lugar de var, pero var es mejor visiblemente
  var firstNumber   = '10'.obs;
  var secondNumber  = '20'.obs;
  var mathResult    = '30'.obs;
  var operation     = '+'.obs;


  void resetAC(){
    firstNumber.value  = '0';    // firstNumber = '0'.obs; // Misma instruccion
    secondNumber.value = '0';
    mathResult.value   = '0';
    operation.value    = '+';
  }

  addNumber( String number ){
    if ( mathResult.value == '0' ){
      return mathResult.value = number;
    }

    if ( mathResult.value == '-0' )
      return mathResult.value = '-' + number;
    
    mathResult.value = mathResult.value + number;
  }

  changeSign(){
    if ( mathResult.startsWith('-') ) {  // Como getx ya sabe que es un string, no se necesita usar la siguiente instruccion:
                                         // mathResult.value.startsWith('-')
      mathResult.value = mathResult.value.replaceFirst('-', '');
    } else {
      mathResult.value = '-' + mathResult.value;
    }
  }

  addDecimaPoint(){
    if ( mathResult.contains('.') ) return;

    if ( mathResult.startsWith('0') ){
      mathResult.value = '0.';
    } else {
      mathResult.value = mathResult.value + '.';
    }
  }

  selectOperation( String newOperation ){

    operation.value = newOperation;
    firstNumber.value = mathResult.value;
    mathResult.value = '0';

  }

  deleteLastEntry(){

    if ( mathResult.value.replaceAll('-', '').length > 1 ){
      mathResult.value = mathResult.value.substring(0, mathResult.value.length - 1);
    } else {
      mathResult.value = '0';
    }

  }

  calculateResult(){

    double num1 = double.parse(firstNumber.value);
    double num2 = double.parse(mathResult.value);

    secondNumber.value = mathResult.value;

    switch(operation.value){
      case '+':
        mathResult.value = '${ num1 + num2 }';
        break;
      case '-':
        mathResult.value = '${ num1 - num2 }';
        break;
      case 'X':
        mathResult.value = '${ num1 * num2 }';
        break;
      case '/':
        mathResult.value = '${ num1 / num2 }';
        break;

      default:
        return;
    }

    if ( mathResult.value.endsWith('.0') ){
      mathResult.value = mathResult.substring(0, mathResult.value.length - 2);
    }

  }

}