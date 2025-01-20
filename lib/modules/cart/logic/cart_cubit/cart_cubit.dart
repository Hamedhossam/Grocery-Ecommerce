import 'package:bloc/bloc.dart';
import 'package:maram/core/models/product_model.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());
  Map<ProductModel, List<int>> cartProducts = {};
  void addProduct(ProductModel product, int pieceQuantity, int packetQuantity) {
    if (cartProducts.containsKey(product)) {
      // If it does, update the existing quantities
      cartProducts[product]![0] += pieceQuantity; // Update pieceQuantity
      cartProducts[product]![1] += packetQuantity; // Update packetQuantity
    } else {
      // If not, add the product with the specified quantities
      cartProducts[product] = [pieceQuantity, packetQuantity];
    }
    emit(CartLoaded(cartProducts: cartProducts));
  }

  void removeProduct(ProductModel product) {
    cartProducts.remove(product);
    emit(CartLoaded(cartProducts: cartProducts));
  }

  double getTotalPrice() {
    double totalPrice = 0.0;
    for (var product in cartProducts.keys) {
      totalPrice +=
          (double.parse(product.price ?? '0') * cartProducts[product]![0]) +
              (double.parse(product.packetPrice ?? '0') *
                  cartProducts[product]![1]);
    }
    return totalPrice;
  }

  void clearCart() {
    cartProducts.clear();
    emit(CartEmpty());
  }

  void getCartProducts() {
    emit(CartLoading());
    if (cartProducts.isEmpty) {
      emit(CartEmpty());
    } else {
      emit(CartLoaded(cartProducts: cartProducts));
    }
  }
}
