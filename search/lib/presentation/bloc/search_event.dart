part of 'search_bloc.dart';

class OnQueryChanged extends SearchEvent {
  final String query;

  const OnQueryChanged(this.query);

  @override
  List<Object?> get props => [query];
}

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object?> get props => [];
}
