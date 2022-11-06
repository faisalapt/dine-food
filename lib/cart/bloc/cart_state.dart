part of 'cart_bloc.dart';

abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartError extends CartState {}

class CartLoadded extends CartState {
  final Record cart;

  const CartLoadded({required this.cart});

  @override
  List<Object> get props => [cart];
}

class CartEmpty extends CartState {}
