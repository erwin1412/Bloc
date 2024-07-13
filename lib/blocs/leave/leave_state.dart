part of 'leave_bloc.dart';

sealed class LeaveState extends Equatable {
  const LeaveState();

  @override
  List<Object> get props => [];
}

final class LeaveInitial extends LeaveState {}

final class LeaveLoading extends LeaveState {}

final class LeaveError extends LeaveState {
  final String e;
  const LeaveError(this.e);
  @override
  List<Object> get props => [e];
}

final class LeaveSuccess extends LeaveState {
  final List<LeaveModel> leaves;
  const LeaveSuccess(this.leaves);

  @override
  List<Object> get props => [leaves];
}
