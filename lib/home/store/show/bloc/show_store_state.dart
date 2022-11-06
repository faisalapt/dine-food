part of 'show_store_bloc.dart';

abstract class ShowStoreState extends Equatable {
  const ShowStoreState();

  @override
  List<Object> get props => [];
}

class ShowStoreInitial extends ShowStoreState {}

class ShowStoreLoading extends ShowStoreState {}

class ShowStoreLoaded extends ShowStoreState {
  final Store store;
  final List<Menu> menus;

  const ShowStoreLoaded({required this.store, required this.menus});

  @override
  List<Object> get props => [store, menus];
}

class ShowStoreError extends ShowStoreState {}
