import 'package:flutter/material.dart';

class EmptyState extends StatelessWidget {
  const EmptyState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 36,
              ),
              Image.asset(
                "assets/images/empty_state.png",
                height: 120,
                width: 120,
              ),
              const SizedBox(
                height: 36,
              ),
              const Text(
                'NENHUMA APOSTA REALIZADA!',
                style: TextStyle(
                    fontFamily: 'Antiga', fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      ),
    );
  }
}
