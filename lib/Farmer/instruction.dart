import 'package:flutter/material.dart';

String instructionsForFarmers = '''
1. Download and Install the App:
   - Visit your device's app store (e.g., Google Play Store or Apple App Store).
   - Search for the dairy app by its name.
   - Tap on the app and click on the "Install" or "Get" button to download and install it on your device.

2. Create an Account:
   - Launch the app on your device.
   - Tap on the "Sign Up" or "Create Account" option.
   - Provide the required information such as your name, email address, and phone number.
   - Create a strong password and enter it in the designated field.
   - Agree to the app's terms and conditions, if prompted.
   - Tap on the "Sign Up" or "Create Account" button to complete the registration process.

3. Set Up Your Profile:
   - After creating an account, you may be prompted to set up your profile.
   - Upload a profile picture (optional).
   - Provide details such as your location, farm name, and any other relevant information.
   - Save the changes once you have filled in the necessary information.

4. Explore the App's Features:
   - Familiarize yourself with the app's user interface and navigation.
   - Explore the different sections and features available, such as Home, Requests, Notifications, Profile, and Settings.
   - Take note of any additional features specific to farmers, such as adding livestock or managing farm details.

5. Make Requests for Collectors:
   - Access the "Requests" section of the app.
   - Tap on the "Create New Request" or a similar button.
   - Specify the details of the request, such as the type and quantity of dairy products you want to sell.
   - Set the desired price or indicate if you are open to negotiation.
   - Add any additional information or requirements, such as delivery preferences or quality specifications.
   - Review the request details and submit it.

6. Respond to Collector Requests:
   - Check the "Requests" section periodically to see if any collectors have responded to your requests.
   - Review the received offers, including the collector's details, proposed price, and any additional information.
   - Evaluate the offers based on your preferences and requirements.
   - Accept an offer by tapping on the appropriate button, or decline if it doesn't meet your needs.

7. Communicate with Collectors:
   - The app may provide a messaging or chat feature.
   - Use this feature to communicate with collectors regarding request details, negotiation, or any other relevant information.
   - Be prompt and clear in your communication to ensure a smooth transaction.

8. Manage Your Transactions:
   - Once you have agreed upon an offer, make arrangements with the collector for the transaction, such as delivery or pickup.
   - Keep track of your transactions within the app, ensuring you mark them as complete or pending as necessary.
   - Maintain a record of your transactions for future reference.

9. Provide Feedback:
   - If the app has a feedback or rating system, use it to provide feedback about the collector and the overall experience.
   - Rate the collector based on their professionalism, timeliness, and adherence to the agreed-upon terms.
   - Your feedback can help improve the app's functionality and assist other farmers in making informed decisions.

''';

class Instructions extends StatelessWidget {
  const Instructions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Instructions'),
      ),
      body: SingleChildScrollView(
          child: Center(
              child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Text(
          instructionsForFarmers,
          style: TextStyle(
            fontSize: 24,
          ),
        ),
      ))),
    );
  }
}
