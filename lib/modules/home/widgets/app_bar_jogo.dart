part of '../home_page.dart';

class AppBarJogo extends StatelessWidget {
  final HomeController controller;
  final PartidaModel? partida;
  const AppBarJogo({
    Key? key,
    required this.controller,
    required this.partida,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 96,
      child: Material(
        elevation: 5,
        child: Stack(
          children: [
            Container(
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
            Visibility(
              visible: controller.isAdmin,
              child: Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  onPressed: () {
                    Modular.to.pushNamed('/admin/', arguments: partida);
                  },
                  icon: const Icon(
                    Icons.sports_soccer,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
