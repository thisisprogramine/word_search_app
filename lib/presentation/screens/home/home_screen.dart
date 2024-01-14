import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:word_search_app/config/constants/route_constants.dart';
import 'package:word_search_app/config/constants/size_constants.dart';
import 'package:word_search_app/config/extension/size_extensions.dart';
import 'package:word_search_app/presentation/bloc/word_change_cubit/word_change_cubit.dart';
import 'package:word_search_app/presentation/bloc/word_cubit/word_search_cubit.dart';
import 'package:word_search_app/presentation/theme/theme_color.dart';
import 'package:word_search_app/presentation/widgets/my_appbar.dart';

import '../../../config/screenutil/screenutil.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: "Word Search App",
        leading: IconButton(
          onPressed: () {

          },
          icon: const Icon(Icons.menu),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(RouteList.createGrid);
              },
              icon: const Icon(Icons.edit_note_sharp),
          )
        ],
      ),
      body: BlocBuilder<WordSearchCubit, WordSearchState>(
        builder: (context, wordState) {
          if(wordState is WordSearchSet) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: Sizes.dimen_14.w),
              child: Column(
                children: [
                  Material(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: Sizes.dimen_6.h,
                                horizontal: Sizes.dimen_0.w),
                            child: Card(
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.0),
                                  )),
                              child: TextFormField(
                                key: widget.key,
                                controller: controller,
                                textInputAction: TextInputAction.search,
                                onChanged: (String text) {
                                  context.read<WordChangeCubit>().wordChanged(
                                      searchedWord: controller.text.toUpperCase(),
                                      words: wordState.words,
                                      mRow: wordState.mRow,
                                      nColumn: wordState.nColumn
                                  );
                                },
                                decoration: InputDecoration(
                                  hintText: 'Search',
                                  prefixIcon: Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: Sizes.dimen_2.h,
                                          horizontal: Sizes.dimen_12.w),
                                      child: const Icon(Icons.search, size: Sizes.dimen_24,)),
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: Sizes.dimen_2.h,
                                      horizontal: Sizes.dimen_12.w),
                                  isDense: true,
                                  border: InputBorder.none,
                                  prefixIconConstraints: const BoxConstraints(),
                                ),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            controller.clear();
                            context.read<WordChangeCubit>().wordChanged(
                                searchedWord: controller.text.toUpperCase(),
                                words: wordState.words,
                                mRow: wordState.mRow,
                                nColumn: wordState.nColumn
                            );
                            FocusScope.of(context).unfocus();
                          },
                          child: Padding(
                            padding: EdgeInsets.only(right: Sizes.dimen_0.w),
                            child: Text(
                              'Cancel',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                  color: AppColor.grey,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: BlocBuilder<WordChangeCubit, WordChangeState>(
                      builder: (context, wordChangeState) {
                        return GridView.builder(
                            padding: EdgeInsets.zero,
                            physics: const BouncingScrollPhysics(),
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: wordState.nColumn,
                            mainAxisSpacing: Sizes.dimen_3,
                            crossAxisSpacing: Sizes.dimen_3),
                            itemCount: wordState.words.length,
                            itemBuilder: (context, index) {
                              return Container(
                                decoration: BoxDecoration(
                                    color: wordChangeState.highlightedIndexes.contains(index) ? AppColor.green : AppColor.secondary,
                                    borderRadius: BorderRadius.circular(10.0)
                                ),
                                child: Center(
                                    child: Text(wordState.words[index],
                                      style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),)
                                ),
                              );
                            });
                      }
                    ),
                  )
                ],
              ),
            );
          }else if(wordState is WordSearchInitial) {
            return Center(
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(RouteList.createGrid);
                },
                  child: Text("Create grid +", style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold, color: AppColor.primary))
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
