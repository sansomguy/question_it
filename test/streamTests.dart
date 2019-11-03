import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:rxdart/rxdart.dart';


List<Stream<int>> _getStreams() {
  var a = Stream.periodic(const Duration(milliseconds: 1), (count) => count)
      .take(3),
      b = Stream.fromIterable(const [1, 2, 3, 4]);

  return [a, b];
}

void main() {

  test('rx.Observable.merge', () async {
    final observable = Observable.merge(_getStreams());
    await expectLater(
        observable, emitsInOrder(const <int>[1, 2, 3, 4, 0, 1, 2]));
  });

  test('Should emit in order', () async {
    var controller = StreamController<int>();
    var subject = BehaviorSubject<int>();
    controller.stream.listen(subject.add);
    controller.sink.add(2);
    await expectLater(subject, emitsInOrder(const <int>[2]));
  });

}