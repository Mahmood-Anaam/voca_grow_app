part of 'child_bloc.dart';

sealed class ChildState extends Equatable {
  const ChildState();

  @override
  List<Object> get props => [];
}

final class ChildInitial extends ChildState {}

final class ChildLoading extends ChildState {}

final class ChildLoaded extends ChildState {
  final List<ChildModel> children;

  const ChildLoaded(this.children);

  @override
  List<Object> get props => [children];
}

final class Susscess extends ChildState {}


final class ChildError extends ChildState {
  final String message;

  const ChildError(this.message);

  @override
  List<Object> get props => [message];
}
