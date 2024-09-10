import 'dart:async';

import 'package:flutter/material.dart';

class ClientesPage extends StatelessWidget {
   final Debouncer debouncer = Debouncer(milliseconds: 300);
   ClientesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
        Text('Buscar Clientes'),
        SizedBox(height: 24,)
,   TextField(
                onChanged: (value) {
                  debouncer.run(() {
                    
                  });
                },
                decoration: const InputDecoration(
                  hintText:
                      'Digite a referencia que deseja imprimir as etiquetas',
                ),
              ),
    ],);
  }

}

class Debouncer {
  final int milliseconds;
  Timer? _timer;

  Debouncer({required this.milliseconds});

  void run(VoidCallback action) {
    _timer?.cancel();
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }

  void dispose() {
    _timer?.cancel();
  }
}
