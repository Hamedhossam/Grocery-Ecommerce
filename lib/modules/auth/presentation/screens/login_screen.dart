import 'package:flutter/material.dart';
import 'package:maram/constants.dart';
import 'package:maram/core/services/supabase_services.dart';
import 'package:maram/core/widgets/customized_botton.dart';
import 'package:maram/modules/auth/presentation/screens/forget_password_screen.dart';
import 'package:maram/modules/auth/presentation/screens/sign_up_screen.dart';
import 'package:maram/modules/auth/presentation/widgets/custom_text_form_field.dart';
import 'package:maram/modules/auth/presentation/widgets/login_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static const routeName = 'loginScreen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isPassword = true;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        shadowColor: Colors.white,
        // leading: IconButton(
        //   onPressed: () {},
        //   icon: const Icon(Icons.arrow_back_ios_rounded),
        // ),
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          "تسجيـل الدخول",
          style: specialStyle,
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.sizeOf(context).height / 4,
                child: Image.asset("assets/images/market_image.png"),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
                child: CustomTextFormField(
                  controller: emailController,
                  hintText: 'البريـد الإلكتروني',
                  textInputType: TextInputType.text,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: CustomTextFormField(
                  controller: passwordController,
                  obscureText: isPassword,
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        isPassword = !isPassword;
                      });
                    },
                    icon: Icon(
                      isPassword ? Icons.visibility : Icons.visibility_off,
                      color: const Color.fromARGB(142, 83, 82, 82),
                    ),
                  ),
                  hintText: 'كلمـة المرور',
                  textInputType: TextInputType.text,
                ),
              ),
              Row(
                children: [
                  TextButton(
                    onPressed: () => Navigator.pushNamed(
                      context,
                      ForgetPasswordScreen.routeName,
                    ),
                    child: const Text(
                      "  نسيت كلمة المرور؟",
                      style: TextStyle(
                        color: myGreenColor,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: CustomizedButton(
                  isLoading: isLoading,
                  tittle: 'تسجيل الدخول',
                  onTap: () async {
                    if (formKey.currentState!.validate()) {
                      formKey.currentState!.save();
                      setState(() {
                        isLoading = true;
                      });
                      isLoading = await SupabaseServices.signInWithEmail(
                        emailController.text,
                        passwordController.text,
                        context,
                      );
                      setState(() {});
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, SignUpScreen.routeName);
                      },
                      child: Text(
                        'إنشاء حساب',
                        style: normalStyle?.copyWith(
                          color: myGreenColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Text(
                      'ليس لديك حساب؟',
                      style: normalStyle?.copyWith(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: MediaQuery.sizeOf(context).height / 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width / 2.5,
                    child: Divider(
                      thickness: 2,
                      color: Colors.grey.shade300,
                    ),
                  ),
                  Text(
                    'أو',
                    style: normalStyle?.copyWith(
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width / 2.5,
                    child: Divider(
                      thickness: 2,
                      color: Colors.grey.shade300,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: LoginButton(
                  tittle: 'تسجيل الدخول بواسطة جوجل',
                  icon: 'assets/icons/google_icon.png',
                  onTap: () {
                    SupabaseServices.signInWithGoogle();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
