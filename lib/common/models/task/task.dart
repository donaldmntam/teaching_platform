import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:teaching_platform/common/models/task/question.dart';

typedef Task = ({
  String title,
  Duration timeAllowed,
  IList<Question> questions,
});
