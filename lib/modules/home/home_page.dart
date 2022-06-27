import 'package:bolao_palmeiras/app/models/partida_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    widget.controller.listenPartida();
    widget.controller.listenApostas();
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
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message ?? ''),
              backgroundColor: Colors.green,
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
                builder: (context, partida) => Column(
                  children: [
                    AppBarJogo(
                      campeonato: partida?.campeonato ?? 'CAMPEONATO',
                      controller: widget.controller,
                    ),
                    _jogoWidget(partida: partida),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: SizedBox(
                        height: 23,
                        width: 188,
                        child: Center(
                          child: Text(
                            "${partida?.data ?? '--/--/----'} - ${partida?.hora ?? "--:--"}",
                            style: const TextStyle(
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: SizedBox(
                        height: 23,
                        child: Center(
                          child: Text(
                              "R\$ ${partida?.valorAposta.toString() ?? "0"},00"),
                        ),
                      ),
                    ),
                  ],
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
                    return Apostas(
                      apostas: apostas ?? [],
                    );
                  }),
              Container(
                padding: const EdgeInsets.only(top: 16),
                color: Colors.black,
                height: 2,
                width: MediaQuery.of(context).size.width,
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 9.0, bottom: 9, left: 20, right: 20),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.green),
                    onPressed: () async {
                      if (!((_mandanteEC.text.isEmpty ||
                              int.tryParse(_mandanteEC.text) == null) ||
                          (_visitanteEC.text.isEmpty ||
                              int.tryParse(_visitanteEC.text) == null))) {
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
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
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

    return Padding(
      padding: const EdgeInsets.only(top: 32, left: 0, right: 0),
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          image: const DecorationImage(
            fit: BoxFit.cover,
            //opacity: 0.5,
            image: AssetImage('assets/images/fundo_partida.jpg'),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.4),
              blurRadius: 2,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 70,
                    width: 70,
                    child: Image.network(partida?.imageUrlMandante ?? '',
                        errorBuilder: (context, error, stackTrace) => Center(
                                child: Text(
                              mandante.toUpperCase(),
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10,
                                  color: Colors.white),
                            ))),
                  ),
                  const SizedBox(
                    width: 26,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white,
                    ),
                    height: 50,
                    width: 50,
                    child: TextFormField(
                      controller: _mandanteEC,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
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
                    ),
                    child: TextFormField(
                      controller: _visitanteEC,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      decoration: InputDecoration(
                        errorStyle: const TextStyle(
                            height: 0, fontSize: 0, color: Colors.transparent),
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
                            fontWeight: FontWeight.bold,
                            fontSize: 10,
                            color: Colors.white),
                      )),
                    ),

                    /* Image.asset(
                      'assets/images/escudos/${visitante.toLowerCase()}.png',
                      
                    ), */
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
