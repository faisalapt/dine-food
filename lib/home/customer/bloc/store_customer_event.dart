part of 'store_customer_bloc.dart';

abstract class StoreCustomerEvent extends Equatable {
  const StoreCustomerEvent();

  @override
  List<Object> get props => [];
}

class LoadCustomer extends StoreCustomerEvent {
  final Customer customer;

  LoadCustomer({required this.customer});

  @override
  List<Object> get props => [customer];
}

class SetCustomer extends StoreCustomerEvent {
  final Customer customer;

  const SetCustomer({required this.customer});

  @override
  List<Object> get props => [customer];
}
