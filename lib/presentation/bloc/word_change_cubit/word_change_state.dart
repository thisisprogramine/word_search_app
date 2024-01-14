part of 'word_change_cubit.dart';

abstract class WordChangeState extends Equatable {
  final List<int> highlightedIndexes;

  const WordChangeState({
    this.highlightedIndexes = const []
  });

  @override
  List<Object> get props => [];
}

class WordChangeInitial extends WordChangeState {
  const WordChangeInitial();
}

class WordChanged extends WordChangeState {
  final List<int> highlightedIndexes;
  const WordChanged({
    required this.highlightedIndexes
  }) : super(highlightedIndexes: highlightedIndexes);
}

class WordChangeLoading extends WordChangeState {}

class WordChangeError extends WordChangeState {
  final String message;

  const WordChangeError(this.message);

  @override
  List<Object> get props => [message];
}