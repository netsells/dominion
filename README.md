# Dominion

Dominion is a small set of utilities for implementing domain-driven design in Dart.

## Usage

### Value objects

In DDD, a value object represents an object that is not uniquely identifiable, but may require validation (e.g. a password).

You can implement value objects with Dominion, by extending the `ValueObject` abstract class:

```dart
class PasswordFailure {
  final String message;

  const PasswordFailure(this.message);
}

class Password extends ValueObject<PasswordFailure, String> {
  final Either<PasswordFailure, String> value;

  factory Password(String input) {
    assert(input != null);
    // Validate the input
    if (input.isEmpty) {
      // Input is empty; return Left
      return Password._(left(PasswordFailure('Password is empty.')));
    } else if (input.length < 8) {
      // Input is too short; return Left
      return Password._(
        left(
          PasswordFailure('Password must be at least 8 characters.'),
        ),
      );
    } else {
      // Input is valid; return Right
      return Password._(right(input));
    }
  }

  const Password._(this.value);
}
```

The `ValueObject` class includes a few helpful methods and getters, including:

- `value`, which returns either the value or the failure, depending on the validation result.
  - This field is an instance of `Either`, which is provided by the [dartz](https://pub.dev/packages/dartz) package (included with Dominion)
- `getOrCrash`, which returns the value or throws `UnexpectedValueException` if it's invalid
- `getOrElse`, which returns the value, or the given default if the value is invalid
- `isValid`, which returns `true` if the value is valid and `false` otherwise

### Entities

An entity represents a business object which should be uniquely identifiable; in other words, entities are objects with IDs.

You can use the `Entity` abstract class to enforce this requirement on a class. Do this by implementing `Entity`.

```dart
// Users are Entities whose IDs are integers
class User implements Entity<int> {
  final int id; // This field is an int because we are implementing Entity<int>
  final String email;

  const User(this.id, this.email);
}
```
