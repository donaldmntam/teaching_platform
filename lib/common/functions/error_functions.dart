Never illegalState(
  Object? state,
  String function,
) => throw "Illegal state! State: $state; Function: $function.";

Never badType(
  Object? object,
  Type expectedType,
) => throw "Bad type! Object: $object; Type expected: $expectedType";

void require(
  bool condition,
  [String? reason]
) {
  if (reason == null) {
    throw "Requirement not met!";
  }
  throw "Requirement not met! Reason: $reason";
}