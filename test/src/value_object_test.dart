import 'package:dartz/dartz.dart';
import 'package:dominion/dominion.dart';
import 'package:test/test.dart';

class _FakeValueObject extends ValueObject<String, String> {
  final Either<String, String> value;

  factory _FakeValueObject(String input) {
    if (input.isNotEmpty) {
      return _FakeValueObject._(right(input));
    } else {
      return _FakeValueObject._(left('Value must not be empty'));
    }
  }

  _FakeValueObject._(this.value);
}

void main() {
  group('valid object', () {
    final valueObject = _FakeValueObject('hello');

    test('value is right', () {
      expect(
        valueObject.value,
        equals(Right<String, String>('hello')),
      );
    });

    test('getOrCrash returns value', () {
      expect(valueObject.getOrCrash(), equals('hello'));
    });

    test('getOrElse returns value', () {
      expect(valueObject.getOrElse('dflt'), equals('hello'));
    });

    test('isValid is true', () {
      expect(valueObject.isValid, isTrue);
    });
  });

  group('invalid value', () {
    final valueObject = _FakeValueObject('');

    test('value is left', () {
      expect(
        valueObject.value,
        equals(isA<Left<String, String>>()),
      );
    });

    test('getOrCrash crashes', () {
      expect(
        valueObject.getOrCrash,
        throwsA(equals(UnexpectedValueError('Value must not be empty'))),
      );
    });

    test('getOrElse returns dflt', () {
      expect(valueObject.getOrElse('dflt'), equals('dflt'));
    });

    test('isValid is false', () {
      expect(valueObject.isValid, isFalse);
    });
  });
}
