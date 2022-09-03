import 'package:bolao_palmeiras/app/models/partida_model.dart';
import 'package:bolao_palmeiras/modules/home/widgets/banner_campeonato.dart';
import 'package:bolao_palmeiras/modules/home/widgets/empty_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../app/models/aposta_model.dart';
import 'controller/home_controller.dart';

part 'widgets/apostas.dart';
part 'widgets/app_bar_jogo.dart';

class HomePage extends StatefulWidget {
  final HomeController controller;
  const HomePage({Key? key, required this.controller}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _formKey = GlobalKey<FormState>();
  final _mandanteEC = TextEditingController();
  final _visitanteEC = TextEditingController();

  @override
  void initState() {
    widget.controller.listenDados();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _mandanteEC.dispose();
    _visitanteEC.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeController, HomeState>(
      bloc: widget.controller,
      listener: ((context, state) {
        if (state.status == HomeStatus.failure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message ?? 'Erro interno'),
              backgroundColor: Colors.red,
            ),
          );
        } else if (state.status == HomeStatus.success) {
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              duration: const Duration(seconds: 1),
              elevation: 5,
              content: SizedBox(height: 100, child: Text(state.message ?? '')),
              backgroundColor: Colors.orange,
            ),
          );
        }
      }),
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(
                'assets/images/fundo_2.jpg',
              ),
            ),
          ),
          child: Column(
            children: [
              BlocSelector<HomeController, HomeState, PartidaModel?>(
                bloc: widget.controller,
                selector: (state) => state.partida,
                builder: (context, partida) => SizedBox(
                  height: 256,
                  child: Stack(
                    children: [
                      AppBarJogo(
                        controller: widget.controller,
                        partida: partida,
                      ),
                      _jogoWidget(partida: partida),
                      BannerCampeonato(campeonato: partida?.campeonato)
                    ],
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 16, bottom: 24),
                color: Colors.black,
                height: 2,
                width: MediaQuery.of(context).size.width,
              ),
              BlocSelector<HomeController, HomeState, List<ApostaModel>?>(
                bloc: widget.controller,
                selector: (state) => state.apostas,
                builder: (context, apostas) {
                  return Visibility(
                    visible: apostas?.isNotEmpty ?? true,
                    replacement: const EmptyState(),
                    child: Apostas(
                      apostas: apostas ?? [],
                    ),
                  );
                },
              ),
              Container(
                padding: const EdgeInsets.only(top: 16),
                color: Colors.black,
                height: 2,
                width: MediaQuery.of(context).size.width,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 9.0, bottom: 9, left: 20, right: 20),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                    onPressed: () async {
                      if (!((_mandanteEC.text.isEmpty || int.tryParse(_mandanteEC.text) == null) ||
                          (_visitanteEC.text.isEmpty || int.tryParse(_visitanteEC.text) == null))) {
                        await widget.controller.bet(
                          user: widget.controller.userName,
                          placarMandante: _mandanteEC.text,
                          placarVisitante: _visitanteEC.text,
                          avatarUrl: widget.controller.avatar ?? '',
                        );
                        _visitanteEC.clear();
                        _mandanteEC.clear();
                      } else {
                        ScaffoldMessenger.of(context).clearSnackBars();
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text(
                              'Não foi possível enviar a aposta - Placar igual ou número inválido'),
                          backgroundColor: Colors.red,
                        ));
                      }
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                    child: const Center(
                      child: Text('Incluir Aposta'),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _jogoWidget({required PartidaModel? partida}) {
    String mandante = partida?.mandante ?? '';
    String visitante = partida?.visitante ?? '';

    return Positioned(
      top: 96,
      left: 0,
      right: 0,
      child: Container(
        height: 160,
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage('assets/images/fundo_partida.jpg'),
          ),
        ),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 70,
                      width: 70,
                      child: Image.network(
                        partida?.imageUrlMandante ?? '',
                        errorBuilder: (context, error, stackTrace) => Center(
                          child: Text(
                            mandante.toUpperCase(),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 10, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 26),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                            offset: Offset(0, 3),
                            color: Colors.black87,
                            blurRadius: 4,
                          ),
                        ],
                      ),
                      height: 50,
                      width: 50,
                      child: TextFormField(
                        controller: _mandanteEC,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(
                              color: Colors.black.withOpacity(0.3),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const SizedBox(
                      height: 50,
                      width: 16,
                      child: Center(
                        child: Text(
                          'x',
                          style: TextStyle(fontSize: 24),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                            offset: Offset(0, 3),
                            color: Colors.black87,
                            blurRadius: 4,
                          ),
                        ],
                      ),
                      child: TextFormField(
                        controller: _visitanteEC,
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        decoration: InputDecoration(
                          errorStyle:
                              const TextStyle(height: 0, fontSize: 0, color: Colors.transparent),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(
                              color: Colors.green,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(
                              color: Colors.black.withOpacity(0.3),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 26,
                    ),
                    SizedBox(
                      height: 70,
                      width: 70,
                      child: Image.network(
                        partida?.imageUrlVisitante ?? '',
                        errorBuilder: (context, error, stackTrace) => Center(
                          child: Text(
                            visitante.toUpperCase(),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 10, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: SizedBox(
                  height: 23,
                  width: 188,
                  child: Center(
                    child: Text(
                      "${partida?.data ?? ''} - ${partida?.hora ?? ""}",
                      style: const TextStyle(
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold,
                          color: Colors.white70),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 23,
                child: Center(
                  child: Text(
                    "R\$ ${partida?.valorAposta.toString() ?? "0"},00",
                    style: const TextStyle(color: Colors.white70, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
