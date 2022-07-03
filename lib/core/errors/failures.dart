import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  const Failure({required this.msg});
  final String msg;

  @override
  List<Object?> get props => [msg];
}

class ServerFailure extends Failure {
  const ServerFailure({required String msg}) : super(msg: msg);
}

class NetworkFailure extends Failure {
  const NetworkFailure({required String msg}) : super(msg: msg);
}
