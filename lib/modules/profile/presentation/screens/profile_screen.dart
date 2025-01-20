import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:maram/constants.dart';
import 'package:maram/core/models/user_model.dart';
import 'package:maram/core/services/supabase_services.dart';
import 'package:maram/core/widgets/customized_botton.dart';
import 'package:maram/modules/auth/presentation/widgets/custom_text_form_field.dart';
import 'package:maram/modules/profile/presentation/models/setting_model.dart';
import 'package:maram/modules/profile/presentation/widgets/setting_widget.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key, required this.user});
  final UserModel user;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  late String imageUrl;

  final List<SettingModel> settings = [
    SettingModel(
      title: 'خدمة العملاء',
    ),
    SettingModel(
      title: 'الابلاغ عن مشكلة',
    ),
    SettingModel(
      title: 'الدعم الفني',
    ),
    SettingModel(
      title: 'تسجيل الخروج',
    ),
  ];

  PreferredSize buildUserProfileAppBar(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(65.0),
      child: Padding(
        padding: const EdgeInsets.only(top: 32.0),
        child: AppBar(
          centerTitle: true,
          surfaceTintColor: Colors.grey.shade300,
          shadowColor: Colors.grey.shade400,
          backgroundColor: const Color(0xffF5F5F5),
          automaticallyImplyLeading: false,
          // leading: IconButton(
          //   onPressed: () => Navigator.pop(context),
          //   icon: const Icon(Icons.arrow_back_ios_rounded),
          // ),
          title: Text(
            'الحساب الشخصي',
            style: specialStyle,
          ),
        ),
      ),
    );
  }

  PersistentBottomSheetController editUserBottomSheet(
    BuildContext context,
    String title,
    TextEditingController? controller,
  ) {
    bool isLoading = false;
    return showBottomSheet(
        backgroundColor: Colors.white,
        context: context,
        builder: (_) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              height: MediaQuery.sizeOf(context).height / 4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    title,
                    style: specialStyle,
                  ),
                  const SizedBox(height: 16),
                  CustomTextFormField(
                    hintText: title,
                    textInputType: TextInputType.name,
                    controller: controller,
                  ),
                  CustomizedButton(
                    isLoading: isLoading,
                    tittle: 'حفظ',
                    onTap: () async {
                      await SupabaseServices.editUser(
                        context,
                        emailController.text,
                        nameController.text,
                        phoneController.text,
                        widget.user.image ?? 'assets/images/user_image.png',
                      );
                      // ignore: use_build_context_synchronously
                      Navigator.pop(context);
                      setState(() {});
                    },
                  )
                ],
              ),
            ),
          );
        });
  }

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      // ignore: use_build_context_synchronously
      await SupabaseServices.uploadImage(File(image.path), context);
    }
  }

  @override
  void initState() {
    super.initState();
    nameController.text = widget.user.username ?? '';
    emailController.text = widget.user.email ?? '';
    phoneController.text = widget.user.phone ?? '';
    imageUrl =
        Supabase.instance.client.auth.currentUser!.userMetadata!['image'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F5F5),
      appBar: buildUserProfileAppBar(context),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.sizeOf(context).height / 100,
              width: MediaQuery.sizeOf(context).width,
            ),
            Stack(
              children: [
                CircleAvatar(
                  radius: 67,
                  backgroundColor: myGreenColor,
                  child: CircleAvatar(
                    radius: 65,
                    backgroundColor: Colors.white,
                    backgroundImage: NetworkImage(imageUrl),
                  ),
                ),
                Positioned(
                  right: 5,
                  bottom: 3,
                  child: IconButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(myGreenColor),
                      shape: WidgetStateProperty.all(const CircleBorder()),
                    ),
                    onPressed: () {
                      pickImage();
                      setState(() {});
                    },
                    icon: const Icon(
                      Icons.edit,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: MediaQuery.sizeOf(context).height / 500),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    nameController.text = widget.user.username ?? '';
                    editUserBottomSheet(context, 'تعديل الاسم', nameController);
                  },
                  child: Text(
                    '[تعديل]',
                    style: labelStyle?.copyWith(color: myGreenColor),
                  ),
                ),
                Text(
                  nameController.text,
                  style: labelStyle,
                ),
                Text(
                  ' : إسم المستخدم',
                  style: labelStyle,
                ),
              ],
            ),
            SizedBox(height: MediaQuery.sizeOf(context).height / 500),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    phoneController.text = widget.user.phone ?? '';
                    editUserBottomSheet(
                        context, 'تعديل رقم الجوال', phoneController);
                  },
                  child: Text(
                    '[تعديل]',
                    style: labelStyle?.copyWith(color: myGreenColor),
                  ),
                ),
                Text(
                  phoneController.text,
                  style: labelStyle,
                ),
                Text(
                  ' : رقم الجوال',
                  style: labelStyle,
                ),
              ],
            ),
            SizedBox(height: MediaQuery.sizeOf(context).height / 500),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    emailController.text = widget.user.email ?? '';
                    editUserBottomSheet(
                        context, 'تعديل الايميل', emailController);
                  },
                  child: Text(
                    '[تعديل]',
                    style: labelStyle?.copyWith(color: myGreenColor),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.sizeOf(context).width * .5,
                  child: Text(
                    overflow: TextOverflow.ellipsis,
                    emailController.text,
                    style: labelStyle,
                  ),
                ),
                Text(
                  overflow: TextOverflow.ellipsis,
                  ' : الايميل',
                  style: labelStyle,
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.sizeOf(context).height / 50,
              width: MediaQuery.sizeOf(context).width,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'الاعدادات',
                  style: labelStyle?.copyWith(fontSize: 22),
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: settings.length,
                itemBuilder: (context, index) => SettingWidget(
                  title: settings[index].title,
                  onTap: () {
                    switch (settings[index].title) {
                      case 'تسجيل الخروج':
                        SupabaseServices.signOut(context);
                        break;
                      default:
                        break;
                    }
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
