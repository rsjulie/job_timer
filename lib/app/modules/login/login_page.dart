import 'package:asuka/asuka.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_timer/app/modules/login/controller/login_controller.dart';

class LoginPage extends StatelessWidget {
  final LoginController controller;
  const LoginPage({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return BlocListener<LoginController, LoginState>(
        bloc: controller,
        listenWhen: (previous, current) => previous.status != current.status,
        listener: (context, state) {
          if (state.status == LoginStatus.failure) {
            final message = state.errorMessage ?? 'Erro ao realizar login';
            AsukaSnackbar.alert(message).show();
          }
        },
        child: Scaffold(
            body: Container(
          decoration: const BoxDecoration(
            gradient:
                LinearGradient(colors: [Color(0xff0092B9), Color(0xff0167b2)]),
          ),
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/clock.png'),
              SizedBox(height: screenSize.height * 0.1),
              SizedBox(
                height: 50,
                width: screenSize.width * 0.8,
                child: ElevatedButton(
                  onPressed: () {
                    controller.signIn();
                  },
                  style: ElevatedButton.styleFrom(primary: Colors.white),
                  child: Image.asset('assets/images/google.png'),
                ),
              ),
              BlocSelector<LoginController, LoginState, bool>(
                  bloc: controller,
                  selector: (state) {
                    return state.status == LoginStatus.loading;
                  },
                  builder: (context, show) {
                    return Visibility(
                      visible: show,
                      child: const Padding(
                        padding: EdgeInsets.only(top: 15),
                        child: Center(
                          child: CircularProgressIndicator(
                            backgroundColor: Colors.white,
                          ),
                        ),
                      ),
                    );
                  })
            ],
          )),
        )));
  }
}
