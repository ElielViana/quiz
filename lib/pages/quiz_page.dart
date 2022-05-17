import 'package:flutter/material.dart';
import 'package:quiz/model/quiz_model.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../model/pergunta_model.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({Key? key}) : super(key: key);

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int pos = 0;
  int acertos = 0;
  int erros = 0;
  List<Widget> iconsList = [];
  late QuizModel quiz;

  final Widget done = const SizedBox(
    child: Icon(Icons.done, color: Colors.green),
  );

  final Widget close = const SizedBox(
    child: Icon(Icons.close, color: Colors.red),
  );

  //perguntas
  Pergunta pergunta1 = Pergunta(
    textoPergunta: "A copa do mundo do Qatar será realizada no ano de 2022",
    resposta: true,
  );

  Pergunta pergunta2 = Pergunta(
    textoPergunta: "O Brasil foi o ultimo campeão da copa do mundo",
    resposta: false,
  );

  Pergunta pergunta3 = Pergunta(
    textoPergunta: "O Brasil tem 6 titulos de copa do mundo",
    resposta: false,
  );

  Pergunta pergunta4 = Pergunta(
    textoPergunta:
        "A argentina ganhou mais copa do mundo entre todos os países",
    resposta: false,
  );

  Pergunta pergunta5 = Pergunta(
    textoPergunta:
        "Cristiano Ronaldo e Lionel Messi já jogaram juntos em um mesmo time",
    resposta: false,
  );

  Pergunta pergunta6 = Pergunta(
    textoPergunta: "O Brasil nunca ficou fora de uma copa do mundo",
    resposta: true,
  );
  //fim-perguntas

  @override
  void initState() {
    quiz = QuizModel();
    quiz.setPergunta(pergunta: pergunta1);
    quiz.setPergunta(pergunta: pergunta2);
    quiz.setPergunta(pergunta: pergunta3);
    quiz.setPergunta(pergunta: pergunta4);
    quiz.setPergunta(pergunta: pergunta5);
    quiz.setPergunta(pergunta: pergunta6);
    super.initState();
  }

  Pergunta perguntaAtual() {
    //retorna o Objeto Pergunta
    quiz.setIndice(pos);
    int length = quiz.getPergunta().length;
    if (pos < length) {
      return quiz.getPergunta()[quiz.getIndice()];
    } else {
      _onBasicWaitingAlertPressed(context);
      pos = 0;
      acertos = 0;
      erros = 0;
      quiz.setIndice(pos);
      setState(() {
        iconsList = [];
      });
      return quiz.getPergunta()[pos];
    }
  }

  bool verificaResposta(bool value) {
    //verifica se a resposta está correta e adiciona icone a lista de Widgets
    if (value == quiz.getPergunta()[quiz.getIndice()].resposta) {
      iconsList.add(SizedBox(
        child: done,
        width: 25,
      ));
      acertos++;
    } else {
      iconsList.add(SizedBox(
        child: close,
        width: 25,
      ));
      erros++;
    }

    return true;
  }

  _onBasicWaitingAlertPressed(context) async {
    //Retorna o Alert da lib rflutter_alert com a quantidade de erros e acertos
    await Alert(
      context: context,
      title: "Resultado",
      desc: "Acertos: $acertos\nErros: $erros ",
      buttons: [
        DialogButton(
            child: const Text("Reiniciar Quiz"),
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pop();
            })
      ],
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(
          height: 150,
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.30,
          child: Text(
            perguntaAtual().textoPergunta,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white, fontSize: 30),
          ),
        ),
        SizedBox(
            height: 50,
            width: MediaQuery.of(context).size.width,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.green),
                onPressed: () {
                  setState(() {
                    pos++;
                    verificaResposta(true);
                    perguntaAtual();
                  });
                },
                child: const Text(
                  "Verdadeiro",
                  style: TextStyle(
                    fontSize: 25,
                  ),
                ))),
        const SizedBox(
          height: 30,
        ),
        SizedBox(
          height: 50,
          width: MediaQuery.of(context).size.width,
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                pos++;
                verificaResposta(false);
                perguntaAtual();
              });
            },
            child: const Text(
              "Falso",
              style: TextStyle(
                fontSize: 25,
              ),
            ),
            style: ElevatedButton.styleFrom(primary: Colors.red),
          ),
        ),
        Row(
          children: iconsList,
        )
      ],
    );
  }
}
