import 'package:equatable/equatable.dart';

abstract class AccessCodeState extends Equatable {
  const AccessCodeState();

  @override
  List<Object> get props => [];
}

class AccessCodeInitial extends AccessCodeState {}

class AccessCodeLoading extends AccessCodeState {}

class AccessCodeSuccess extends AccessCodeState {}

class AccessCodeError extends AccessCodeState {
  final String message;

  const AccessCodeError(this.message);

  @override
  List<Object> get props => [message];
}
