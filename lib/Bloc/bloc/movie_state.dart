part of 'movie_bloc.dart';

@immutable
sealed class MovieState {}

final class MovieInitial extends MovieState {}
class Movieblocloaded extends MovieState {}
class Movieblocloading extends MovieState {}
class MovieblocError extends MovieState {}
