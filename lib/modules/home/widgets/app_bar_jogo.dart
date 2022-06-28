part of '../home_page.dart';

class AppBarJogo extends StatelessWidget {
  final HomeController controller;
  const AppBarJogo({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 96,
      child: Material(
        elevation: 5,
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              opacity: 0.8,
              image: AssetImage(
                'assets/images/app_bar.png',
              ),
            ),
          ),
        ),
      ),
    );
  }
}
