import 'dart:developer';
import 'package:flutter/material.dart';

class GiftCardPage extends StatelessWidget {
  final TextEditingController _recipientEmailController =
      TextEditingController();
  final TextEditingController _yourNameController = TextEditingController();
  final TextEditingController _yourEmailController = TextEditingController();
  final TextEditingController _yourPhoneController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'GIFT CARD',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.05,
          vertical: screenHeight * 0.02,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: screenHeight * 0.02),
            Center(
              child: Text(
                'KFC GIFT CARD',
                style: TextStyle(
                  fontSize: screenWidth * 0.06,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.02),
            Center(
              child: SizedBox(
                width: screenWidth * 0.4,
                height: screenHeight * 0.055,
                child: OutlinedButton(
                  onPressed: () {
                    log('Check Balance');
                  },
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.black87,
                    side: const BorderSide(
                        color: Color.fromARGB(221, 233, 230, 230)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text(
                    'Check Balance',
                    style: TextStyle(
                      fontSize: screenWidth * 0.03,
                      color: const Color.fromARGB(221, 238, 235, 235),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.05),
            Text(
              'BUY A KFC GIFT CARD',
              style: TextStyle(
                fontSize: screenWidth * 0.045,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            Divider(
              color: Colors.grey[300],
              thickness: 1,
              height: screenHeight * 0.03,
            ),
            SizedBox(height: screenHeight * 0.02),
            Center(
              child: Container(
                width: screenWidth * 0.8,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.red,
                ),
                padding: EdgeInsets.all(screenWidth * 0.05),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'GIFT CARD',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: screenWidth * 0.045,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.01),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'IT\'S FINGER LICKIN\' GOOD',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: screenWidth * 0.035,
                          ),
                        ),
                        Text(
                          'KFC',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: screenWidth * 0.04,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.04),
            Text(
              'GIFT AMOUNT',
              style: TextStyle(
                fontSize: screenWidth * 0.045,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: screenHeight * 0.01),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildAmountButton(context, '₹250', screenWidth * 0.04),
                _buildAmountButton(context, '₹500', screenWidth * 0.04),
                _buildAmountButton(context, '₹1000', screenWidth * 0.04),
              ],
            ),
            SizedBox(height: screenHeight * 0.05),
            Text(
              'INFORMATION',
              style: TextStyle(
                fontSize: screenWidth * 0.045,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            Divider(
              color: Colors.grey[300],
              thickness: 1,
              height: screenHeight * 0.03,
            ),
            _buildTextField(context, 'Recipient Email*',
                _recipientEmailController, screenWidth * 0.035),
            _buildTextField(context, 'Your Name*', _yourNameController,
                screenWidth * 0.035),
            _buildTextField(context, 'Your Email*', _yourEmailController,
                screenWidth * 0.035,
                keyboardType: TextInputType.emailAddress),
            _buildTextField(context, 'Your Phone Number*', _yourPhoneController,
                screenWidth * 0.035,
                keyboardType: TextInputType.phone),
            SizedBox(height: screenHeight * 0.04),
            Text(
              'MESSAGE',
              style: TextStyle(
                fontSize: screenWidth * 0.045,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: screenHeight * 0.01),
            TextFormField(
              controller: _messageController,
              maxLines: 3,
              style: TextStyle(fontSize: screenWidth * 0.035),
              decoration: InputDecoration(
                hintText: 'Enter message here.',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.04),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                OutlinedButton(
                  onPressed: () {
                    log('Cancel');
                  },
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.black87),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.1,
                      vertical: screenHeight * 0.015,
                    ),
                  ),
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                      fontSize: screenWidth * 0.04,
                      color: Colors.black87,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    log('Continue to Pay');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black87,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.1,
                      vertical: screenHeight * 0.015,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    textStyle: TextStyle(
                      fontSize: screenWidth * 0.03,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  child: const Text('Continue to Payment'),
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.05),
            Text(
              'Terms & Conditions',
              style: TextStyle(
                fontSize: screenWidth * 0.045,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: screenHeight * 0.01),
            Text(
              'KFC Gift Card and Gift Voucher is issued by YUM! Restaurants India Pvt. Ltd. "YUM!" & its authorized franchisee for making payments at selective and participating KFC Restaurants in India. KFC Gift Voucher (purchased from KFC website) can be redeemed at selective and participating KFC Restaurants in India. For detailed terms and conditions, please visit [link to terms and conditions].',
              style: TextStyle(
                fontSize: screenWidth * 0.035,
                color: Colors.grey[700],
              ),
            ),
            SizedBox(height: screenHeight * 0.03),
          ],
        ),
      ),
    );
  }

  Widget _buildAmountButton(
      BuildContext context, String amount, double fontSize) {
    return OutlinedButton(
      onPressed: () {
        log('Selected amount: $amount');
      },
      style: OutlinedButton.styleFrom(
        side: const BorderSide(color: Colors.black87),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.04,
          vertical: MediaQuery.of(context).size.width * 0.02,
        ),
      ),
      child: Text(
        amount,
        style: TextStyle(
          fontSize: fontSize,
          color: Colors.black87,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildTextField(BuildContext context, String label,
      TextEditingController controller, double fontSize,
      {TextInputType? keyboardType}) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height * 0.015),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        style: TextStyle(fontSize: fontSize),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(
            fontSize: fontSize,
            color: Colors.black87,
            fontWeight: FontWeight.w500,
          ),
          border: const UnderlineInputBorder(),
        ),
      ),
    );
  }
}
