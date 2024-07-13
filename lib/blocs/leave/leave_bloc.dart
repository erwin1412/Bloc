import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:financial/models/leave_model.dart';
import 'package:financial/services/leave_service.dart';

part 'leave_event.dart';
part 'leave_state.dart';

class LeaveBloc extends Bloc<LeaveEvent, LeaveState> {
  LeaveBloc() : super(LeaveInitial()) {
    on<FetchLeave>((event, emit) async {
      emit(LeaveLoading());
      try {
        final leaves = await LeaveService().getLeave();
        emit(LeaveSuccess(leaves));
      } catch (e) {
        emit(LeaveError(e.toString()));
      }
    });

    on<AddLeave>((event, emit) async {
      emit(LeaveLoading());
      try {
        await LeaveService().addLeave(event.leave);
        final leaves = await LeaveService().getLeave();
        emit(LeaveSuccess(leaves));
      } catch (e) {
        emit(LeaveError(e.toString()));
      }
    });

    on<DeleteLeave>((event, emit) async {
      emit(LeaveLoading());
      try {
        await LeaveService().deleteLeave(event.id);
        add(FetchLeave()); // Add this line to trigger data reload
      } catch (e) {
        emit(LeaveError(e.toString()));
      }
    });
  }
}
