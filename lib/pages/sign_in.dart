import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:otp_autofill/otp_autofill.dart';
import 'package:prasad/l10n/app_localizations.dart';
import 'package:prasad/utils/classes/globals.dart';
import 'package:prasad/utils/functions/set_fcm_token.dart';
import 'package:prasad/utils/functions/show_error_dialog.dart';
import 'package:prasad/utils/widgets/primary_button.dart';
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
                        AppLocalizations.of(context)!.signIn,
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
                          labelText: AppLocalizations.of(
                            context,
                          )!.enterMobileNumber,
                        ),
                        controller: mobileNumberController,
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppLocalizations.of(
                              context,
                            )!.pleaseEnterSomething;
                          }

                          if (value.length != 10) {
                            return AppLocalizations.of(
                              context,
                            )!.tenDigitMobileNumber;
                          }

                          return null;
                        },
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: PrimaryButton(
                          onPressed: () async {
                            if (!phoneNumberFormKey.currentState!.validate()) {
                              return;
                            }

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
                          },
                          text: AppLocalizations.of(context)!.sendOTP,
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
                        AppLocalizations.of(context)!.enterOTP,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 32,
                        ),
                      ),
                      Text(
                        AppLocalizations.of(context)!.otpSent,
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
                          labelText: AppLocalizations.of(context)!.enterOTP,
                        ),
                        controller: otpController,
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppLocalizations.of(
                              context,
                            )!.pleaseEnterSomething;
                          }

                          if (value.length != 6) {
                            return AppLocalizations.of(context)!.sixDigitOTP;
                          }

                          return null;
                        },
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: PrimaryButton(
                          onPressed: () async {
                            if (!otpFormKey.currentState!.validate()) return;

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
                          },
                          text: AppLocalizations.of(context)!.continueOn,
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
                      TextFormField(
                        controller: nameController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          labelText: AppLocalizations.of(
                            context,
                          )!.enterYourName,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppLocalizations.of(
                              context,
                            )!.pleaseEnterSomething;
                          }

                          return null;
                        },
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: PrimaryButton(
                          onPressed: () async {
                            if (!nameFormKey.currentState!.validate()) return;

                            setState(() {
                              loading = true;
                            });

                            await Globals.supabase.from('users').insert({
                              "user_id": Globals.currentUser!.id,
                              "name": nameController.text,
                            });

                            if (Globals.currentFcmToken != null) {
                              setFcmToken(Globals.currentFcmToken!);
                            }

                            if (context.mounted) {
                              context.go("/");
                            }
                          },
                          text: AppLocalizations.of(context)!.continueOn,
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
