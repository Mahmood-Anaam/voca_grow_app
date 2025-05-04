import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../data/data.dart';

part 'child_event.dart';
part 'child_state.dart';

class ChildBloc extends Bloc<ChildEvent, ChildState> {
  final ChildRepository childRepository;

  ChildBloc({required this.childRepository}) : super(ChildInitial()) {
    on<LoadChildren>(_onLoadChildren);
    on<AddChild>(_onAddChild);
    on<UpdateChild>(_onUpdateChild);
    on<DeleteChild>(_onDeleteChild);
  }

  Future<void> _onLoadChildren(
    LoadChildren event,
    Emitter<ChildState> emit,
  ) async {
    emit(ChildLoading());
    try {
      final children = await childRepository.fetchChildren();
      emit(ChildLoaded(children));
    } catch (e) {
      emit(ChildError('Failed to load children: $e'));
    }
  }

  Future<void> _onAddChild(AddChild event, Emitter<ChildState> emit) async {
    try {
      emit(ChildLoading());
      await childRepository.addChild(event.child);
      emit(Susscess());
      add(LoadChildren());
    } catch (e) {
      emit(ChildError('Failed to add child: $e'));
    }
  }

  Future<void> _onUpdateChild(
    UpdateChild event,
    Emitter<ChildState> emit,
  ) async {
    try {
      emit(ChildLoading());
      await childRepository.updateChild(event.child);
      emit(Susscess());
      add(LoadChildren());
    } catch (e) {
      emit(ChildError('Failed to update child: $e'));
    }
  }

  Future<void> _onDeleteChild(
    DeleteChild event,
    Emitter<ChildState> emit,
  ) async {
    try {
      emit(ChildLoading());
      await childRepository.deleteChild(event.childId);
      emit(Susscess());
      add(LoadChildren());
    } catch (e) {
      emit(ChildError('Failed to delete child: $e'));
    }
  }
}
