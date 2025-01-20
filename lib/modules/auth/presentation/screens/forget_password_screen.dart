import 'package:flutter/material.dart';
import 'package:maram/constants.dart';
import 'package:maram/core/widgets/customized_botton.dart';
import 'package:maram/modules/auth/presentation/screens/otp_screen.dart';
import 'package:maram/modules/auth/presentation/widgets/custom_text_form_field.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});
  static const String routeName = "forgetPasswordScreen";

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

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
          " نسيان كلمة المرور",
          style: specialStyle,
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(children: [
            Text(
              'من فضلك ادخل رقم الهاتف وسوف يتم ارسال كود التحقق للتاكيد',
              textAlign: TextAlign.center,
              style: labelStyle?.copyWith(color: Colors.grey),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
              child: CustomTextFormField(
                suffixIcon: Icon(
                  Icons.phone,
                  color: Color.fromARGB(142, 83, 82, 82),
                ),
                hintText: 'رقم الهاتف',
                textInputType: TextInputType.phone,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: CustomizedButton(
                isLoading: false,
                tittle: 'ارسال',
                onTap: () {
                  if (formKey.currentState!.validate()) {
                    Navigator.pushNamed(context, OtpScreen.routeName);
                  }
                },
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
