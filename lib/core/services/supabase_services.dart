import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:lottie/lottie.dart';
import 'package:maram/constants.dart';
import 'package:maram/core/models/order_model.dart';
import 'package:maram/core/models/product_model.dart';
import 'package:maram/core/models/user_model.dart';
import 'package:maram/core/services/shared_preferences_servise.dart';
import 'package:maram/modules/auth/presentation/screens/login_screen.dart';
import 'package:maram/modules/home/presentation/screens/home_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseServices {
  static Future<void> init() async {
    await Supabase.initialize(
      url: dotenv.env['SUPABASE_URL']!,
      anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
    );
  }

  static Future<void> signUp(
    BuildContext context,
    String email,
    String password,
    String username,
    String phone,
    String image,
    String address,
  ) async {
    try {
      await Supabase.instance.client.auth.signUp(
        email: email,
        password: password,
        data: {
          'username': username,
          'phone': phone,
          'image': image,
          'address': address,
        },
      );
      await showDialog(
          // ignore: use_build_context_synchronously
          context: context,
          builder: (builder) => AlertDialog(
                alignment: Alignment.center,
                title: const Text('✅ تم التسجيل بنجاح'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.check_circle,
                      color: myGreenColor,
                      size: 50,
                    ),
                    Text(
                      'يرجى التحقق من بريدك الالكتروني للتفعيل',
                      style: labelStyle,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ));
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  static Future<void> signOut(BuildContext context) async {
    try {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          backgroundColor: Colors.white,
          content: SizedBox(
            height: MediaQuery.of(context).size.height / 4,
            width: MediaQuery.of(context).size.width / 2,
            child: Center(
              child: SizedBox(
                height: MediaQuery.of(context).size.height / 5,
                width: MediaQuery.of(context).size.height / 5,
                child: Lottie.asset("assets/lotties/shopping_cart.json"),
              ),
            ),
          ),
        ),
      );
      await Supabase.instance.client.auth.signOut();

      // Optionally clear any locally stored user data
      SharedPreferencesServise.setLog("islogged", false);
      SharedPreferencesServise.setString("user", "");
      // ignore: use_build_context_synchronously
      Navigator.of(context).pop();

      // Show a success message
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            '✅ تم تسجيل الخروج بنجاح',
            style: labelStyle?.copyWith(color: Colors.white),
          ),
        ),
      );

      // Navigate to the login screen or another appropriate screen
      Navigator.pushReplacement(
        // ignore: use_build_context_synchronously
        context,
        MaterialPageRoute(
            builder: (context) =>
                const LoginScreen()), // Replace with your login screen
      );
    } catch (e) {
      // ignore: use_build_context_synchronously
      Navigator.of(context).pop();
      // Show an error message
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            '❌ خطأ في تسجيل الخروج',
            style: labelStyle?.copyWith(color: Colors.white),
          ),
        ),
      );
    }
  }

  static Future<void> editUser(
    BuildContext context,
    String email,
    // String password,
    String username,
    String phone,
    String image,
  ) async {
    try {
      await Supabase.instance.client.auth.updateUser(
        UserAttributes(
          email: email,
          // password: password,
          data: {
            'username': username,
            'phone': phone,
            'image': image,
          },
        ),
      );
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            ' ✅ تم تعديل الحساب بنجاح ',
            style: labelStyle?.copyWith(color: Colors.white),
          ),
        ),
      );
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  static Future<void> uploadImage(File imageFile, BuildContext context) async {
    final fileName =
        'profile_images/${DateTime.now().millisecondsSinceEpoch}.png'; // Unique file name
    final userId = Supabase.instance.client.auth.currentUser?.id;
    if (userId == null) {
      // Handle case when user is not authenticated
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User not authenticated.')),
      );
    }
    try {
      await Supabase.instance.client.storage
          .from('user_images') // Replace with your bucket name
          .upload(fileName, imageFile);
      final imageUrl = Supabase.instance.client.storage
          .from('user_images')
          .getPublicUrl(fileName);
      // ignore: use_build_context_synchronously
      await updateUserImage(imageUrl, context);
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  static Future<void> updateUserImage(
      String imageUrl, BuildContext context) async {
    final user = Supabase.instance.client.auth.currentUser;

    if (user != null) {
      try {
        await Supabase.instance.client.auth.updateUser(
          UserAttributes(
            email: user.email,
            // password: password,
            data: {
              'username': user.userMetadata!['username'],
              'phone': user.userMetadata!['phone'],
              'image': imageUrl,
            },
          ),
        );
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              ' ✅ تم تعديل الصورة بنجاح ',
              style: labelStyle?.copyWith(color: Colors.white),
            ),
          ),
        );
      } on Exception catch (e) {
        log(e.toString());
      }
    }
  }

  static Future<void> signInWithGoogle() async {
    try {
      await Supabase.instance.client.auth.signInWithOAuth(
        OAuthProvider.google,
      );
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  static Future<bool> signInWithEmail(
      String email, String password, BuildContext context) async {
    try {
      final res = await Supabase.instance.client.auth.signInWithPassword(
        email: email,
        password: password,
      );
      UserModel user = UserModel(
        id: res.user!.id,
        email: res.user!.email,
        username: res.user!.userMetadata!['username'],
        phone: res.user!.userMetadata!['phone'],
        image: res.user!.userMetadata!['image'],
        address: res.user!.userMetadata!['address'],
      );
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            ' ✅ تم تسجيل الدخول بنجاح ',
            style: labelStyle?.copyWith(color: Colors.white),
          ),
        ),
      );
      SharedPreferencesServise.setLog("islogged", true);
      SharedPreferencesServise.setString("user", jsonEncode(user.toMap()));

      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => HomeScreen(user: user)));
      return true;
    } on Exception {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            '❌ خطأ في البيانات',
            style: labelStyle?.copyWith(color: Colors.white),
          ),
        ),
      );
      return false;
    }
  }

  static Future<List<Map<String, dynamic>>> fetchCategories() async {
    final response = await Supabase.instance.client
        .from('categories')
        .select(); // Select all columns
    return List<Map<String, dynamic>>.from(response);
  }

  static Future<List<Map<String, dynamic>>> fetchSections(
      String categoryId) async {
    final response = await Supabase.instance.client
        .from('sections')
        .select('*') // Select all columns
        .eq('category_id', categoryId); // Filter by category_id

    List<Map<String, dynamic>> sections =
        List<Map<String, dynamic>>.from(response);

    for (var section in sections) {
      final sectionId =
          section['id']; // Assuming 'id' is the section identifier
      final productResponse = await Supabase.instance.client
          .from('products')
          .select('*')
          .eq('section_id', sectionId);

      // Add products to the section map
      section['products'] = List<Map<String, dynamic>>.from(productResponse);
    }
    return sections;
  }

  static Future<List<Map<String, dynamic>>> fetchProducts(
      String sectionId) async {
    final response = await Supabase.instance.client
        .from('products')
        .select('*') // Select all columns
        .eq('section_id', sectionId); // Filter by section_id
    return List<Map<String, dynamic>>.from(response);
  }

  static Future<List<Map<String, dynamic>>> fetchBestsellers() async {
    final response = await Supabase.instance.client
        .from('bestsellers')
        .select('product_id, sales_count, products(*)');
    return List<Map<String, dynamic>>.from(response);
  }

  static Future<void> buyProducts(Map<ProductModel, List<int>> products) async {
    for (var product in products.keys) {
      await Supabase.instance.client.from('products').update({
        'quantity':
            (int.parse(product.quantity!) - products[product]![0]).toString(),
        'packet_quantity':
            (int.parse(product.packetQuantity!) - products[product]![1])
                .toString(),
      }).eq('id', product.id!);
    }
  }

  static Future<void> createOrder(OrderModel order) async {
    final user = Supabase.instance.client.auth.currentUser;
    // log(user!.userMetadata!['username'].toString());
    await Supabase.instance.client.from('orders').insert({
      'user_id': user!.id,
      'product_images': order.productsImages,
      'created_at': order.createdAt,
      'status': 'جاري التجهيز',
      'order_code': order.orderCode,
      'payment_method': order.paymentMethod,
      'total': order.total,
      'note': order.note,
      'delivery_address': order.deliveryAddress,
      'payment_status': order.paymentStatus,
      'delivery_method': order.deliveryMethod,
    });

    // if (response.error != null) {
    //   // Handle error
    //   throw Exception('Error creating order: ${response.error!.message}');
    // }
  }

  static Future<List<Map<String, dynamic>>> fetchOrders() async {
    final response = await Supabase.instance.client
        .from('orders')
        .select('*')
        .eq('user_id', Supabase.instance.client.auth.currentUser!.id);
    return List<Map<String, dynamic>>.from(response);
  }
}
