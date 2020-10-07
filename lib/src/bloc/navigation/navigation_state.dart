import 'package:fruit_and_veggie_bucket/screens/screens.dart';
import 'package:equatable/equatable.dart';

class NavigationState extends Equatable {
  final Screen screen;
  final List propss;

  NavigationState(this.screen, [this.propss]);

  @override
  List<Object> get props => (propss ?? [screen]);
}
