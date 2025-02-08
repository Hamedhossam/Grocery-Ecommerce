import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class PaymobServices {
  static String apiKey = dotenv.env['PAYMOB_API_KEY']!;
  static Future<String> payWithPaymob(double amount, String address) async {
    try {
      String token = await getToken();
      int orderID = await getOrderID(
        token: token,
        amount: (amount * 100).toString(),
      );
      String paymentToken = await getPaymentToken(
        token: token,
        orderID: orderID,
        amount: (amount * 100).toString(),
        address: address,
      );
      return paymentToken;
    } on Exception catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  //* Step 1 : Get Token
  static Future<String> getToken() async {
    try {
      Response response = await Dio().post(
        'https://accept.paymob.com/api/auth/tokens',
        data: {
          'api_key': apiKey,
        },
      );
      return response.data['token'];
    } on Exception catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  //* Step 2 : Get Order ID
  static Future<int> getOrderID(
      {required String token, required String amount}) async {
    try {
      final dio = Dio()
        ..interceptors.add(PrettyDioLogger(
          request: true, // Log request details
          requestHeader: true, // Log request headers
          responseHeader: true, // Log response headers
          responseBody: true, // Log response details
          error: true, // Log errors
          compact: false, // Use false for detailed output
        ));
      Response response = await dio.post(
        'https://accept.paymob.com/api/ecommerce/orders',
        data: {
          'auth_token': token,
          'delivery_needed': 'false',
          'amount_cents': amount,
          'currency': 'EGP',
          'items': [],
        },
      );
      return response.data['id'];
    } on Exception catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  //* Step 3 : Get Payment Key
  static Future<String> getPaymentToken({
    required String token,
    required int orderID,
    required String amount,
    required String address,
  }) async {
    try {
      var user = Supabase.instance.client.auth.currentUser!.userMetadata;
      final dio = Dio()
        ..interceptors.add(PrettyDioLogger(
          request: true, // Log request details
          requestHeader: true, // Log request headers
          responseHeader: true, // Log response headers
          responseBody: true, // Log response details
          error: true, // Log errors
          compact: false, // Use false for detailed output
        ));
      Response response = await dio.post(
        'https://accept.paymob.com/api/acceptance/payment_keys',
        data: {
          'auth_token': token,
          'amount_cents': amount,
          'expiration': 3600,
          'order_id': orderID,
          'currency': 'EGP',
          'integration_id': 4947222,
          "billing_data": {
            "apartment": "803",
            "email": user!['email'] ?? 'NA',
            "floor": "42",
            "first_name": user['username'] ?? 'NA',
            "street": address,
            "building": "8028",
            "phone_number": user['phone'] ?? 'NA',
            "shipping_method": "PKG",
            "postal_code": "01898",
            "city": "Jaskolskiburgh",
            "country": "CR",
            "last_name": "Nicolas",
            "state": "Utah"
          },
          "lock_order_when_paid": "false"
        },
      );
      return response.data['token'];
    } on Exception catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}


//   static Future<String> getPaymentKey(
//       double amount, String currency, String address) async {
//     try {
//       String authanticationToken = await _getAuthanticationToken();

//       int orderId = await _getOrderId(
//         authanticationToken: authanticationToken,
//         amount: (100 * amount).toString(),
//         currency: currency,
//       );

//       String paymentKey = await _getPaymentKey(
//         authanticationToken: authanticationToken,
//         amount: (100 * amount).toString(),
//         currency: currency,
//         orderId: orderId.toString(),
//         address: address,
//       );
//       return paymentKey;
//     } catch (e) {
//       log(e.toString());
//       throw Exception();
//     }
//   }

//   static Future<String> _getAuthanticationToken() async {
//     final Response response =
//         await Dio().post("https://accept.paymob.com/api/auth/tokens", data: {
//       "api_key": dotenv.env['PAYMOB_API_KEY']!,
//     });
//     return response.data["token"];
//   }

//   static Future<int> _getOrderId({
//     required String authanticationToken,
//     required String amount,
//     required String currency,
//   }) async {
//     final Response response = await Dio()
//         .post("https://accept.paymob.com/api/ecommerce/orders", data: {
//       "auth_token": authanticationToken,
//       "amount_cents": amount, //  >>(STRING)<<
//       "currency": currency, //Not Req
//       "delivery_needed": "false",
//       "items": [],
//     });
//     return response.data["id"]; //INTGER
//   }

//   static Future<String> _getPaymentKey({
//     required String authanticationToken,
//     required String orderId,
//     required String amount,
//     required String currency,
//     required String address,
//   }) async {
//     var user = Supabase.instance.client.auth.currentUser!.userMetadata;
//     final Response response = await Dio()
//         .post("https://accept.paymob.com/api/acceptance/payment_keys", data: {
//       //ALL OF THEM ARE REQIERD
//       "expiration": 3600,

//       "auth_token": authanticationToken, //From First Api
//       "order_id": orderId, //From Second Api  >>(STRING)<<
//       "integration_id": 4947222, //Integration Id Of The Payment Method

//       "amount_cents": amount,
//       "currency": currency,

      // 'billing_data': {
      //   'apartment': 'NA',
      //   'email': user!['email'] ?? 'NA',
      //   'first_name': user['username'] ?? 'NA',
      //   'floor': 'NA',
      //   'last_name': 'Doe',
      //   'phone_number': user['phone'] ?? 'NA',
      //   'shipping_method': 'NA',
      //   'city': 'NA',
      //   'country': 'NA',
      //   'postal_code': 'NA',
      //   'state': 'NA',
      //   'address': address,
//       },
//     });
//     return response.data["token"];
//   }
// }
