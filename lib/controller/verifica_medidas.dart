import 'package:flutter/material.dart';

final codErroLarguraNula =
    0.0; //"A largura da parede nao pode ficar em branco."

double validarDimensao(String largura, String altura) {
  final numericRegex = RegExp(r'^-?(([0-9]*)|(([0-9]*)\.([0-9]*)))$');

  if (numericRegex.hasMatch(largura) && numericRegex.hasMatch(altura)) {
    var medidas = double.tryParse(altura) *
        double.tryParse(largura); //calculo de metro quadrado

    if (medidas == null) {
      return codErroLarguraNula;
    }

    if (medidas < 1) {
      if (double.tryParse(altura) < double.tryParse(largura)) {
        return 0.1;
      } else {
        return 0.2;
      }
    }

    if (medidas > 15) {
      if (double.tryParse(largura) > double.tryParse(altura)) {
        return 0.2;
      } else {
        return 0.1;
      }
    }

    debugPrint('$medidas');

    return medidas;
  }

  return 0.4;
}

String quantItensParede(
    dimensaoParede, portas, janelas, alturaParede, numWall) {
  if (portas == null) {
    portas = 0;
  }
  if (janelas == null) {
    janelas = 0;
  }
  portas *= 1.52;
  janelas *= 2.40;
  var alturaMinimaParede = alturaParede - 1.90; //portas tem 1.90cm de altura

  var areaTotalItens = janelas + portas;
  var percentItensParede = (areaTotalItens / dimensaoParede) * 100;

  //As portas e janelas devem ocupar no máximo 50% da área de parede
  //E a altura da parede deve ser 30 centímetros maior que a altura da porta
  if (percentItensParede > 50.0) {
    //alert(`Erro.Item ${numWall} não pode ser 50% > que área da parede.`);
    return "Limite ultrapassado";
  }
  if (alturaMinimaParede < 0.30) {
    //alert(`Altura da parede número ${numWall} deve ser 30cm maior que a altura da porta.`);
    return "Altura inferior";
  }

  return "Valores estao dentro dos limites";
}

int erroAreaParede() {
  return 15;
  //"A parede dever ter no mínimo 1m² e no máximo 15m².";
}

double erroLargura() {
  //"Erro na largura de uma ou mais parede(s).";
  return 0.2; //"Largura esta fora dos limites";
}

double erroAltura() {
  //"Erro na altura de uma ou mais parede(s).";
  return 0.1; //"Altura esta fora dos limites";
}

double erroDadoInvalido() {
  // "Erro na altura de uma ou mais parede(s).";
  return 0.4; //"Altura esta fora dos limites";
}
