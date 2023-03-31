import 'package:credit_card_ui/presentation/components/animations/slide_and_opasity_animation.dart';
import 'package:credit_card_ui/presentation/components/app_page_with_cubit.dart';
import 'package:credit_card_ui/presentation/pages/profile/cubit/profile_cubit.dart';
import 'package:flutter/material.dart';

import '../../components/app_text.dart';
import '../../styles/app_colors.dart';

class ProfilePage extends AppPageWithCubit<ProfileCubit, ProfileState> {
  ProfilePage({super.key}) : super(bloc: ProfileCubit());

  List<IconData> listIcons = [
    Icons.translate,
    Icons.security,
    Icons.notifications,
    Icons.image,
    Icons.exit_to_app,
  ];
  List<String> listTitles = [
    "Languages",
    "Security",
    "Notification",
    "Mode",
    "Exit",
  ];

  @override
  Widget build(BuildContext context, state) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                backgroundColor: AppColors.black,
                centerTitle: true,
                title: const AppText(
                  "Profile",
                  fontWeight: FontWeight.w500,
                ),
              )
            ];
          },
          body: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              SlideAndOpasityAnimation(
                  slideBegin: const Offset(0, -0.2),
                  opasityDuration: 100,
                  slideDuration: 500,
                  child: _header()),
              const SizedBox(
                height: 10,
              ),
              _preferences()
            ],
          )),
    );
  }

  Widget _preferences() {
    return Expanded(
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
            color: AppColors.blackGrey2),
        child: Column(
          children: List.generate(listIcons.length, (index) {
            return SlideAndOpasityAnimation(
                opasityDuration: 100,
                slideDuration: ((index + 1) % 10) * 250,
                child: _myItem(listTitles[index], listIcons[index]));
          }),
        ),
      ),
    );
  }

  Widget _header() {
    return Column(
      children: [
        Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30), color: AppColors.grey),
          child: Icon(
            Icons.person,
            size: 85,
            color: AppColors.blackGrey2,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        AppText(
          "Preferences",
          size: 20,
          color: AppColors.white,
        )
      ],
    );
  }

  Widget _myItem(String title, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: ListTile(
        trailing: Icon(
          Icons.chevron_right_rounded,
          color: AppColors.white,
          size: 30,
        ),
        title: AppText(
          title,
          color: AppColors.white,
          size: 20,
          fontWeight: FontWeight.w500,
        ),
        leading: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18), color: AppColors.black),
          child: Icon(
            icon,
            color: AppColors.white,
          ),
        ),
      ),
    );
  }
}
