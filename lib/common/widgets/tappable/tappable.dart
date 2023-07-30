import 'dart:math';

import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart' hide State;
import 'package:flutter/widgets.dart' as widgets show State;
import 'package:teaching_platform/common/widgets/services.dart/services.dart';

const _minOpacity = 0.12;
const _maxOpacity = 1.0;
const _durationMillis = 300;
const _opacityRate = (_maxOpacity - _minOpacity) / _durationMillis;

class Tappable extends StatefulWidget {
  final void Function() onTap;
  final Widget child;

  const Tappable({
    super.key,
    required this.onTap,
    required this.child,
  });

  @override
  widgets.State<StatefulWidget> createState() => _WidgetState();
}

class _WidgetState extends widgets.State<Tappable> 
  with SingleTickerProviderStateMixin
{
  late final Ticker ticker;
  _State state = const _Up();
  double opacity = _maxOpacity;

  @override
  void initState() {
    super.initState();
    final ticker = createTicker(onTick);
    this.ticker = ticker;
  }

  @override
  void dispose() {
    ticker.dispose();
    super.dispose();
  }

  void onTick(Duration duration) {
    final now = Services.of(context).clock.now();
    switch (state) {
      case _GoingUp(reference: final reference):
        final currentDurationMillis = now.millisecondsSinceEpoch - 
          reference.millisecondsSinceEpoch;
        final isUp = currentDurationMillis >= _durationMillis;
        if (isUp) {
          setState(() => opacity = _maxOpacity);
          state = const _Up();
          ticker.stop();
        } else {
          setState(() => opacity = calcOpacity(reference, now));
        }
      // case Down():
      //   setState(() => opacity = _minOpacity);
      // case Up():
      //   setState(() => opacity = _maxOpacity);
      default:
        throw "Illegal state when onTick was called: $state";
    }
  }

  void onTapDown() {
    switch (state) {
      case _Up():
      case _GoingUp():
        ticker.stop();
        setState(() => opacity = _minOpacity);
        state = const _Down();
      default:
        break;
    }
  }

  void onTapUp() {
    final now = Services.of(context).clock.now();
    switch (state) {
      case _Down():
        state = _GoingUp(now);
        widget.onTap();
        ticker.start();
      default:
        break;
    }
  }

  void onTapCancel() {
    final now = Services.of(context).clock.now();
    switch (state) {
      case _Down():
        state = _GoingUp(now);
        ticker.start();
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: switch (state) {
        _Down() => _minOpacity,
        _GoingUp() => opacity,
        _Up() => 1.0,
      },
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTapDown: (_) => onTapDown(),
        onTapUp: (_) => onTapUp(),
        onTapCancel: () => onTapCancel(),
        child: widget.child,
      )
    );
  }
}

sealed class _State {
  const _State();
}

class _Down implements _State {
  const _Down();
}

class _GoingUp implements _State {
  final DateTime reference;

  const _GoingUp(this.reference);
}

class _Up implements _State {
  const _Up();
}

double calcOpacity(DateTime reference, DateTime now) {
  return (now.millisecondsSinceEpoch - reference.millisecondsSinceEpoch) * 
    _opacityRate + _minOpacity;
}