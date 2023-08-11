import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:teaching_platform/common/models/course/question.dart';

typedef Task = ({
  Duration timeAllowed,
  IList<Question> questions,
});
