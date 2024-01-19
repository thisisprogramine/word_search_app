
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
    List<String> diagonalLeftWords = [];
    List<String> diagonalRightWords = [];

    String tempString = "";

    // Horizontal search
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

    // Vertical search
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

    // Diagonal left search
    if(wordIndexes.isEmpty) {
      for(int i = 0; i < nColumn; i++) {
        tempString = words[i];
        for(int j = 0; j < i; j++) {
          tempString = tempString + words[(i + (nColumn - 1)) + ((nColumn -1) * j)];
        }
        diagonalLeftWords.add(tempString);
        tempString = "";
      }

      for(int i = ((nColumn-1) *2) + 1; i < words.length; i = i + nColumn) {
        for(int j = 0; j < ((words.length - i) / nColumn); j++){
          tempString = tempString + words[(i + (j * nColumn)) - j];
        }
        diagonalLeftWords.add(tempString);
        tempString = "";
      }

      for(int i = 0; i < diagonalLeftWords.length; i++) {
        if(diagonalLeftWords[i].contains(searchedWord) && i < nColumn) {
          for(int j = 0; j < searchedWord.length; j++) {
            wordIndexes.add(((diagonalLeftWords[i].indexOf(searchedWord) * nColumn) + (i - diagonalLeftWords[i].indexOf(searchedWord))) + ((nColumn - 1) * j));
          }
        }else if(diagonalLeftWords[i].contains(searchedWord)) {
          for(int j = 0; j < searchedWord.length; j++) {
            wordIndexes.add((((((nColumn * ((nColumn - i).abs() + 2))-1) + ((nColumn-1) * j))) + ((nColumn-1) * diagonalLeftWords[i].indexOf(searchedWord))));
          }
        }
      }

    }

    // Diagonal Right search
    if(wordIndexes.isEmpty) {
      for(int i = nColumn-1; i >= 0; i--) {
        for(int j = 0; j < (i - nColumn).abs(); j++) {
          tempString = tempString + words[i + (j * (nColumn + 1))];
        }
        diagonalRightWords.add(tempString);
        tempString = "";
      }

      for(int i = 1; i < nColumn; i++) {
        for(int j = (i * nColumn); j < words.length; j = j + nColumn) {
          tempString = tempString + words[j + ((j ~/ nColumn)-i)];
        }
        diagonalRightWords.add(tempString);
        tempString = "";
      }

        for(int i = 0; i < diagonalRightWords.length; i++) {
          if(diagonalRightWords[i].contains(searchedWord) && i < nColumn) {
            for(int j = 0; j < searchedWord.length; j++) {
              wordIndexes.add((((nColumn - 1) - i) + ((nColumn + 1) * j)) + (diagonalRightWords[i].indexOf(searchedWord) * (nColumn + 1)));
            }
          }else if(diagonalRightWords[i].contains(searchedWord)) {
            for(int j = 0; j < searchedWord.length; j++) {
              wordIndexes.add(((((j + 1) * (nColumn)) + ((nColumn - i).abs() * nColumn)) + j) + (diagonalRightWords[i].indexOf(searchedWord) * (nColumn + 1)));
            }
          }
        }
    }

    emit(WordChanged(highlightedIndexes: wordIndexes));

  }
}
