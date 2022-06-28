import 'package:bolao_palmeiras/modules/login/controller/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatelessWidget {
  final LoginController controller;
  const LoginPage({required this.controller, super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return BlocListener<LoginController, LoginState>(
      bloc: controller,
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status == LoginStatus.failure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage ?? 'Erro ao realizar login'),
            ),
          );
        }
      },
      child: Scaffold(
        body: Stack(
          children: [
            SizedBox(
              height: screenSize.height,
              width: screenSize.width,
              child: Image.asset(
                'assets/images/fundo.jpg',
                fit: BoxFit.cover,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: screenSize.height * .4,
                  width: screenSize.width * .4,
                  child: Image.asset('assets/images/palmeiras.png'),
                ),
                /*  Center(
                  child: SizedBox(
                    width: screenSize.width * .8,
                    height: screenSize.height * .05,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green,
                      ),
                      onPressed: () => {
                        Modular.to.push(route)
                      },
                      child: const Text('Duba'),
                    ),
                  ),
                ), */

                Center(
                  child: SizedBox(
                    width: screenSize.width * .8,
                    height: 49,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                      ),
                      onPressed: () => {
                        controller.signIn(),
                      },
                      child: Image.asset('assets/images/google.png'),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                BlocSelector<LoginController, LoginState, bool>(
                  bloc: controller,
                  selector: (state) => state.status == LoginStatus.loading,
                  builder: (context, showLoading) => Visibility(
                    visible: showLoading,
                    child: const Center(
                      child: CircularProgressIndicator.adaptive(),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
