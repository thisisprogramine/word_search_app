
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'word_change_state.dart';

enum WordDirection {horizontal, vertical, diagonal}

class WordChangeCubit extends Cubit<WordChangeState> {

  WordChangeCubit() : super(const WordChangeInitial());

  void wordChanged({required String searchedWord, required List<String> words, required int mRow, required int nColumn}) {
    // List<int> filteredWords = [];
    // int firstCharIndex = 0;
    // int currentIndex = 0;
    // WordDirection direction;
    //
    // for(int i = 0; i < searchedWord.length; i++) {
    //   if(filteredWords.isEmpty) {
    //     for(int j = 0; j < words.length; j++) {
    //       if(searchedWord[i] == words[j] && filteredWords.isEmpty) {
    //         firstCharIndex = j;
    //         currentIndex = j;
    //         filteredWords.add(j);
    //         break;
    //       }
    //     }
    //   }
    // }
    //
    // if(searchedWord[]) {
    //
    // }

    emit(const WordChangeInitial());

    List<int> wordIndexes = [];

    List<String> horizontalWords = [];
    List<String> verticalWords = [];

    String tempString = "";

    if(wordIndexes.isEmpty) {
      for(int i = 0; i < words.length/nColumn; i++) {
        for(int j = 0; j < nColumn; j++) {
          tempString = tempString + words[(i * nColumn) + j];
        }
        horizontalWords.add(tempString);
        tempString = "";
      }

      for(int i = 0; i < horizontalWords.length; i++) {
        if(horizontalWords[i].contains(searchedWord)) {
          for(int j = 0; j < searchedWord.length; j++) {
            wordIndexes.add(horizontalWords[i].indexOf(searchedWord) + j + (i * nColumn));
          }
        }
      }
    }

    if(wordIndexes.isEmpty) {
      for(int i = 0; i < words.length/nColumn; i++) {
        for(int j = 0; j < nColumn; j++) {
          tempString = tempString + words[(i * nColumn) + j];
        }
        horizontalWords.add(tempString);
        tempString = "";
      }

      for(int i = 0; i < nColumn; i++) {
        for(int j = 0; j < horizontalWords.length; j++) {
          tempString = tempString + horizontalWords[j][i];
        }
        verticalWords.add(tempString);
        tempString = "";
      }

      for(int i = 0; i < verticalWords.length; i++) {
        if(verticalWords[i].contains(searchedWord)) {
          for(int j = 0; j < searchedWord.length; j++) {
            wordIndexes.add((nColumn * verticalWords[i].indexOf(searchedWord) + i) + (j * nColumn));
          }
        }
      }
    }

    emit(WordChanged(highlightedIndexes: wordIndexes));

  }
}
