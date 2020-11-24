import 'package:dartz/dartz.dart';
import 'package:dominion/dominion.dart';

void main() {}

class PasswordFailure {
  final String message;

  const PasswordFailure(this.message);
}

/// An example [ValueObject]
class Password extends ValueObject<PasswordFailure, String> {
  final Either<PasswordFailure, String> value;

  factory Password(String input) {
    assert(input != null);
    if (input.isEmpty) {
      return Password._(left(PasswordFailure('Password is empty.')));
    } else if (input.length < 8) {
      return Password._(
        left(
          PasswordFailure('Password must be at least 8 characters.'),
        ),
      );
    } else {
      return Password._(right(input));
    }
  }

  const Password._(this.value);
}

/// An example [Entity]
class User implements Entity<int> {
  final int id;
  final String email;

  const User(this.id, this.email);
}
