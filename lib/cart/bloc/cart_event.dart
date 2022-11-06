part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class InitialCart extends CartEvent {
  final Record cart;

  const InitialCart({required this.cart});

  @override
  List<Object> get props => [cart];
}

class PostCart extends CartEvent {
  final Record cart;

  const PostCart({required this.cart});

  @override
  List<Object> get props => [cart];
}

class UpdateCart extends CartEvent {
  final Record cart;
  final Details detail;

  const UpdateCart({required this.cart, required this.detail});

  @override
  List<Object> get props => [cart, detail];
}

class AddCart extends CartEvent {
  final Record cart;

  const AddCart({required this.cart});

  @override
  List<Object> get props => [cart];
}

class RemoveDetailCart extends CartEvent {
  final Record cart;
  final Details detail;

  const RemoveDetailCart({required this.cart, required this.detail});

  @override
  List<Object> get props => [cart, detail];
}

class UpdateCartApi extends CartEvent {
  final Record cart;

  const UpdateCartApi({required this.cart});

  @override
  List<Object> get props => [cart];
}
