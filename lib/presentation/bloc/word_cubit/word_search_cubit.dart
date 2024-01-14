

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'word_search_state.dart';

class WordSearchCubit extends Cubit<WordSearchState> {

  WordSearchCubit() : super(const WordSearchInitial());

  void changeGrid({int? mRow, int? nColumn, List<String>? words}) {
    emit(const WordSearchInitial());
    emit(
        WordSearchSet(
            mRow: mRow ?? state.mRow,
            nColumn: nColumn ?? state.nColumn,
            words: words ?? state.words
        )
    );
  }
}
