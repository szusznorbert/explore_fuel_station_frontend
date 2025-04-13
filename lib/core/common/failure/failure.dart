import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String _message;

  const Failure(this._message);
  get message => _message;

  @override
  List<Object?> get props => [_message];
}
