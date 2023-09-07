import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_brand.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tours_guide/ReUsable/Components/app_colors.dart';
import 'package:tours_guide/pages/screens/booking_screen/controller.dart';

import 'controller.dart';

class AddPaymentCard extends GetView<PersonController> {
  AddPaymentCard({super.key});

  //
  // String cardNumber = '';
  // String expiryDate = '';
  // String cardHolderName = '';
  // String cvvCode = '';
  // bool isCvvFocused = false;
  // bool useGlassMorphism = false;
  // bool useBackgroundImage = false;
  // OutlineInputBorder? border;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.arrow_back , color: Colors.white,),
        ),
        backgroundColor: Colors.blue.withOpacity(0.5),
        elevation: 0,
      ),
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: Container(

        child: Stack(
          children: [
            Container(
              height: 220,
              // padding: EdgeInsets.only(top: 5),
              width: double.infinity,
              color: Colors.blue.withOpacity(0.5),
              child: Center(
                  child: Text(
                'Add Card',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: Colors.white),
              )),
            ),
            Obx(
              () => Column(
                children: <Widget>[
                  SizedBox(
                    height: 120,
                  ),
                  CreditCardWidget(
                    glassmorphismConfig: controller.state.useGlassMorphism
                        ? Glassmorphism.defaultConfig()
                        : null,
                    cardNumber: controller.state.cardNumber.value,
                    expiryDate: controller.state.expiryDate.value,
                    cardHolderName: controller.state.cardHolderName.value,
                    cvvCode: controller.state.cvvCode.value,
                    bankName: 'Axis Bank',
                    frontCardBorder: !controller.state.useGlassMorphism
                        ? Border.all(color: Colors.grey)
                        : null,
                    backCardBorder: !controller.state.useGlassMorphism
                        ? Border.all(color: Colors.grey)
                        : null,
                    showBackView: controller.state.isCvvFocused.value,
                    obscureCardNumber: true,
                    obscureCardCvv: true,
                    isHolderNameVisible: true,
                    cardBgColor: Colors.blueGrey,
                    backgroundImage: controller.state.useBackgroundImage
                        ? 'assets/images/card_bg.png'
                        : null,
                    isSwipeGestureEnabled: true,
                    onCreditCardWidgetChange:
                        (CreditCardBrand creditCardBrand) {},
                    customCardTypeIcons: <CustomCardTypeIcon>[],
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Obx(
                        () => Column(
                          children: <Widget>[
                            CreditCardForm(
                              formKey: formKey,
                              obscureCvv: true,
                              obscureNumber: true,
                              cardNumber: controller.state.cardNumber.value,
                              cvvCode: controller.state.cvvCode.value,
                              isHolderNameVisible: true,
                              isCardNumberVisible: true,
                              isExpiryDateVisible: true,
                              cardHolderName:
                                  controller.state.cardHolderName.value,
                              expiryDate: controller.state.expiryDate.value,
                              themeColor: Colors.blue,
                              textColor: Colors.black,
                              cardNumberDecoration: InputDecoration(
                                labelText: 'Number',
                                hintText: 'XXXX XXXX XXXX XXXX',
                                hintStyle: const TextStyle(color: Colors.black),
                                labelStyle:
                                    const TextStyle(color: Colors.black),
                                focusedBorder: controller.state.border,
                                enabledBorder: controller.state.border,
                              ),
                              expiryDateDecoration: InputDecoration(
                                hintStyle: const TextStyle(color: Colors.black),
                                labelStyle:
                                    const TextStyle(color: Colors.black),
                                focusedBorder: controller.state.border,
                                enabledBorder: controller.state.border,
                                labelText: 'Expired Date',
                                hintText: 'XX/XX',
                              ),
                              cvvCodeDecoration: InputDecoration(
                                hintStyle: const TextStyle(color: Colors.black),
                                labelStyle:
                                    const TextStyle(color: Colors.black),
                                focusedBorder: controller.state.border,
                                enabledBorder: controller.state.border,
                                labelText: 'CVV',
                                hintText: 'XXX',
                              ),
                              cardHolderDecoration: InputDecoration(
                                hintStyle: const TextStyle(color: Colors.black),
                                labelStyle:
                                    const TextStyle(color: Colors.black),
                                focusedBorder: controller.state.border,
                                enabledBorder: controller.state.border,
                                labelText: 'Card Holder',
                              ),
                              onCreditCardModelChange:
                                  controller.onCreditCardModelChange,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            GestureDetector(
                              onTap: () {
                                if (formKey.currentState!.validate()) {
                                  print('valid!');
                                  controller.storeCardInfo(
                                      controller.state.cardNumber.value
                                          .toString(),
                                      controller.state.expiryDate.value
                                          .toString(),
                                      controller.state.cardHolderName.value
                                          .toString(),
                                      controller.state.cvvCode.value
                                          .toString());
                                } else {
                                  print('invalid!');
                                }
                              },
                              child: Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 8),
                                decoration: BoxDecoration(
                                  // gradient: const LinearGradient(
                                  //   colors: <Color>[
                                  //     AppColors.colorB58D67,
                                  //     AppColors.colorB58D67,
                                  //     AppColors.colorE5D1B2,
                                  //     AppColors.colorF9EED2,
                                  //     AppColors.colorFFFFFD,
                                  //     AppColors.colorF9EED2,
                                  //     AppColors.colorB58D67,
                                  //   ],
                                  //   begin: Alignment(-1, -4),
                                  //   end: Alignment(1, 4),
                                  // ),
                                  color: Colors.blue.withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(29),
                                ),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 15),
                                width: double.infinity,
                                alignment: Alignment.center,
                                child: Text(
                                  'Save',
                                  style: TextStyle(
                                    color: Colors.white,
                                    // fontFamily: 'halter',
                                    fontSize: 14.sp,
                                    package: 'flutter_credit_card',
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
