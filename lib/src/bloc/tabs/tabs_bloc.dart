import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fruit_and_veggie_bucket/src/bloc/plants/plants_bloc.dart';
import 'package:fruit_and_veggie_bucket/src/model/model.dart';
import 'package:meta/meta.dart';

part 'tabs_event.dart';
part 'tabs_state.dart';

class TabsBloc extends Bloc<TabsEvent, TabsState> {
  final PlantsBloc plantsBloc;
  StreamSubscription plantsSubscription;

  TabsBloc({@required this.plantsBloc})
      : super(plantsBloc.state is PlantsLoaded
      ? TabsLoaded(
    (plantsBloc.state as PlantsLoaded).plants,
    Category.all,
  )
      : TabsLoading()) {
    plantsSubscription = plantsBloc.listen((state) {
      if (state is PlantsLoaded) {
        add(UpdatePlants((plantsBloc.state as PlantsLoaded).plants));
      }
    });
  }

  @override
  Stream<TabsState> mapEventToState(
      TabsEvent event,
      ) async* {
    if (event is UpdateTabs)
      yield* _mapCategoryToState(event);
    else if (event is UpdatePlants) {
      yield* _mapUpdatePlantsToState(event);
    }
  }

  Stream<TabsState> _mapCategoryToState(UpdateTabs event) async* {
    if (plantsBloc.state is PlantsLoaded) {
      final plants = (plantsBloc.state as PlantsLoaded).plants;
      final category = event.category;

      yield TabsLoaded(
        _mapPlantsToCategory(plants, category),
        category,
      );
    }
  }

  Stream<TabsState> _mapUpdatePlantsToState(UpdatePlants event) async* {
    final category =
    state is TabsLoaded ? (state as TabsLoaded).category : Category.all;
    final plants = (plantsBloc.state as PlantsLoaded).plants;

    yield TabsLoaded(
      _mapPlantsToCategory(plants, category),
      category,
    );
  }

  List<Plant> _mapPlantsToCategory(List<Plant> plants, Category category) {
    if (category == Category.all) {
      return plants.toList();
    } else {
      return plants.where((plant) => plant.category == category).toList();
    }
  }

  @override
  Future<void> close() {
    plantsSubscription.cancel();
    return super.close();
  }
}
