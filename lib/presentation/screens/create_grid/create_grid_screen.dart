
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:word_search_app/config/extension/size_extensions.dart';
import 'package:word_search_app/presentation/bloc/word_cubit/word_search_cubit.dart';
import 'package:word_search_app/presentation/widgets/button.dart';

import '../../../config/constants/size_constants.dart';
import '../../theme/theme_color.dart';
import '../../widgets/my_appbar.dart';

class CreateGridScreen extends StatefulWidget {
  const CreateGridScreen({super.key});

  @override
  State<CreateGridScreen> createState() => _CreateGridScreenState();
}

class _CreateGridScreenState extends State<CreateGridScreen> {
  late TextEditingController mRowController;
  late TextEditingController nColumnController;

  int mRow = 0;
  int nColumn = 0;
  List<String> words = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mRowController = TextEditingController();
    nColumnController = TextEditingController();

    mRowController.text = context.read<WordSearchCubit>().state.mRow.toString();
    nColumnController.text = context.read<WordSearchCubit>().state.nColumn.toString();

    mRow = context.read<WordSearchCubit>().state.mRow;
    nColumn = context.read<WordSearchCubit>().state.nColumn;

    words = context.read<WordSearchCubit>().state.words;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    mRowController.dispose();
    nColumnController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: "Edit Grid",
      ),
      bottomNavigationBar: Button(
        text: "Save",
        onPressed: () {
          if(mRow > 0 && nColumn > 0) {
            if(_isGridNotEmpty()) {
              context.read<WordSearchCubit>().changeGrid(
                  mRow: mRow,
                  nColumn: nColumn,
                  words: words
              );
              Navigator.of(context).pop();
            }else {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Please fill all the blocs...", style: Theme.of(context).textTheme.titleMedium?.copyWith(color: AppColor.white),))
              );

              // int i = 0;
              // if(mRow * nColumn == 25) {
              //   ["R", "G", "P", "B", "R", "K", "N", "J",
              //     "Z", "V", "F", "I", "V", "O", "K", "K",
              //     "Y", "N", "R", "D", "D", "T", "O", "S", "V"].forEach((char) {
              //       words[i] = char;
              //       i++;
              //   });
              //
              // }else if(mRow * nColumn == 15) {
              //   ["J", "G", "E", "D", "S", "J", "Q", "M", "Y", "M", "W", "B", "X", "Q", "K"].forEach((char) {
              //     words[i] = char;
              //     i++;
              //   });
              // }


            }
          }else {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Please add the grid...", style: Theme.of(context).textTheme.titleMedium?.copyWith(color: AppColor.white),))
            );
          }
        },
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Sizes.dimen_14.w),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        vertical: Sizes.dimen_14.h,
                        horizontal: Sizes.dimen_0.w),
                    child: Card(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          )),
                      child: TextFormField(
                        key: widget.key,
                        controller: mRowController,
                        textInputAction: TextInputAction.done,
                        inputFormatters: [FilteringTextInputFormatter.allow(RegExp("[0-9]")), LengthLimitingTextInputFormatter(1),],
                        onChanged: (String text) {
                          if(mRowController.text.isNotEmpty) {
                            setState(() {
                              mRow = int.parse(mRowController.text);
                              words = List<String>.filled(mRow * nColumn, "");
                            });
                          }else {
                            setState(() {
                              mRow = 0;
                            });
                          }
                        },
                        decoration: InputDecoration(
                          hintText: 'Enter Row',
                          prefixIcon: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: Sizes.dimen_4.h,
                                  horizontal: Sizes.dimen_12.w),
                              child: const Icon(Icons.table_rows, size: Sizes.dimen_24,)),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: Sizes.dimen_4.h,
                              horizontal: Sizes.dimen_12.w),
                          isDense: true,
                          border: InputBorder.none,
                          prefixIconConstraints: const BoxConstraints(),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        vertical: Sizes.dimen_14.h,
                        horizontal: Sizes.dimen_0.w),
                    child: Card(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          )),
                      child: TextFormField(
                        key: widget.key,
                        controller: nColumnController,
                        textInputAction: TextInputAction.done,
                        inputFormatters: [FilteringTextInputFormatter.allow(RegExp("[0-9]")), LengthLimitingTextInputFormatter(1),],
                        onChanged: (String text) {
                          if(nColumnController.text.isNotEmpty) {
                            setState(() {
                              nColumn = int.parse(nColumnController.text);
                              words = List<String>.filled(mRow * nColumn, "");
                            });
                          }else {
                            setState(() {
                              nColumn = 0;
                            });
                          }
                        },
                        decoration: InputDecoration(
                          hintText: 'Enter Column',
                          prefixIcon: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: Sizes.dimen_4.h,
                                  horizontal: Sizes.dimen_12.w),
                              child: const Icon(Icons.view_column, size: Sizes.dimen_24,)),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: Sizes.dimen_4.h,
                              horizontal: Sizes.dimen_12.w),
                          isDense: true,
                          border: InputBorder.none,
                          prefixIconConstraints: const BoxConstraints(),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            Expanded(
                child: mRow * nColumn != 0 ? GridView.builder(
                    padding: EdgeInsets.zero,
                    physics: const BouncingScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: nColumn == 0 ? 1 : nColumn,
                        mainAxisSpacing: Sizes.dimen_3,
                        crossAxisSpacing: Sizes.dimen_3),
                    itemCount: mRow * nColumn,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _showAlphabetDialog(primaryIndex: index);
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: AppColor.secondary,
                              borderRadius: BorderRadius.circular(10.0)
                          ),
                          child: Center(
                              child: Text(_showWord(index: index),
                                style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),)
                          ),
                        ),
                      );
                    }) : const SizedBox.shrink()
            )
          ],
        ),
      ),
    );
  }

  bool _isGridNotEmpty() {
    bool isNotEmpty = true;

    words.forEach((word) {
      if(word.isEmpty) {
        isNotEmpty = false;
      }
    });
    return isNotEmpty;
  }

  String _showWord({required int index}) {

    if(words.length > index) {
      if(words[index].isNotEmpty) {
        return words[index];
      }
    }

    return "";
  }

  _showAlphabetDialog({required int primaryIndex}) {
    List<String> alphabets = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"];
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("Close", style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),)
            )
          ],
          content: GridView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              physics: const BouncingScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                  mainAxisSpacing: Sizes.dimen_3,
                  crossAxisSpacing: Sizes.dimen_3),
              itemCount: 26,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      words[primaryIndex] = alphabets[index];
                      Navigator.of(context).pop();
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: AppColor.orange,
                        borderRadius: BorderRadius.circular(10.0)
                    ),
                    child: Center(
                        child: Text(alphabets[index],
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),)
                    ),
                  ),
                );
              }),
        );
      },
    );
  }
}
