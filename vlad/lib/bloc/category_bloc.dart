

import 'package:bloc/bloc.dart';

import 'package:vlad_newsapi/bloc/category_event.dart';
import 'package:vlad_newsapi/bloc/category_state.dart';
import 'package:vlad_newsapi/repo/repo.dart';

import 'package:vlad_newsapi/models/score.dart';

class NewsCatsBloc extends Bloc<NewsCatsEvent , NewsCatsState> {
    NewsRepository postRepository  = NewsRepository();
    
    NewsCatsBloc() :super(NewsCatsState()){
        on<NewsCategories>(fetchNewsCategoires);
    }

    Future<void> fetchNewsCategoires(NewsCategories event, Emitter<NewsCatsState> emit) async {

        emit(state.copyWith(status: Status.initial));

        await postRepository.fetchNewsCategoires(event.category).then((value){
            emit(
                state.copyWith(
                    categoriesStatus: Status.success,
                    categoriesNewsModel: value,
                    categoriesMessage: 'success'
                )
            );
        }).onError((error, stackTrace) {
            emit(
                state.copyWith(
                    categoriesStatus: Status.failure ,
                    categoriesMessage: error.toString()
                )
            );
            emit(
                state.copyWith(
                    status: Status.failure ,
                    message: error.toString()
                )
            );
        });
    }

}