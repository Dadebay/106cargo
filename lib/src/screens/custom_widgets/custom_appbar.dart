import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool? backButton;
  const CustomAppBar({
    required this.title,
    Key? key,
    this.backButton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      centerTitle: true,
      scrolledUnderElevation: 0.0,
      toolbarHeight: 70,
      leading: backButton == false || backButton == null
          ? const SizedBox.shrink()
          : IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(
                IconlyLight.arrow_left_circle,
                color: Colors.black,
              ),
            ),
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Text(
        title,
        style: const TextStyle(
          fontFamily: 'Roboto',
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
      ),
      flexibleSpace: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.grey.withOpacity(0.4),
              offset: const Offset(3, 3),
            ),
          ],
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
