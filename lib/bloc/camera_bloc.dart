import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../models/camera_model.dart';

part 'camera_event.dart';
part 'camera_state.dart';

class CameraBloc extends Bloc<CameraEvent, CameraState> {
  CameraBloc() : super(CameraInitial()) {
    on<LoadCameras>(_onLoadCameras);
  }

  void _onLoadCameras(LoadCameras event, Emitter<CameraState> emit) async {
    emit(CameraLoading());
    try {
      final cameras = [
        Camera(
          id: '1',
          url: 'rtsp://178.141.80.235:55554/Esd93HFV_s/',
        ),
        Camera(
          id: '2',
          url: 'rtsp://178.141.80.235:55555/md5IffuT_s/',
        ),
      ];
      emit(CameraLoaded(cameras: cameras));
    } catch (_) {
      emit(CameraError());
    }
  }
}
