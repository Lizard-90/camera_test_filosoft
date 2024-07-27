part of 'camera_bloc.dart';

abstract class CameraEvent extends Equatable {
  const CameraEvent();
}

class LoadCameras extends CameraEvent {
  @override
  List<Object> get props => [];
}
