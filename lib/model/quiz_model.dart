// ignore_for_file: unused_field

import 'package:quiz/model/pergunta_model.dart';

class QuizModel {
  final List<Pergunta> _perguntas = [];

  late int _indice;

  int getIndice() {
    return _indice;
  }

  setIndice(indice) {
    _indice = indice;
  }

  set indice(value) => _indice = value;

  setPergunta({required Pergunta pergunta}) {
    _perguntas.add(pergunta);
  }

  List<Pergunta> getPergunta() {
    return _perguntas;
  }
}
