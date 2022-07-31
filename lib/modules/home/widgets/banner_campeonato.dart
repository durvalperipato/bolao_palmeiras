import 'package:flutter/material.dart';

class BannerCampeonato extends StatelessWidget {
  final String? campeonato;

  const BannerCampeonato({Key? key, required this.campeonato})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 80,
      left: 0,
      right: 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 86),
        child: Container(
          height: 32,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromRGBO(117, 157, 127, 1),
                Color.fromRGBO(95, 109, 83, 1),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black,
                offset: Offset(-2, -2),
                blurRadius: 2,
              ),
              BoxShadow(
                color: Colors.white70,
                offset: Offset(1, 1),
                blurRadius: 2,
              ),
            ],
          ),
          child: Center(
            child: Text(
              campeonato ?? 'CAMPEONATO',
              style: TextStyle(
                color: Colors.black.withOpacity(
                  .6,
                ),
                letterSpacing: 2,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
