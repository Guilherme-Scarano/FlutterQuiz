import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_simple_quiz_app/constants.dart';
import 'package:flutter_simple_quiz_app/quiz_screen.dart';

class BemVindoScreen extends StatefulWidget {
  @override
  _BemVindoScreenState createState() => _BemVindoScreenState();
}

class _BemVindoScreenState extends State<BemVindoScreen> {
  TextEditingController fullNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("lib/foto2.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Spacer(flex: 2),
                Text(
                  "Bem-Vindo(a) ao Quiz",
                  style: Theme.of(context).textTheme.headline4?.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                Text("Digite seu nome de usuário"),
                Spacer(),
                TextField(
                  controller: fullNameController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: "Usuário",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                  ),
                ),
                Spacer(),
                InkWell(
                  onTap: () {
                    _startQuiz();
                  },
                  child: Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(kDefaultPadding * 0.75),
                    decoration: BoxDecoration(
                      gradient: kPrimaryGradient,
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                    child: Text(
                      "Começar",
                      style: Theme.of(context)
                          .textTheme
                          .button
                          ?.copyWith(color: Colors.black),
                    ),
                  ),
                ),
                Spacer(flex: 2),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _startQuiz() {
    String fullName = fullNameController.text.trim();
    if (fullName.isNotEmpty) {
      Get.to(QuizScreen(name: fullName)); // Passa o nome para a próxima tela
    } else {
      // Exibe uma mensagem de erro se o campo de nome estiver vazio
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text("Insira um nome de usuário"),
          actions: [
            ElevatedButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      );
    }
  }
}
