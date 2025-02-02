import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:prayer_bloc/app_widgets/app_colors.dart';
import 'package:prayer_bloc/screens/main_screen/my_desk/my_desk/widgets/add_category_dialog.dart';
import 'package:prayer_bloc/screens/main_screen/my_desk/my_desk/widgets/my_category_list.dart';

import '../../../../app_widgets/app_images.dart';
import '../../../../bloc/my_desk/my_category_desk_bloc/my_category_desk_bloc.dart';
import '../../../../bloc/my_desk/my_category_desk_bloc/my_category_desk_state.dart';

class MyDesk extends StatefulWidget {
  const MyDesk({super.key});

  @override
  State<MyDesk> createState() => _MyDeskState();
}

class _MyDeskState extends State<MyDesk> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyDeskBloc, MyDeskState>(
      builder: (context, state) {
        if (state.status == MyDeskStatus.loading) {
          return Center(child: CircularProgressIndicator());
        } else if (state.status == MyDeskStatus.success) {
          return Scaffold(
            appBar: AppBar(
              actions: [
                IconButton(
                  icon: const Icon(Icons.logout),
                  onPressed: () {
                    context.go('/login');
                  },
                ),
              ],
            ),
            body: Column(
              children: [
                Expanded(
                  flex: 1,
                  child: state.categories!.isEmpty
                      ? Center(
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 20, left: 10, right: 10),
                            child: Container(
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(AppImages.noColumn),
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.all(10),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              image: const DecorationImage(
                                image: AssetImage(AppImages.backGround),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child:
                                CategoryListView(categories: state.categories!),
                          ),
                        ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 290, right: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        width: 60.0,
                        height: 60.0,
                        child: FloatingActionButton(
                          backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          onPressed: () {
                            _showAddModal(context);
                          },
                          child: const Icon(Icons.add, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        } else if (state.status == MyDeskStatus.error) {
          return Center(
              child: Text(
            'Error: ${state.errorMessage}',
            style: TextStyle(color: AppColors.error),
          ));
        }
        return Container();
      },
    );
  }

  void _showAddModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const AddCategoryDialog();
      },
    );
  }
}
