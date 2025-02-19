import 'package:dio/dio.dart';
import 'package:test_zybo/model/login_register_model.dart';
import 'package:test_zybo/model/product.dart';
import 'package:test_zybo/model/profile_model.dart';
import 'package:test_zybo/model/slider_model.dart';
import 'package:test_zybo/model/verify_user_model.dart';
import 'package:test_zybo/model/wishlist.dart';
import 'package:test_zybo/data/service/shared_pref_service.dart';

class ApiService {
  final Dio _dio = Dio();

  Future<VerifyUserResponse?> verifyUser(String phoneNumber) async {
    const String url = "https://admin.kushinirestaurant.com/api/verify/";

    try {
      Response response = await _dio.post(
        url,
        data: {"phone_number": phoneNumber},
        options: Options(headers: {"Content-Type": "application/json"}),
      );

      if (response.statusCode == 200) {
        final verifyUserResponse = VerifyUserResponse.fromJson(response.data);
        await SharedPrefService.savePhoneNumber(phoneNumber);
        if (verifyUserResponse.user && verifyUserResponse.token != null) {
          await SharedPrefService.saveToken(verifyUserResponse.token!.access);
        }

        return verifyUserResponse;
      } else {
        return null;
      }
    } catch (e) {
      print("Error: $e");
      return null;
    }
  }

  Future<LoginRegisterResponse> loginOrRegister(
      String firstName, String phoneNumber) async {
    const String url =
        "https://admin.kushinirestaurant.com/api/login-register/";

    try {
      Response response = await _dio.post(
        url,
        data: {
          "first_name": firstName,
          "phone_number": phoneNumber,
        },
      );
      final loginresponse = LoginRegisterResponse.fromJson(response.data);

      await SharedPrefService.saveToken(loginresponse.token.access);

      return LoginRegisterResponse.fromJson(response.data);
    } catch (e) {
      throw Exception("Failed to login/register: $e");
    }
  }

  Future<List<Product>> fetchProducts() async {
    try {
      final response =
          await _dio.get('https://admin.kushinirestaurant.com/api/products/');

      if (response.statusCode == 200) {
        // If the server returns a 200 OK response, parse the JSON data
        List<dynamic> jsonResponse = response.data;
        return jsonResponse.map((data) => Product.fromJson(data)).toList();
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      throw Exception('Failed to load products: $e');
    }
  }

  Future<List<SliderModel>> fetchBanners() async {
    try {
      final response =
          await _dio.get("https://admin.kushinirestaurant.com/api/banners/");

      if (response.statusCode == 200) {
        List<dynamic> responseData = response.data;

        return responseData
            .map((banner) => SliderModel.fromJson(banner))
            .toList();
      } else {
        throw Exception('Failed to load banners');
      }
    } catch (e) {
      throw Exception("Failed to load banner $e");
    }
  }

  Future<UserProfile?> fetchUserProfile() async {
    try {
      String? token = await SharedPrefService.getToken();
      // print("profile token $token"

      if (token == null) {
        throw Exception("JWT Token not found");
      }

      _dio.options.headers["Authorization"] = "Bearer $token";

      Response response =
          await _dio.get('https://admin.kushinirestaurant.com/api/user-data/');

      if (response.statusCode == 200) {
        return UserProfile.fromJson(
            response.data); // Convert response to UserProfile
      } else {
        throw Exception("Failed to fetch user profile");
      }
    } catch (e) {
      print("Error fetching profile: $e");
      return null;
    }
  }

  Future<WishlistResponse?> toggleWishlist(String productId) async {
    try {
      String? token = await SharedPrefService.getToken();

      // print("wishlist token $token");

      if (token == null) {
        throw Exception("JWT Token not found");
      }

      _dio.options.headers["Authorization"] = "Bearer $token";

      Map<String, dynamic> requestBody = {"product_id": productId};

      Response response = await _dio.post(
          'https://admin.kushinirestaurant.com/api/add-remove-wishlist/',
          data: requestBody);

          // print(" response ${response.statusCode}");


        return WishlistResponse.fromJson(response.data); 


      
    } catch (e) {
      print("Error updating wishlist: $e");
      return null;
    }
  }
  Future<List<Product>?> fetchWishlist() async {
  try {
    String? token = await SharedPrefService.getToken();

    if (token == null) {
      throw Exception("JWT Token not found");
    }

    _dio.options.headers["Authorization"] = "Bearer $token";

    Response response = await _dio.get('https://admin.kushinirestaurant.com/api/wishlist/');

    if (response.statusCode == 200) {
      List<dynamic> wishlistData = response.data;
      // print(response.data);
      return wishlistData.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception("Failed to fetch wishlist");
    }
  } catch (e) {
    print("Error fetching wishlist: $e");
    return null;
  }
}

   Future<List<Product>> searchProducts(String query) async {
    try {
      final response = await _dio.post(
        'https://admin.kushinirestaurant.com/api/search/',
        data: {"query": query},
      );

      // print(query);

      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        // print(response.data);
        return data.map((json) => Product.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load search results');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
