part of 'order_bloc.dart';

abstract class OrderState extends Equatable {
  const OrderState();

  @override
  List<Object> get props => [];
}

class OrderInitial extends OrderState {}

class OrderLoading extends OrderState {}

class OrderEmpty extends OrderState {}

class OrderError extends OrderState {}

class OrderLoadded extends OrderState {
  final List<Records> records;

  const OrderLoadded({required this.records});

  @override
  List<Object> get props => [records];
}

class OrderUpdateStatus extends OrderEvent {
  final Records records;
  final String mode;

  const OrderUpdateStatus({required this.records, required this.mode});

  @override
  List<Object> get props => [records, mode];
}
