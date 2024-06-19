import '../../../../imports.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class WorkplaceNetworkBloc
    extends Bloc<WorkplaceNetworkEvent, WorkplaceNetworkState> {
  Connectivity connectivity = Connectivity();

  WorkplaceNetworkBloc() : super(NetworkInitial()) {
    connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      if (result != ConnectivityResult.none) {
        add(NetworkUpdateEvent());
      } else {
        add(NetworkLostEvent());
      }
    });

    on<NetworkUpdateEvent>((event, state) async {
      emit(NetworkConnected());
    });
    on<NetworkLostEvent>((event, state) async {
      emit(NetworkDisconnected());
    });
  }
}
