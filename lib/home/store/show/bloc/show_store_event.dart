part of 'show_store_bloc.dart';

abstract class ShowStoreEvent extends Equatable {
  const ShowStoreEvent();

  @override
  List<Object> get props => [];
}

class LoadStore extends ShowStoreEvent {
  final String id;

  const LoadStore({required this.id});

  @override
  List<Object> get props => [id];
}
