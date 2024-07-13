part of 'leave_bloc.dart';

sealed class LeaveEvent extends Equatable {
  const LeaveEvent();

  @override
  List<Object> get props => [];
}

class FetchLeave extends LeaveEvent {}

class AddLeave extends LeaveEvent {
  final LeaveModel leave;
  const AddLeave(this.leave);

  @override
  List<Object> get props => [leave];
}

class DeleteLeave extends LeaveEvent {
  final int id;
  const DeleteLeave(this.id);

  @override
  List<Object> get props => [id];
}
