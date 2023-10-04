import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_mvvm/data/response/status.dart';
import 'package:getx_mvvm/resources/colors/colors.dart';
import 'package:getx_mvvm/resources/components/internet_exception_widget.dart';
import 'package:getx_mvvm/resources/routes/routes_name.dart';
import 'package:getx_mvvm/view_models/controller/home_controller.dart';
import 'package:getx_mvvm/view_models/controller/user_preferance_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  UserPreferance userPreferance = UserPreferance();
  final homeController = Get.put(HomeController());
  void initState() {
    homeController.userListApi();
    super.initState();
  }

  void dispose() {
    Get.delete<HomeController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HomeScreen"),
        automaticallyImplyLeading: false,
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Get.defaultDialog(
                  title: "",
                  middleText: "Do you want to exit this application?",
                  cancel: MaterialButton(
                    color: AppColors.blackColor.withOpacity(0.5),
                    minWidth: 80,
                    onPressed: () {
                      Get.back();
                    },
                    child: Text(
                      "No",
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(color: AppColors.whiteColor),
                    ),
                  ),
                  confirm: MaterialButton(
                      color: AppColors.blueColor.withOpacity(0.5),
                      minWidth: 80,
                      onPressed: () {
                        Get.back();
                        userPreferance.logOut().then((value) {
                          Get.offNamedUntil(
                              RouteName.loginScreen, (route) => false);
                        });
                      },
                      child: Text("Yes")));
            },
            icon: Icon(
              Icons.logout_outlined,
            ),
          ),
        ],
      ),
      body: Obx(() {
        switch (homeController.RxRequestStatus.value) {
          case Status.LOADING:
            return Center(
              child: CircularProgressIndicator(),
            );
          case Status.ERROR:
            if (homeController.error.value == 'No internet') {
              return InternetExceptionWidget(
                onTap: () {
                  return homeController.refreshUserListApi();
                },
              );
            } else {
              return Center(
                child: Text(homeController.error.value),
              );
            }
          case Status.COMPLATED:
            return RefreshIndicator(
              onRefresh: () {
                return Future.delayed(Duration(seconds: 1), () {
                  homeController.refreshUserListApi();
                });
              },
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: ListView.separated(
                  primary: false,
                  shrinkWrap: true,
                  itemCount: homeController.userList.value.data!.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(homeController
                              .userList.value.data![index].avatar
                              .toString()),
                        ),
                        title: Text(
                            '${homeController.userList.value.data![index].firstName.toString()} ${homeController.userList.value.data![index].lastName.toString()}'),
                        subtitle: Text(
                            '${homeController.userList.value.data![index].email.toString()}'),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      height: 50,
                    );
                  },
                ),
              ),
            );
        }
      }),
    );
  }
}
