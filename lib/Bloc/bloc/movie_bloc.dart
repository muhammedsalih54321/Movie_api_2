import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:movie_app2/Repository/Api/Movie/movie_api.dart';
import 'package:movie_app2/Repository/ModelClass/movie_model.dart';

part 'movie_event.dart';
part 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
   late Moviemodel moviemodel;
   MovieApi movieapi=MovieApi();
  MovieBloc() : super(MovieInitial()) {
  
    on<FetchmovieEvent>((event, emit)async {
     emit(Movieblocloading());
     try {
      moviemodel = await movieapi.getMovie();
      emit(Movieblocloaded());
     } catch (e) {
      print(e);
       emit(MovieblocError());
     }
    });
  }
}
