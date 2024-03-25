Instruction:
1) You should have an image of card to change with assets/images/paymentcard.png
2) also i have use a condition  Responsive.isMobile(context) instead of this you can use your desired size
3) no any external package involve
4) you can use the below code to enjoy the payment card design in flutter web or mobile app








source code:

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:h_tracker_website/controllers/utils/colors.dart';
import 'package:h_tracker_website/controllers/utils/generate_unique_code.dart';
import 'package:h_tracker_website/controllers/utils/responsive.dart';
import 'package:h_tracker_website/controllers/utils/screen_size.dart';
import 'package:h_tracker_website/view/pages/event_organizer_pages/event_organizer_home_page.dart';
import 'package:h_tracker_website/view/pages/sub_pages/checkout_page.dart';

class PaymentFormForEventOrganization extends StatefulWidget {
  const PaymentFormForEventOrganization({super.key});

  @override
  State<PaymentFormForEventOrganization> createState() =>
      _PaymentFormForEventOrganizationState();
}

class _PaymentFormForEventOrganizationState
    extends State<PaymentFormForEventOrganization> {
  TextEditingController cardNumberController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController cvvController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    width: width(context) / 3.5,
                    height: width(context) / 6,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                            'assets/images/paymentcard.png'), // Replace with your image asset
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadiusDirectional.circular(8),
                    ),
                    child: Center(
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  left: Responsive.isMobile(context) == true
                                      ? 15
                                      : 20),
                              // card number
                              child: Text(
                                cardNumberController.text == ''
                                    ? "0000 0000 0000 0000"
                                    : cardNumberController.text,
                                style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                      color: Colors.white,
                                      fontSize:
                                          Responsive.isMobile(context) == true
                                              ? 8
                                              : 16,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: Responsive.isMobile(context) == true
                                  ? 15
                                  : 30,
                            ),
                            Container(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  // date
                                  Text(
                                    dateController.text == ''
                                        ? '00/00'
                                        : dateController.text,
                                    style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                          color: Colors.white,
                                          fontSize:
                                              Responsive.isMobile(context) ==
                                                      true
                                                  ? 8
                                                  : 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  // CVV
                                  Text(
                                    cvvController.text == ''
                                        ? '000'
                                        : cvvController.text,
                                    style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                          color: Colors.white,
                                          fontSize:
                                              Responsive.isMobile(context) ==
                                                      true
                                                  ? 8
                                                  : 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: width(context) / 3.5,
                    height: width(context) / 6,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 233, 229, 229),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // texfields for card entry
                            Container(
                              width: width(context) / 5,
                              height: height(context) / 9.8,
                              child: buildTextField(
                                  "Card Number", cardNumberController),
                            ),
                            SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                  width: width(context) / 10,
                                  height: height(context) / 9.8,
                                  child: buildTextField("Date", dateController),
                                ),
                                Container(
                                  width: width(context) / 10,
                                  height: height(context) / 9.8,
                                  child: buildTextField("CVV", cvvController),
                                ),
                              ],
                            ),
                            SizedBox(height: 16),
                            
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: Size(MediaQuery.of(context).size.width / 5, 60),
                backgroundColor: mainGreen,
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(10), // Set your desired radius here
                ), // Set your desired color here
              ),
              onPressed: () async {
                Navigator.of(context).pop();
                Navigator.of(context).push(
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        EventOrganizerHomePage(),
                    transitionDuration: Duration.zero,
                    reverseTransitionDuration: Duration.zero,
                  ),
                );
              },
              child: Text(
                'Submit',
                style: GoogleFonts.poppins(
                  color: secondaryColor,
                  fontSize: Responsive.isMobile(context) ? 10 : 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTextField(String label, TextEditingController controller) {
    var newDate = '';
    return label == "Card Number"
        ? TextField(
            cursorColor: mainGreen,
            controller: controller,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(16),
              CardNumberInputFormatter(),
            ],
            keyboardType: TextInputType.number,
            maxLength: 19,
            decoration: InputDecoration(
              labelText: label,
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: controller.text.isEmpty ? Colors.black : Colors.green,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.green),
              ),
            ),
            onChanged: (text) {
              setState(() {
                // Update another place when text changes
                // You can perform any other logic here
              });
            },
          )
        : TextField(
            cursorColor: mainGreen,
            controller: controller,
            keyboardType: TextInputType.number,
            maxLength: label == "Date"
                ? 5
                : label == "CVV"
                    ? 3
                    : 16,
            decoration: InputDecoration(
              labelText: label,
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: controller.text.isEmpty ? Colors.black : Colors.green,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.green),
              ),
            ),
            onChanged: (text) {
              setState(() {
                // if (label == "Date") {
                //   controller.text = formatDateString(text);
                // }
              });
            },
          );
  }
}
