part of 'store_bloc.dart';

abstract class StoreEvent extends Equatable {
  const StoreEvent();

  @override
  List<Object> get props => [];
}

class LoadStore extends StoreEvent {
  final List<Stores> stores;
  final String search;

  LoadStore({required this.stores, required this.search});

  @override
  List<Object> get props => [stores, search];
}
