import 'package:flutter/material.dart';

class CalculatorController {
  final TextEditingController textController = TextEditingController();
  double? firstOperand;
  double? secondOperand;
  String? operator;
  String operationDetails = "";

  // Logic for button press
  void onButtonPressed(String symbol) {
    if (symbol == "C") {
      // Clear input
      textController.clear();
      firstOperand = null;
      secondOperand = null;
      operator = null;
      operationDetails = "";
    } else if (symbol == "<-") {
      // Delete last character
      if (textController.text.isNotEmpty) {
        textController.text =
            textController.text.substring(0, textController.text.length - 1);
      }
    } else if (symbol == "=") {
      // Perform calculation
      if (firstOperand != null &&
          operator != null &&
          textController.text.isNotEmpty) {
        secondOperand = double.tryParse(textController.text);
        if (secondOperand != null) {
          double result;
          switch (operator) {
            case "+":
              result = firstOperand! + secondOperand!;
              break;
            case "-":
              result = firstOperand! - secondOperand!;
              break;
            case "*":
              result = firstOperand! * secondOperand!;
              break;
            case "/":
              result = secondOperand != 0
                  ? firstOperand! / secondOperand!
                  : double.nan;
              break;
            case "%":
              result = firstOperand! % secondOperand!;
              break;
            default:
              result = 0;
          }

          // Update operation details before clearing values
          operationDetails = '$firstOperand   $operator     $secondOperand';
          textController.text = result.toString();
          firstOperand = null;
          secondOperand = null;
          operator = null;
        }
      }
    } else if (["+", "-", "*", "/", "%"].contains(symbol)) {
      // Save the first operand and operator
      if (textController.text.isNotEmpty) {
        firstOperand = double.tryParse(textController.text);
        operator = symbol;
        textController.clear();
      }
    } else {
      // Append number or dot
      if (symbol == "." && textController.text.contains(".")) {
        return; // Prevent multiple dots
      }
      textController.text += symbol;
    }
  }

  // Method to get operation details
  String getOperationDetails() {
    return operationDetails.isNotEmpty
        ? operationDetails
        : "No operation performed yet";
  }
}
