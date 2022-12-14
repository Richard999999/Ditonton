part of 'search_bloc.dart';

class SearchHashDataTV extends SearchState {
  final List<Tv> result;

  const SearchHashDataTV(this.result);

  @override
  List<Object?> get props => [result];
}

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object?> get props => [];
}

class SearchError extends SearchState {
  final String message;
  const SearchError(this.message);

  @override
  List<Object?> get props => [message];
}

class SearchHashData extends SearchState {
  final List<Movie> result;

  const SearchHashData(this.result);

  @override
  List<Object?> get props => [result];
}

class SearchEmpty extends SearchState {}

class SearchLoading extends SearchState {}
