class BadType {
  final Object? object;
  final Type expectedType;

  const BadType(this.object, this.expectedType);

  @override
  String toString() { 
    return "Bad type! Object: $object; Type expected: $expectedType";
  }
}

class QuestionInputTypeMismatch {
  final Object? question;
  final Object? input;

  const QuestionInputTypeMismatch(this.question, this.input);

  @override
  String toString() {
    return "A mismatch between the question type and input type! "
      "The question type was ${question.runtimeType} "
      "while the input type was ${input.runtimeType}";
  }
}
