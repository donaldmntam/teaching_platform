extension ExtendedDuration on Duration {
  Duration coerceAtMost(Duration limit) {
    final localThis = this;
    if (localThis > limit) return limit;
    return localThis;
  }

  Duration coerceAtLeast(Duration limit) {
    final localThis = this;
    if (localThis < limit) return limit;
    return localThis;
  }
}