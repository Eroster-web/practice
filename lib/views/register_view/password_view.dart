import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/bloc/app_bloc.dart';
import 'package:login/controllers/email_and_password_controller.dart';

class PasswordView extends StatefulWidget {
  const PasswordView({super.key});

  @override
  State<PasswordView> createState() => _PasswordViewState();
}

class _PasswordViewState extends State<PasswordView> {
  bool visiblePassword = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        elevation: 0,
        backgroundColor: Colors.white.withOpacity(0),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 50),
            ),
            Padding(
              padding: EdgeInsets.only(left: 25, bottom: 25),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Insert a password',
                      style:
                          TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Insert a password to creat your account',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 25),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    Icon(
                      Icons.password,
                      color: Colors.grey.shade500,
                    ),
                    SizedBox(
                      height: 50,
                      width: 250,
                      child: TextField(
                        controller: passwordcontroller,
                        obscureText: visiblePassword,
                        autofocus: true,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                visiblePassword = !visiblePassword;
                              });
                            },
                            icon: const Icon(
                              Icons.remove_red_eye,
                            ),
                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.amber),
                          ),
                          hintText: 'Password',
                          hintStyle: TextStyle(color: Colors.grey.shade500),
                          enabledBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey.shade500)),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            BlocBuilder<AppBloc, AppState>(
              builder: (context, state) {
                return Padding(
                  padding: EdgeInsets.only(top: 50),
                  child: Align(
                    alignment: Alignment.center,
                    child: state.isLoading
                        ? CircularProgressIndicator()
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: SizedBox(
                              height: 50,
                              width: 250,
                              child: MaterialButton(onPressed: () {
                                context.read<AppBloc>().add(
                                      AppEventRegister(
                                          email: emailcontroller.text,
                                          password: passwordcontroller.text),
                                    );
                                Navigator.of(context)
                                    .popUntil((route) => route.isFirst);
                              },
                              color: Colors.amber,
                              child: Text('Confirm'),
                              ),
                            ),
                          ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
