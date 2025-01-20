import 'package:flutter/material.dart';
import 'package:maram/constants.dart';
import 'package:maram/core/services/supabase_services.dart';
import 'package:maram/core/widgets/customized_botton.dart';
import 'package:maram/modules/auth/presentation/widgets/custom_text_form_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});
  static const routeName = 'signUpScreen';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey();
  bool isPassword = true;
  bool isLoading = false;
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
          "انشاء حساب",
          style: specialStyle,
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
                child: CustomTextFormField(
                  controller: nameController,
                  hintText: 'اسم المستخدم',
                  textInputType: TextInputType.text,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: CustomTextFormField(
                  controller: phoneController,
                  suffixIcon: const Icon(
                    Icons.phone,
                    color: Color.fromARGB(142, 83, 82, 82),
                  ),
                  hintText: 'رقم الهاتف',
                  textInputType: TextInputType.phone,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16, top: 16),
                child: CustomTextFormField(
                  controller: addressController,
                  suffixIcon: const Icon(
                    Icons.location_on,
                    color: Color.fromARGB(142, 83, 82, 82),
                  ),
                  hintText: ' العنوان',
                  textInputType: TextInputType.text,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
                child: CustomTextFormField(
                  controller: emailController,
                  hintText: 'البريـد الإلكتروني',
                  textInputType: TextInputType.emailAddress,
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
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
                child: CustomizedButton(
                  isLoading: isLoading,
                  tittle: 'إنشاء الحساب',
                  onTap: () async {
                    if (formKey.currentState!.validate()) {
                      setState(() {
                        isLoading = true;
                      });
                      await SupabaseServices.signUp(
                        context,
                        emailController.text,
                        passwordController.text,
                        nameController.text,
                        phoneController.text,
                        "https://rpbinfcdydptfjvkimfm.supabase.co/storage/v1/object/public/user_images/user_image.png?t=2025-01-16T01%3A22%3A43.426Z",
                        addressController.text,
                      );
                      setState(() {
                        isLoading = false;
                      });
                      // ignore: use_build_context_synchronously
                      Navigator.pop(context);
                    }
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Text(
                      'تسجيل دخول',
                      style: normalStyle?.copyWith(
                        color: myGreenColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Text(
                    ' لديك حساب بالفعل؟',
                    style: normalStyle?.copyWith(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
