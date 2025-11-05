import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:otp_autofill/otp_autofill.dart';
import 'package:prasad/utils/classes/globals.dart';
import 'package:prasad/utils/functions/show_error_dialog.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  GlobalKey<FormState> phoneNumberFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> otpFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> nameFormKey = GlobalKey<FormState>();

  PageController pageController = PageController();

  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  OTPTextEditController otpController = OTPTextEditController(codeLength: 6);

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(32.0),
            child: PageView(
              controller: pageController,
              physics: NeverScrollableScrollPhysics(),
              children: [
                Form(
                  key: phoneNumberFormKey,
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
                            if (phoneNumberFormKey.currentState!.validate()) {
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

                              setState(() {
                                otpController =
                                    OTPTextEditController(
                                      codeLength: 6,
                                      onCodeReceive: (code) {
                                        setState(() {
                                          otpController.text = code;
                                        });
                                      },
                                    )..startListenUserConsent((code) {
                                      final exp = RegExp(r'(\d{6})');
                                      return exp.stringMatch(code ?? '') ?? '';
                                    });
                              });
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
                Form(
                  key: otpFormKey,
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
                      SizedBox(height: 8),
                      TextFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          labelText: "Enter OTP",
                        ),
                        controller: otpController,
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please Enter Something";
                          }

                          if (value.length != 6) {
                            return "OTP should be 10 digits";
                          }

                          return null;
                        },
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: TextButton(
                          onPressed: () async {
                            if (otpFormKey.currentState!.validate()) {
                              setState(() {
                                loading = true;
                              });

                              try {
                                final AuthResponse response = await Globals
                                    .supabase
                                    .auth
                                    .verifyOTP(
                                      type: OtpType.sms,
                                      phone:
                                          "+91${mobileNumberController.text}",
                                      token: otpController.text,
                                    );

                                Globals.currentUser = response.user;

                                final data = await Globals.supabase
                                    .from('users')
                                    .select()
                                    .eq('user_id', response.user!.id);

                                if (data.isNotEmpty) {
                                  if (context.mounted) {
                                    context.go('/');
                                  }
                                } else {
                                  pageController.animateToPage(
                                    2,
                                    duration: Durations.medium1,
                                    curve: Curves.bounceInOut,
                                  );
                                }
                              } catch (e) {
                                if (context.mounted) {
                                  showErrorDialog(context, e.toString());
                                }
                              }
                              setState(() {
                                loading = false;
                              });
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
                            "Verify",
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
                Form(
                  key: nameFormKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 16,
                    children: [
                      Text(
                        "Complete Profile",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 32,
                        ),
                      ),
                      TextFormField(
                        controller: nameController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          labelText: "Enter Your Name",
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please Enter Something";
                          }

                          return null;
                        },
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: TextButton(
                          onPressed: () async {
                            if (phoneNumberFormKey.currentState!.validate()) {
                              setState(() {
                                loading = true;
                              });

                              await Globals.supabase.from('users').insert({
                                "user_id": Globals.currentUser!.id,
                                "name": nameController.text,
                              });

                              if (context.mounted) {
                                context.go("/");
                              }
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
                            "Continue",
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
              ],
            ),
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
