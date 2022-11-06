part of 'store_bloc.dart';

abstract class StoreState extends Equatable {
  const StoreState();

  @override
  List<Object> get props => [];
}

class StoreLoading extends StoreState {}

class StoreInitial extends StoreState {}

class StoreLoaded extends StoreState {
  final List<Stores> stores;
  const StoreLoaded({required this.stores});

  @override
  List<Object> get props => [stores];
}

class StoreError extends StoreState {}
