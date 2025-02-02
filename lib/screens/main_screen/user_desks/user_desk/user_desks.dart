import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:prayer_bloc/screens/main_screen/user_desks/user_desk/widgets/add_user_category_dialog.dart';
import 'package:prayer_bloc/screens/main_screen/user_desks/user_desk/widgets/user_category_list.dart';

import '../../../../app_widgets/app_colors.dart';
import '../../../../app_widgets/app_images.dart';
import '../../../../bloc/user_desk/user_category_desk_bloc/user_category_desk_bloc.dart';
import '../../../../bloc/user_desk/user_category_desk_bloc/user_category_desk_state.dart';

class UserDesks extends StatefulWidget {
  const UserDesks({super.key});

  @override
  State<UserDesks> createState() => _UserDesksState();
}

class _UserDesksState extends State<UserDesks> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserDeskBloc, UserDeskState>(
      builder: (context, state) {
        if (state is LoadingCategoryDesk) {
          return Center(child: CircularProgressIndicator());
        } else if (state is LoadedCategoryDesk) {
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
                  child: state.categories.isEmpty
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
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              image: const DecorationImage(
                                image: AssetImage(AppImages.backGround),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: UserCategoryListView(
                                categories: state.categories),
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
        } else if (state is FailedLoadedCategoryDesk) {
          return Center(
              child: Text(
            'Error: ${state.error}',
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
        return const AddUserCategoryDialog();
      },
    );
  }
}
