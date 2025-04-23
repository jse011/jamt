import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:jamt/feature/guide/models/card_guide.dart';
import 'package:meta/meta.dart';

part 'guide_event.dart';
part 'guide_state.dart';

class GuideBloc extends Bloc<GuideEvent, GuideState> {
  GuideBloc() : super(GuideState()) {
    on<GuideSelected>(_onGideSelected);
  }

  void _onGideSelected(GuideSelected event,  Emitter<GuideState> emit) {
    if(event.cardGuide !=  state.selectCardGuide){
      emit(state.copyWith(
          selectCardGuides: event.cardGuide
      ));
    }else{
      emit(state.copyWith(
          selectCardGuides: CardGuide()
      ));
    }

  }
}
