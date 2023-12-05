class Question {
  final String questionText;
  final List<Answer> answersList;

  Question(this.questionText, this.answersList);
}

class Answer {
  final String answerText;
  final bool isCorrect;

  Answer(this.answerText, this.isCorrect);
}

List<Question> getQuestions() {
  List<Question> list = [];

  // Adicione perguntas e respostas aqui

  // Perguntas existentes
  list.add(Question(
    "Quem é o dono do Flutter?",
    [
      Answer("Nokia", false),
      Answer("Samsung", false),
      Answer("Google", true),
      Answer("Apple", false),
    ],
  ));

  list.add(Question(
    "Quem é o dono do iPhone?",
    [
      Answer("Apple", true),
      Answer("Microsoft", false),
      Answer("Google", false),
      Answer("Nokia", false),
    ],
  ));

  list.add(Question(
    "O Youtube é uma plataforma de _________?",
    [
      Answer("Compartilhamento de Música", false),
      Answer("Compartilhamento de Vídeos", false),
      Answer("Transmissão Ao Vivo", false),
      Answer("Todas as opções acima", true),
    ],
  ));

  list.add(Question(
    "Flutter utiliza Dart como linguagem?",
    [
      Answer("Verdadeiro", true),
      Answer("Falso", false),
    ],
  ));

  // Novas perguntas
  list.add(Question(
    "Qual linguagem de programação é usada para desenvolver aplicativos Android nativos?",
    [
      Answer("Java", true),
      Answer("Swift", false),
      Answer("Kotlin", true),
      Answer("Objective-C", false),
    ],
  ));

  list.add(Question(
    "Qual empresa desenvolveu a linguagem de programação Python?",
    [
      Answer("Microsoft", false),
      Answer("Google", false),
      Answer("Facebook", false),
      Answer("Python Software Foundation", true),
    ],
  ));

  list.add(Question(
    "Qual é o sistema operacional de código aberto baseado no kernel Linux?",
    [
      Answer("Windows", false),
      Answer("macOS", false),
      Answer("Ubuntu", true),
      Answer("iOS", false),
    ],
  ));

  list.add(Question(
    "Quem é conhecido como o 'pai' da computação?",
    [
      Answer("Bill Gates", false),
      Answer("Alan Turing", true),
      Answer("Steve Jobs", false),
      Answer("Mark Zuckerberg", false),
    ],
  ));

  list.add(Question(
    "Qual é a linguagem de marcação usada para criar páginas web?",
    [
      Answer("JavaScript", false),
      Answer("CSS", false),
      Answer("HTML", true),
      Answer("Python", false),
    ],
  ));

  list.add(Question(
    "O que significa a sigla 'HTML'?",
    [
      Answer("HyperText Markup Language", true),
      Answer("High-Level Text Language", false),
      Answer("Home Tool Markup Language", false),
      Answer("Hyperlink and Text Markup Language", false),
    ],
  ));

  return list;
}
