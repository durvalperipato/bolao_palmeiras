part of '../home_page.dart';

class AppBarJogo extends StatelessWidget {
  final HomeController controller;
  final String campeonato;
  const AppBarJogo({
    Key? key,
    required this.campeonato,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 96,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Material(
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
          Align(
            alignment: const Alignment(0, 1.5),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 86),
              child: Material(
                elevation: 5,
                child: Container(
                  height: 32,
                  decoration: const BoxDecoration(color: Colors.transparent),
                  child: Center(
                    child: Text(
                      campeonato,
                      style: TextStyle(
                        color: Colors.black.withOpacity(
                          .8,
                        ),
                        letterSpacing: 5,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          /*  Align(
            alignment: Alignment.topLeft,
            child: PopupMenuButton(
              onSelected: (value) async {
                if (value == 'Sair') {
                  await controller.signOut();

                  Modular.to.pushReplacementNamed('/login/');
                }
              },
              itemBuilder: ((context) => [
                    const PopupMenuItem(
                      value: 'Sair',
                      child: Text('Sair'),
                    ),
                  ]),
            ),
          ), */
        ],
      ),
    );
  }
}
