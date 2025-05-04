part of 'child_bloc.dart';

sealed class ChildEvent extends Equatable {
  const ChildEvent();

  @override
  List<Object> get props => [];
}

final class LoadChildren extends ChildEvent {}

final class AddChild extends ChildEvent {
  final ChildModel child;

  const AddChild({required this.child});

  @override
  List<Object> get props => [child];
}

final class UpdateChild extends ChildEvent {
  final ChildModel child;

  const UpdateChild({required this.child});

  @override
  List<Object> get props => [child];
}

final class DeleteChild extends ChildEvent {
  final String childId;

  const DeleteChild({required this.childId});

  @override
  List<Object> get props => [childId];
}
