import 'package:url_launcher/url_launcher.dart';

final String phoneNumber = "08160081726";

Future<void> makePhoneCall(String phoneNumber) async {
  final Uri callUri = Uri(scheme: "tel", path: phoneNumber);
  if (await canLaunchUrl(callUri)) {
    await launchUrl(callUri);
  } else {
    throw "Could not call";
  }
}