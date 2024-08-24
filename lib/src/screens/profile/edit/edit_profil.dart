// ignore_for_file: use_build_context_synchronously

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kargo_app/src/application/settings_singleton.dart';
import 'package:kargo_app/src/screens/auth/login/repository_login.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../design/app_colors.dart';
import '../../auth/components/custom_text_fild.dart';
import '../../auth/model/me_model.dart';
import '../../initial/repository/change_profil_info_repository.dart';

// ignore: must_be_immutable
class EditProfil extends StatefulWidget {
  UserData model;
  EditProfil({required this.model, super.key});

  @override
  State<EditProfil> createState() => _EditProfilState();
}

class _EditProfilState extends State<EditProfil> {
  late final TextEditingController nameController;
  late final TextEditingController lastNameController;
  // late final TextEditingController userNameController;
  late final TextEditingController phoneNumberntroller;
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController idController = TextEditingController();
  final TextEditingController passwordConfirmController = TextEditingController();

  bool _isHidden = true;
  bool _isHidden2 = true;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  void validateAndSave() {
    final FormState? form = _formKey.currentState;
    if (form!.validate()) {
    } else {}
  }

  String errorText = '';
  String errorText2 = '';
  String errorText3 = '';
  String errorText4 = '';
  String errorText5 = '';
  String errorText6 = '';

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.model.firstName);
    lastNameController = TextEditingController(text: widget.model.lastName);
    phoneNumberntroller = TextEditingController(text: widget.model.phone);

    // fetchData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.blueGrey.withOpacity(0.1),
                spreadRadius: 3,
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: AppBar(
            backgroundColor: Colors.white,
            toolbarHeight: 70,
            elevation: 0,
            centerTitle: true,
            iconTheme: const IconThemeData(color: AppColors.profilColor, size: 30),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(15),
              ),
            ),
            title: Text(
              'profile'.tr(),
              style: const TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontFamily: 'Roboto',
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(
                bottom: 40,
                right: 20,
                left: 20,
                top: 40,
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blueGrey.withOpacity(0.1),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15, right: 15, top: 30),
                      child: CustomTextFild(
                        hint: 'Ady',
                        controller: nameController,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, top: 5.0),
                      child: Text(
                        errorText,
                        style: TextStyle(
                          fontSize: 12.0,
                          color: Colors.red[700],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 15,
                        right: 15,
                      ),
                      child: CustomTextFild(
                        hint: 'Familiýasy',
                        controller: lastNameController,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, top: 5.0),
                      child: Text(
                        errorText2,
                        style: TextStyle(
                          fontSize: 12.0,
                          color: Colors.red[700],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    // Padding(
                    //     padding: const EdgeInsets.only(
                    //       left: 15,
                    //       right: 15,
                    //     ),
                    //     child: CustomTextFild(
                    //         hint: 'Ulanyjy ady',
                    //         controller: userNameController)),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, top: 5.0),
                      child: Text(
                        errorText3,
                        style: TextStyle(
                          fontSize: 12.0,
                          color: Colors.red[700],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 15,
                        right: 15,
                      ),
                      child: Container(
                        height: 60,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: AppColors.textFildColor,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(left: 8),
                              child: Padding(
                                padding: EdgeInsets.only(
                                  left: 10,
                                  right: 10,
                                  top: 6,
                                  bottom: 6,
                                ),
                                child: Text(
                                  '+993',
                                  style: TextStyle(
                                    color: AppColors.authTextColor,
                                    fontSize: 18,
                                    fontFamily: 'Montserrat',
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                color: AppColors.authTextColor,
                                height: 20,
                                width: 1,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width / 1.8,
                                child: TextFormField(
                                  controller: phoneNumberntroller,
                                  maxLines: 1,
                                  keyboardType: TextInputType.phone,
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, top: 5.0),
                      child: Text(
                        errorText4,
                        style: TextStyle(
                          fontSize: 12.0,
                          color: Colors.red[700],
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: 10.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: Container(
                        height: 60,
                        decoration: BoxDecoration(
                          color: AppColors.textFildColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Center(
                            child: TextFormField(
                              controller: passwordController,
                              maxLines: 1,
                              obscureText: _isHidden,
                              keyboardType: TextInputType.visiblePassword,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                hintText: 'key_word'.tr(),
                                hintStyle: const TextStyle(
                                  color: AppColors.authTextColor,
                                  fontSize: 18,
                                  fontFamily: 'Roboto',
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.w400,
                                ),
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _isHidden = !_isHidden;
                                    });
                                  },
                                  child: _isHidden
                                      ? const Icon(Icons.visibility_outlined)
                                      : const Icon(
                                          Icons.visibility_off_outlined,
                                        ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, top: 5.0),
                      child: Text(
                        errorText5,
                        style: TextStyle(
                          fontSize: 12.0,
                          color: Colors.red[700],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: Container(
                        height: 60,
                        decoration: BoxDecoration(
                          color: AppColors.textFildColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Center(
                            child: TextFormField(
                              controller: passwordConfirmController,
                              maxLines: 1,
                              obscureText: _isHidden2,
                              keyboardType: TextInputType.visiblePassword,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                hintText: 'confirm_password'.tr(),
                                hintStyle: const TextStyle(
                                  color: AppColors.authTextColor,
                                  fontSize: 18,
                                  fontFamily: 'Roboto',
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.w400,
                                ),
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _isHidden2 = !_isHidden2;
                                    });
                                  },
                                  child: _isHidden2
                                      ? const Icon(Icons.visibility_outlined)
                                      : const Icon(
                                          Icons.visibility_off_outlined,
                                        ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, top: 5.0),
                      child: Text(
                        errorText6,
                        style: TextStyle(
                          fontSize: 12.0,
                          color: Colors.red[700],
                        ),
                      ),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.only(
                    //     left: 22,
                    //     right: 10,
                    //   ),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     children: [
                    //       Row(
                    //         mainAxisAlignment: MainAxisAlignment.start,
                    //         crossAxisAlignment: CrossAxisAlignment.center,
                    //         children: [
                    //           const Text(
                    //             'ID',
                    //             style: TextStyle(
                    //                 color: Colors.black,
                    //                 fontSize: 16,
                    //                 fontFamily: 'Roboto',
                    //                 fontStyle: FontStyle.normal,
                    //                 fontWeight: FontWeight.w400),
                    //           ),
                    //           IconButton(
                    //             onPressed: () {
                    //               showDalog();
                    //             },
                    //             icon: const Icon(
                    //               Icons.info_rounded,
                    //               color: Colors.grey,
                    //             ),
                    //           ),
                    //         ],
                    //       ),
                    //       IconButton(
                    //         onPressed: () {},
                    //         icon: Container(
                    //           height: 25,
                    //           width: 25,
                    //           decoration: const BoxDecoration(
                    //               shape: BoxShape.circle,
                    //               color: AppColors.mainColor),
                    //           child: const Center(
                    //               child: Icon(
                    //             Icons.add,
                    //             size: 20,
                    //             color: Colors.white,
                    //           )),
                    //         ),
                    //       )
                    //     ],
                    //   ),
                    // ),
                    // Padding(
                    //   padding: const EdgeInsets.only(left: 15, right: 15),
                    //   child: Container(
                    //     height: 60,
                    //     width: MediaQuery.of(context).size.width,
                    //     decoration: BoxDecoration(
                    //       color: AppColors.textFildColor,
                    //       borderRadius: BorderRadius.circular(15),
                    //     ),
                    //     child: Padding(
                    //       padding: const EdgeInsets.only(left: 20),
                    //       child: Center(
                    //         child: TextFormField(
                    //           controller: idController,
                    //           maxLines: 1,
                    //           keyboardType: TextInputType.text,
                    //           decoration: InputDecoration(
                    //               border: InputBorder.none,
                    //               focusedBorder: InputBorder.none,
                    //               enabledBorder: InputBorder.none,
                    //               errorBorder: InputBorder.none,
                    //               disabledBorder: InputBorder.none,
                    //               hintText: 'ID',
                    //               suffixIcon: InkWell(
                    //                 onTap: () {
                    //                   showDalogdDelet();
                    //                 },
                    //                 child: Padding(
                    //                   padding: const EdgeInsets.all(10.0),
                    //                   child: CustomIcon(
                    //                       title: 'assets/icons/x.svg',
                    //                       height: 0,
                    //                       width: 0,
                    //                       color: AppColors.authTextColor),
                    //                 ),
                    //               ),
                    //               hintStyle: const TextStyle(
                    //                   color: AppColors.authTextColor,
                    //                   fontSize: 18,
                    //                   fontFamily: 'Roboto',
                    //                   fontStyle: FontStyle.normal,
                    //                   fontWeight: FontWeight.w400)),
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    InkWell(
                      onTap: () {
                        if (lastNameController.text.isEmpty) {
                          setState(() {
                            errorText2 = 'Last name is empty.';
                          });
                        }
                        // if (userNameController.text.isEmpty) {
                        //   setState(() {
                        //     errorText3 = 'User name is empty.';
                        //   });
                        // }
                        if (phoneNumberntroller.text.isEmpty) {
                          setState(() {
                            errorText4 = 'Phone number is empty.';
                          });
                        }
                        // if (phoneNumberntroller.text.isEmpty) {
                        //   setState(() {
                        //     errorText5 = 'Password is empty.';
                        //   });
                        // }
                        // if (passwordConfirmController.text.isEmpty) {
                        //   setState(() {
                        //     errorText6 = 'Password confirmation is empty.';
                        //   });
                        // }
                        if (nameController.text.isEmpty) {
                          errorText = 'Name is empty.';
                        }
                        if (nameController.text.isNotEmpty && phoneNumberntroller.text.isNotEmpty) {
                          ChangePInfoRepositorys().saveInfo(
                            context,
                            widget.model.id,
                            nameController.text,
                            lastNameController.text,
                            phoneNumberntroller.text,
                            passwordController.text,
                            passwordConfirmController.text,
                          );
                        } else {}
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 40,
                          right: 20,
                          left: 20,
                          bottom: 30,
                        ),
                        child: Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: AppColors.mainColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                            child: Text(
                              'save'.tr(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontFamily: 'Roboto',
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    Center(
                      child: TextButton(
                        onPressed: () {
                          showDalogdExit();
                        },
                        child: Text(
                          'delet_ac'.tr(),
                          style: const TextStyle(color: Colors.red),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future showDalog() async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
          title: const Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'ID',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontFamily: 'Roboto',
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  'Harydy  yzarlamak üçin ID kod girizmeli. Bir ulanyjynyň birnäçe ID kody bolup biler',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontFamily: 'Roboto',
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future showDalogdDelet() async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  'Siz D45 ID koduny pozmak isleýärsiňizmi?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontFamily: 'Roboto',
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 40,
                      width: MediaQuery.of(context).size.width / 3 - 20,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.blue[100],
                      ),
                      child: const Center(
                        child: Text(
                          'Hawa',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColors.mainColor,
                            fontSize: 16,
                            fontFamily: 'Roboto',
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 40,
                      width: MediaQuery.of(context).size.width / 3 - 20,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.mainColor,
                      ),
                      child: const Center(
                        child: Text(
                          'Ýok',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: 'Roboto',
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future showDalogdExit() async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  'delet_acccount'.tr(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontFamily: 'Roboto',
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Consumer<SettingsSingleton>(
                      builder: (_, settings, __) {
                        return InkWell(
                          onTap: () async {
                            final SharedPreferences preferences = await SharedPreferences.getInstance();
                            final String? val = preferences.getString('token');
                            await preferences.remove('token');

                            await settings.logout();
                            await LogOutRepository().logOut(context, val!);
                          },
                          child: Container(
                            height: 40,
                            width: MediaQuery.of(context).size.width / 3 - 20,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.blue[100],
                            ),
                            child: Center(
                              child: Text(
                                'yes'.tr(),
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: AppColors.mainColor,
                                  fontSize: 16,
                                  fontFamily: 'Roboto',
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        height: 40,
                        width: MediaQuery.of(context).size.width / 3 - 20,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColors.mainColor,
                        ),
                        child: Center(
                          child: Text(
                            'no'.tr(),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontFamily: 'Roboto',
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
