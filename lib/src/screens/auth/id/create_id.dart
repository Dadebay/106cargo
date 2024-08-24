import 'package:flutter/material.dart';

import '../../../bottom_nav/bottom_nav.dart';
import '../../../design/app_colors.dart';
import '../components/custom_text_fild.dart';

class CreateId extends StatefulWidget {
  const CreateId({super.key});

  @override
  State<CreateId> createState() => _CreateIdState();
}

class _CreateIdState extends State<CreateId> {
  final TextEditingController idController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  void validateAndSave() {
    final FormState? form = _formKey.currentState;
    if (form!.validate()) {
    } else {}
  }

  String errorText = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/background.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.only(
                  right: 20,
                  left: 20,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
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
                  height: 340,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 30),
                        child: Center(
                          child: Text(
                            'ID döret',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 25,
                              fontFamily: 'Roboto',
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Center(
                          child: Text(
                            'Sargytlaryňyzy görmek üçin yzarlaýyş ID giriziň',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontFamily: 'Roboto',
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 15,
                          right: 15,
                          top: 20,
                        ),
                        child: CustomTextFild(
                          hint: 'ID giriziň',
                          controller: idController,
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
                      InkWell(
                        onTap: () {
                          if (idController.text.isEmpty) {
                            errorText = 'ID is empty.';
                          }
                          if (idController.text.isNotEmpty) {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const BottomNavAll(),
                              ),
                            );
                            // _onLoginButtonPressed();
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
                            height: 65,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: AppColors.mainColor,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Center(
                              child: Text(
                                'Tassykla',
                                style: TextStyle(
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
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
