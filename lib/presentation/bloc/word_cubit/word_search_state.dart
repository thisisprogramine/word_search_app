part of 'word_search_cubit.dart';

abstract class WordSearchState extends Equatable {
  final int mRow;
  final int nColumn;
  final List<String> words;

  const WordSearchState({
    this.mRow = 0,
    this.nColumn = 0,
    this.words = const []
  });

  @override
  List<Object> get props => [];
}

class WordSearchInitial extends WordSearchState {
  const WordSearchInitial();
}

class WordSearchSet extends WordSearchState {
  final int mRow;
  final int nColumn;
  final List<String> words;
  const WordSearchSet({
    required this.mRow,
    required this.nColumn,
    required this.words,
  }) : super(mRow: mRow, nColumn: nColumn, words: words);
}

class WordSearchLoading extends WordSearchState {}

class WordSearchError extends WordSearchState {
  final String message;

  const WordSearchError(this.message);

  @override
  List<Object> get props => [message];
}