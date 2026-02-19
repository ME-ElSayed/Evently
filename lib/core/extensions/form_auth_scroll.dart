import 'package:flutter/material.dart';

extension FormAuthScroll on GlobalKey<FormState> {
  bool validateAndScroll() {
    final bool isValid = currentState?.validate() ?? false;
    if (!isValid) {
      Element? firstErrorElemet;
      void findFisrtError(Element element) {
        if (firstErrorElemet != null) return;
        if (element.widget is FormField) {
          final state = (element as StatefulElement).state;
          if (state is FormFieldState && state.hasError) {
            firstErrorElemet = element;
            return;
          }
        }
        element.visitChildren(findFisrtError);
      }

      currentContext?.visitChildElements(findFisrtError);
      if (firstErrorElemet != null) {
        Scrollable.ensureVisible(
          firstErrorElemet!,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          alignment: 0.1,
        );
      }
    }
    return isValid;
  }
}
