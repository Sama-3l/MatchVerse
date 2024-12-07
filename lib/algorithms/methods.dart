import 'package:flutter/cupertino.dart';
import 'package:matchverse/constants/colors.dart';
import 'package:matchverse/constants/enum.dart';

class Methods {
  Color getOrderCardColor(CardType cardType) {
    switch (cardType) {
      case CardType.normal:
      case CardType.waitingForOrder:
      case CardType.awaitingDelivery:
      case CardType.leave:
        return AppColors.transparent;
      case CardType.awaitingAccess:
      case CardType.adminReported:
        return AppColors.red;
      case CardType.closed:
        return AppColors.actionOrange;
      case CardType.createdByUser:
        return AppColors.green;
    }
  }

  Future<bool> matchFound() async {
    await Future.delayed(const Duration(seconds: 2));
    return true;
  }
}
