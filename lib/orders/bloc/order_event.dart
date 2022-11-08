part of 'order_bloc.dart';

abstract class OrderEvent extends Equatable {
  const OrderEvent();

  @override
  List<Object> get props => [];
}

class InitialOrder extends OrderEvent {
  final List<Records> records;

  const InitialOrder({required this.records});

  @override
  List<Object> get props => [records];
}
