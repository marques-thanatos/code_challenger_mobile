import 'package:flutter/material.dart';

String resultado = "Para pintar a sala é preciso ";

String calculaQuantLatas(metragemDaSala) {
  var lata1 = 2.5, lata2 = 12.5, lata3 = 18; //metros q cada lata pinta
  var counter1 = 0, counter2 = 0, counter3 = 0;

  if (metragemDaSala >= lata3) {
    do {
      counter3++;
      metragemDaSala -= lata3;
    } while (metragemDaSala > lata3);

    debugPrint('$counter3');
    resultado = resultado + "$counter3 lata(s) de 3,6L ";
  }

  if (metragemDaSala >= 10.1 && metragemDaSala < lata3) {
    do {
      counter2++;
      metragemDaSala -= lata2;
    } while (metragemDaSala > lata2);

    debugPrint('$counter2');

    if (counter3 > 0) {
      resultado = resultado + "e $counter2 lata(s) de 2,5L";
    } else {
      resultado = resultado + "$counter2 lata(s) de 2,5L";
    }
  }

  if (metragemDaSala >= 1 && metragemDaSala <= 10) {
    do {
      counter1++;
      metragemDaSala -= lata1;
    } while (metragemDaSala > lata1);

    if (metragemDaSala > 0) {
      counter1++;
    }

    if (counter3 > 0 || counter2 > 0) {
      resultado = resultado + "e $counter1 lata(s) de 0,5L.";
    } else {
      resultado = resultado + "$counter1 lata(s) de 0,5L.";
    }

    debugPrint('$counter1');
  }

  //Como a medida máxima somando a área das 4 paredes é  de 60m², não precisamos usar a lata de 18 litros ou latas maiores.
  return resultado;
}
//}
