import 'package:bolao_palmeiras/app/models/campeonato_model.dart';
import 'package:bolao_palmeiras/modules/admin/controller/admin_controller.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../app/models/time_model.dart';

class AdminPage extends StatefulWidget {
  final AdminController controller;
  final int? valorAposta;

  const AdminPage(
      {Key? key, required AdminController adminController, this.valorAposta})
      : controller = adminController,
        super(key: key);

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  String timeMandante = 'Palmeiras';
  String timeVisitante = 'Flamengo';
  String campeonato = 'Brasileiro';

  String imageUrl =
      "https://media.sproutsocial.com/uploads/2017/02/10x-featured-social-media-image-size.png";

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _horaEC = TextEditingController();
  final TextEditingController _dataEC = TextEditingController();
  final TextEditingController _valorEC = TextEditingController();

  @override
  void initState() {
    super.initState();
    widget.controller.buscarDados();
  }

  @override
  void dispose() {
    _horaEC.dispose();
    _dataEC.dispose();
    _valorEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AdminController, AdminState>(
      bloc: widget.controller,
      listener: ((context, state) {
        if (state.status == AdminStatus.failure) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                  'Não foi possível carregar os dados dos times e campeonatos'),
            ),
          );
        }
      }),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Admin Page'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(32.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  BlocSelector<AdminController, AdminState,
                          List<CampeonatoModel>>(
                      bloc: widget.controller,
                      selector: ((state) => state.campeonatos),
                      builder: (context, campeonatos) {
                        return Row(
                          children: [
                            const SizedBox(
                              height: 50,
                              width: 100,
                              child: Center(
                                child: Text(
                                  'Campeonato:',
                                  textAlign: TextAlign.start,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                            Expanded(
                              child: DropdownButtonFormField(
                                  value: campeonato,
                                  items: campeonatos
                                      .map((campeonato) => DropdownMenuItem(
                                          value: campeonato.nome,
                                          child: Text(campeonato.nome)))
                                      .toList(),
                                  onChanged: (value) {}),
                            ),
                          ],
                        );
                      }),
                  BlocSelector<AdminController, AdminState, List<TimeModel>>(
                      bloc: widget.controller,
                      selector: ((state) => state.times),
                      builder: (context, times) {
                        return Row(
                          children: [
                            const SizedBox(
                              height: 50,
                              width: 100,
                              child: Center(
                                child: Text(
                                  'Mandante:',
                                  textAlign: TextAlign.start,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                            Expanded(
                              child: DropdownButtonFormField(
                                  value: timeMandante,
                                  items: times
                                      .map((time) => DropdownMenuItem(
                                          value: time.nome,
                                          child: Text(time.nome)))
                                      .toList(),
                                  onChanged: (value) {}),
                            ),
                          ],
                        );
                      }),
                  BlocSelector<AdminController, AdminState, List<TimeModel>>(
                      bloc: widget.controller,
                      selector: ((state) => state.times),
                      builder: (context, times) {
                        return Row(
                          children: [
                            const SizedBox(
                              height: 50,
                              width: 100,
                              child: Center(
                                  child: Text(
                                'Visitante:',
                              )),
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                            Expanded(
                              child: DropdownButtonFormField(
                                  value: timeVisitante,
                                  items: times
                                      .map((time) => DropdownMenuItem(
                                          value: time.nome,
                                          child: Text(time.nome)))
                                      .toList(),
                                  onChanged: (value) {}),
                            ),
                          ],
                        );
                      }),
                  Row(
                    children: [
                      const SizedBox(
                        height: 50,
                        width: 100,
                        child: Center(child: Text('Data:')),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      IconButton(
                          onPressed: () async {
                            var date = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2022),
                              lastDate: DateTime(2040),
                            );
                            if (date != null) {
                              _dataEC.text =
                                  "${date.day}/${date.month}/${date.year}";
                              setState(() {});
                            }
                          },
                          icon: const Icon(Icons.date_range)),
                      const SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        child: TextFormField(
                          readOnly: true,
                          controller: _dataEC,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const SizedBox(
                        height: 50,
                        width: 100,
                        child: Center(child: Text('Hora:')),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      IconButton(
                          onPressed: () async {
                            var hour = await showTimePicker(
                                context: context, initialTime: TimeOfDay.now());
                            if (hour != null) {
                              String hora = hour.hour.toString().length == 2
                                  ? hour.hour.toString()
                                  : "0${hour.hour}";
                              String minuto = hour.minute.toString().length == 2
                                  ? hour.minute.toString()
                                  : "0${hour.minute}";
                              _horaEC.text = "$hora:$minuto";
                              setState(() {});
                            }
                          },
                          icon: const Icon(Icons.watch_later_outlined)),
                      const SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        child: TextFormField(
                          readOnly: true,
                          controller: _horaEC,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const SizedBox(
                        height: 50,
                        width: 100,
                        child: Center(child: Text('Aposta:')),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        child: TextFormField(
                          controller: _valorEC,
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ],
                  ),
                  Image.network(imageUrl),
                  const SizedBox(
                    height: 32,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      final storageRef = FirebaseStorage.instance.ref();
                      final pathReference = await storageRef
                          .child("escudos/palmeiras.png")
                          .getDownloadURL();

                      setState(() {
                        imageUrl = pathReference;
                      });

                      /*  var formValid =
                          _formKey.currentState?.validate() ?? false;
                      if (formValid) {
                        widget.controller.enviarDados(
                            campeonato: campeonato,
                            data: _dataEC.text,
                            hora: _horaEC.text,
                            mandante: timeMandante,
                            visitante: timeVisitante,
                            valorAposta: int.parse(_valorEC.text)); 
                      } */
                    },
                    child: const Text('Enviar'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
