import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:getx_mvvm/data/response/status.dart';
import 'package:getx_mvvm/resources/colors/colors.dart';
import 'package:getx_mvvm/resources/components/internet_exception_widget.dart';
import 'package:getx_mvvm/resources/routes/routes_name.dart';
import 'package:getx_mvvm/utils/utils.dart';
import 'package:getx_mvvm/view_models/controller/home_controller.dart';
import 'package:getx_mvvm/view_models/controller/random_quote_controller.dart';
import 'package:getx_mvvm/view_models/controller/user_preferance_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  UserPreferance userPreferance = UserPreferance();
  final homeController = Get.put(HomeController());
  final randomQuoteController = Get.put(RandomQuoteController());
  void initState() {
    homeController.userListApi();
    randomQuoteController.fetchNextRandomQuote();
    super.initState();
  }

  void dispose() {
    Get.delete<HomeController>();
    Get.delete<RandomQuoteController>();
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
                  title: "Logout",
                  middleText: "Do you want to exit this application?",
                  cancel: MaterialButton(
                    color: AppColors.blackColor.withOpacity(0.5),
                    minWidth: 80,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                      10,
                    )),
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
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                        10,
                      )),
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              height: 200,
              width: MediaQuery.of(context).size.width,
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.appColor.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Obx(() {
                  switch (randomQuoteController.RxQuoteStatus.value) {
                    case Status.LOADING:
                      return Center(child: CircularProgressIndicator());
                    case Status.ERROR:
                      return Center(
                        child:
                            Text(randomQuoteController.error.value.toString()),
                      );
                    case Status.COMPLATED:
                      return Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 5),
                            child: GestureDetector(
                              onTap: () {
                                Clipboard.setData(
                                  ClipboardData(
                                      text:
                                          '${randomQuoteController.quote.value.quote.toString()} -${randomQuoteController.quote.value.author.toString()}'),
                                );
                                Utils.toastMessage("Quote copied to clipboard");
                              },
                              child: Card(
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 130,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Spacer(),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8),
                                        child: RichText(
                                          softWrap: true,
                                          textAlign: TextAlign.center,
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                // recognizer: TapGestureRecognizer()
                                                //   ..onTap = () async {
                                                //   },
                                                text:
                                                    '${randomQuoteController.quote.value.quote.toString()}',
                                                style: TextStyle(
                                                    color: AppColors.blackColor,
                                                    fontSize: 12),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Spacer(),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            bottom: 10, right: 10),
                                        child: Align(
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                            "- ${randomQuoteController.quote.value.author.toString()}",
                                            style: TextStyle(
                                                fontStyle: FontStyle.italic,
                                                color: AppColors.blueColor,
                                                fontSize: 14),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          MaterialButton(
                            minWidth: 100,
                            color:
                                randomQuoteController.isLoading.value == false
                                    ? AppColors.whiteColor
                                    : AppColors.whiteColor.withOpacity(0.6),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                              10,
                            )),
                            onPressed: () {
                              randomQuoteController.isLoading.value == false
                                  ? randomQuoteController.fetchNextRandomQuote()
                                  : null;
                            },
                            child: Text("Genrate New"),
                          )
                        ],
                      );
                  }
                }),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: Obx(() {
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
                              height: 10,
                            );
                          },
                        ),
                      ),
                    );
                }
              }),
            ),
          ],
        ),
      ),
    );
  }
}
