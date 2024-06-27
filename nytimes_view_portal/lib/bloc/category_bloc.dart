

import 'package:bloc/bloc.dart';

import 'package:nytimes_view_portal/bloc/category_event.dart';
import 'package:nytimes_view_portal/bloc/category_state.dart';
import 'package:nytimes_view_portal/repo/repo.dart';

import 'package:nytimes_view_portal/models/score.dart';

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