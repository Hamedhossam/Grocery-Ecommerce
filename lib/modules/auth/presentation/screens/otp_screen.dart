import 'package:flutter/material.dart';
import 'package:maram/constants.dart';
import 'package:maram/core/widgets/customized_botton.dart';
import 'package:maram/modules/auth/presentation/screens/login_screen.dart';
import 'package:maram/modules/auth/presentation/widgets/custom_text_form_field.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});
  static const String routeName = "otpScreen";
  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        shadowColor: Colors.white,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_rounded),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          "ادخال كود التحقق",
          style: specialStyle,
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              'من فضلك ادخل كود التحقق المكون من 4 أرقام المرسل لك على رقم الهاتف',
              textAlign: TextAlign.center,
              style: labelStyle?.copyWith(color: Colors.grey),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
              child: CustomTextFormField(
                hintText: '## ## ##',
                textInputType: TextInputType.number,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: CustomizedButton(
                isLoading: false,
                tittle: 'تاكيد',
                onTap: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, LoginScreen.routeName, (_) => false);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
