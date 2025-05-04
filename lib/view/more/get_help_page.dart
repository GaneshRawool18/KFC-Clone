import 'dart:developer';

import 'package:flutter/material.dart';

class GetHelpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isSmallScreen = screenWidth < 600; 

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'GET HELP',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.05, 
          vertical: screenHeight * 0.03, 
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: screenHeight * 0.02),
            Center(
              child: Text(
                'HOW CAN WE HELP YOU?',
                style: TextStyle(
                  fontSize: isSmallScreen ? 18 : 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.04),
            Text(
              'NEAREST KFC',
              style: TextStyle(
                fontSize: isSmallScreen ? 14 : 16,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
            Divider(
              color: Colors.grey[300],
              thickness: 1,
              height: screenHeight * 0.02,
            ),
            SizedBox(height: screenHeight * 0.02),
            Center(
              child: SizedBox(
                width: screenWidth * 0.8,
                height: isSmallScreen ? 45 : 50,
                child: OutlinedButton(
                  onPressed: () {
                    
                    log('Call Restaurant');
                  },
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.black87),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text(
                    'Call Restaurant',
                    style: TextStyle(
                      fontSize: isSmallScreen ? 16 : 18,
                      color: Colors.black87,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.06),
            Text(
              'NEED TO TALK?',
              style: TextStyle(
                fontSize: isSmallScreen ? 14 : 16,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
            Text(
              'Call us.',
              style: TextStyle(
                fontSize: isSmallScreen ? 12 : 14,
                color: Colors.grey[600],
              ),
            ),
            Divider(
              color: Colors.grey[300],
              thickness: 1,
              height: screenHeight * 0.02,
            ),
            SizedBox(height: screenHeight * 0.02),
            Center(
              child: SizedBox(
                width: screenWidth * 0.8,
                height: isSmallScreen ? 45 : 50,
                child: OutlinedButton(
                  onPressed: () {
                    
                    log('Call Us');
                  },
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.black87),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text(
                    'Call Us',
                    style: TextStyle(
                      fontSize: isSmallScreen ? 16 : 18,
                      color: Colors.black87,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.06),
            Text(
              'CONTACT US',
              style: TextStyle(
                fontSize: isSmallScreen ? 14 : 16,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
            Text(
              'Have an issue with your order?',
              style: TextStyle(
                fontSize: isSmallScreen ? 12 : 14,
                color: Colors.grey[600],
              ),
            ),
            Divider(
              color: Colors.grey[300],
              thickness: 1,
              height: screenHeight * 0.02,
            ),
            SizedBox(height: screenHeight * 0.02),
            Center(
              child: SizedBox(
                width: screenWidth * 0.8,
                height: isSmallScreen ? 45 : 50,
                child: OutlinedButton(
                  onPressed: () {
                    
                    log('Contact Us');
                  },
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.black87),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text(
                    'Contact Us',
                    style: TextStyle(
                      fontSize: isSmallScreen ? 16 : 18,
                      color: Colors.black87,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}