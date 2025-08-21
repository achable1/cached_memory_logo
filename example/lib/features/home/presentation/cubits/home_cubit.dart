import "package:flutter_bloc/flutter_bloc.dart";


import "../../../../core/cubit_states/state_mixin.dart";
import "../../business/entities/home_entity.dart";



class HomeCubit extends Cubit<StateMixin<HomeEntity>> {
  
  HomeCubit() : super(StateMixin<HomeEntity>.loading());

  
}
