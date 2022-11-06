part of 'store_customer_bloc.dart';

abstract class StoreCustomerState extends Equatable {
  const StoreCustomerState();

  @override
  List<Object> get props => [];
}

class StoreCustomerInitial extends StoreCustomerState {}

class StoreCustomerLoading extends StoreCustomerState {}

class StoreCustomerLoaded extends StoreCustomerState {
  final Customer customer;
  const StoreCustomerLoaded({required this.customer});
  @override
  List<Object> get props => [customer];
}

class StoreCustomerError extends StoreCustomerState {}
