import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_simple_quiz_app/question_model.dart';

class QuizScreen extends StatefulWidget {
  final String name; // Adiciona uma propriedade para armazenar o nome

  QuizScreen({required this.name}); // Construtor para receber o nome

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  late Timer _timer;
  int _secondsRemaining = 12;
  List<Question> questionList = getQuestions();
  int currentQuestionIndex = 0;
  int score = 0;
  Answer? selectedAnswer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  // Função para iniciar o temporizador
  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_secondsRemaining > 0) {
          _secondsRemaining--;
        } else {
          // Quando o temporizador atingir 0, vá para a próxima pergunta
          _nextQuestion();
        }
      });
    });
  }

  // Função para avançar para a próxima pergunta
  void _nextQuestion() {
    _timer.cancel(); // Cancela o temporizador atual

    if (currentQuestionIndex < questionList.length - 1) {
      setState(() {
        currentQuestionIndex++;
        _secondsRemaining =
            12; // Reinicia o temporizador para a próxima pergunta
      });

      // Inicia um novo temporizador após um pequeno atraso
      Future.delayed(Duration(seconds: 1), () {
        _startTimer();
      });
    } else {
      // Mostrar pontuação final ou realizar a ação desejada ao terminar as perguntas
      _timer
          .cancel(); // Certifica-se de cancelar o temporizador ao finalizar as perguntas
      showDialog(context: context, builder: (_) => _showScoreDialog());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 5, 50, 80),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Text(
              "Quiz SI",
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
            _questionWidget(),
            _answerList(),
            _nextButton(),
          ],
        ),
      ),
    );
  }

  // Widget para exibir a pergunta
  Widget _questionWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Questão ${currentQuestionIndex + 1}/${questionList.length.toString()}",
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 20),
        Container(
          alignment: Alignment.center,
          width: double.infinity,
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            color: Colors.orangeAccent,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              Text(
                questionList[currentQuestionIndex].questionText,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 20),
              _secondsRemaining > 0
                  ? Text(
                      "Tempo restante: $_secondsRemaining segundos",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  : Text(
                      "Tempo acabou!",
                      style: const TextStyle(
                        color: Colors.red,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
            ],
          ),
        ),
      ],
    );
  }

  // Widget para exibir as opções de resposta
  Widget _answerList() {
    return Column(
      children: questionList[currentQuestionIndex]
          .answersList
          .map(
            (e) => _answerButton(e),
          )
          .toList(),
    );
  }

  // Widget para criar um botão de resposta
  Widget _answerButton(Answer answer) {
    bool isSelected = answer == selectedAnswer;

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 8),
      height: 48,
      child: ElevatedButton(
        child: Text(answer.answerText),
        style: ElevatedButton.styleFrom(
          shape: const StadiumBorder(),
          primary: isSelected ? Colors.orangeAccent : Colors.white,
          onPrimary: isSelected ? Colors.white : Colors.black,
        ),
        onPressed: () {
          setState(() {
            // Inverte a seleção atual
            selectedAnswer = isSelected ? null : answer;

            if (selectedAnswer != null && selectedAnswer!.isCorrect) {
              // Incrementa a pontuação se a resposta selecionada for correta
              score++;
            }
          });
        },
      ),
    );
  }

  // Widget para criar um botão de próxima pergunta ou finalizar o quiz
  Widget _nextButton() {
    bool isLastQuestion = currentQuestionIndex == questionList.length - 1;

    return Container(
      width: MediaQuery.of(context).size.width * 0.5,
      height: 48,
      child: ElevatedButton(
        child: Text(isLastQuestion ? "Confirmar" : "Próxima"),
        style: ElevatedButton.styleFrom(
          shape: const StadiumBorder(),
          primary: Colors.blueAccent,
          onPrimary: Colors.white,
        ),
        onPressed: () {
          if (isLastQuestion) {
            // Exibir pontuação final
            showDialog(context: context, builder: (_) => _showScoreDialog());
          } else {
            // Avançar para a próxima pergunta
            setState(() {
              selectedAnswer = null;
              currentQuestionIndex++;
              _secondsRemaining =
                  12; // Reinicia o temporizador para a próxima pergunta
              _timer.cancel(); // Cancela o temporizador atual
              _startTimer(); // Inicia um novo temporizador
            });
          }
        },
      ),
    );
  }

  // Widget para exibir a caixa de diálogo com a pontuação final
  Widget _showScoreDialog() {
    bool isPassed = score >= questionList.length * 0.6;
    String title = isPassed ? "Parabéns!! " : "Não foi dessa vez :(";

    return AlertDialog(
      title: Text(
        title + " | Pontuação é $score",
        style: TextStyle(color: isPassed ? Colors.green : Colors.redAccent),
      ),
      content: Text(
          "Nome: ${widget.name}\nPontos: $score"), // Mostra o nome junto com a pontuação
      actions: [
        ElevatedButton(
          child: const Text("Recomeçar"),
          onPressed: () {
            Navigator.pop(context);
            setState(() {
              currentQuestionIndex = 0;
              score = 0;
              selectedAnswer = null;
              _secondsRemaining = 12; // Reinicia o temporizador
              _timer.cancel(); // Cancela o temporizador atual
              _startTimer(); // Inicia um novo temporizador
            });
          },
        ),
      ],
    );
  }
}
