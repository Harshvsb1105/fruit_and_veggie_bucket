import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:fruit_and_veggie_bucket/src/core/plant_repository.dart';
import 'package:fruit_and_veggie_bucket/src/model/model.dart';

part 'plants_event.dart';
part 'plants_state.dart';

class PlantsBloc extends Bloc<PlantsEvent, PlantsState> {
  final PlantsRepository repository;

  PlantsBloc({@required this.repository}) : super(PlantsLoading());

  @override
  Stream<PlantsState> mapEventToState(
    PlantsEvent event,
  ) async* {
    if(event is LoadPlants){
      try{
        final plants = await repository.loadPlants();
          yield PlantsLoaded(plants);
      } catch (_) {
        yield PlantsNotLoaded();
      }
    }
  }
}
