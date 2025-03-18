import 'package:bloc/bloc.dart';

abstract class BaseBloc<Event, State> extends Bloc<Event, State>{
  BaseBloc(State initialState) : super(initialState){
    on<Event>((event, emit) async{
      try{
        await handleEvent(event, emit);
      }catch(error, stackTrace){
        handleError(error, stackTrace); 
        rethrow;
      }
    });
  }
  // Bloc con
  Future<void> handleEvent(Event event, Emitter<State> emit);
  void handleError(Object error, StackTrace stackTrace){
    print('--------------Error log-------------');
    print('Time: ${DateTime.now()}');
    print('Error: $error');
    print('Stack Trace: $stackTrace');
    print('--------------End log-------------');
    // _saveErrorLog(error, stackTrace);
  }
}