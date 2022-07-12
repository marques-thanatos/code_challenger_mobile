import 'package:flutter/material.dart';

class FormDados extends StatelessWidget {
  final TextEditingController controlador;
  final String rotulo;
  final String dica;
  //final String valor;
  final IconData icone;

  FormDados({this.controlador, this.rotulo, this.dica, this.icone});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: TextFormField(
        controller: controlador,
        style: TextStyle(fontSize: 24.0),
        decoration: InputDecoration(
          icon: icone != null ? Icon(icone) : null,
          labelText: rotulo,
          hintText: dica,
        ),
        validator: (value) {
          if (value.isEmpty) {
            return 'Este campo não pode ser nulo.';
          }
          return null;
        },
        keyboardType: TextInputType.numberWithOptions(decimal: true),
      ),
    );
  }
}
