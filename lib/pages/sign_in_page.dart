import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:prasad/utils/classes/globals.dart';
import 'package:prasad/utils/functions/show_error_dialog.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  PageController pageController = PageController();

  TextEditingController mobileNumberController = TextEditingController();

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: pageController,
            physics: NeverScrollableScrollPhysics(),
            children: [
              Padding(
                padding: EdgeInsetsGeometry.all(32),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 16,
                    children: [
                      Text(
                        "Sign In",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 32,
                        ),
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          labelText: "Enter Your Mobile Number",
                        ),
                        controller: mobileNumberController,
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please Enter Something";
                          }

                          if (value.length != 10) {
                            return "Mobile number should be 10 digits";
                          }

                          return null;
                        },
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: TextButton(
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              setState(() {
                                loading = true;
                              });

                              await Globals.supabase.auth.signInWithOtp(
                                phone: "+91${mobileNumberController.text}",
                              );

                              setState(() {
                                loading = false;
                              });

                              pageController.animateToPage(
                                1,
                                duration: Durations.medium1,
                                curve: Curves.bounceInOut,
                              );
                            }
                          },
                          style: TextButton.styleFrom(
                            backgroundColor: Theme.of(
                              context,
                            ).colorScheme.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadiusGeometry.circular(8),
                            ),
                          ),
                          child: Text(
                            "Send OTP",
                            style: TextStyle(
                              fontSize: 16,
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsGeometry.all(32),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 16,
                  children: [
                    Text(
                      "Enter OTP",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 32,
                      ),
                    ),
                    Text(
                      "An OTP has been sent to your mobile number.",
                      style: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).colorScheme.onSecondary,
                      ),
                    ),
                    SizedBox(height: 16),
                    OtpTextField(
                      onSubmit: (value) async {
                        setState(() {
                          loading = true;
                        });

                        try {
                          final AuthResponse response = await Globals
                              .supabase
                              .auth
                              .verifyOTP(
                                type: OtpType.sms,
                                phone: "+91${mobileNumberController.text}",
                                token: value,
                              );

                          Globals.currentUser = response.user;
                        } catch (e) {
                          if (context.mounted) {
                            showErrorDialog(context, e.toString());
                          }
                        }

                        if (context.mounted) {
                          context.go("/");
                        }
                      },
                      numberOfFields: 6,
                      showFieldAsBox: true,
                      enabledBorderColor: Theme.of(context).colorScheme.outline,
                      focusedBorderColor: Theme.of(context).colorScheme.primary,
                      textStyle: TextStyle(fontSize: 16),
                      fieldWidth: 48,
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (loading)
            Center(
              child: Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(100, 0, 0, 0),
                  borderRadius: BorderRadius.circular(8),
                ),
                width: 100,
                height: 100,
                child: SpinKitThreeBounce(
                  color: Theme.of(context).colorScheme.onSurface,
                  size: 32,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
