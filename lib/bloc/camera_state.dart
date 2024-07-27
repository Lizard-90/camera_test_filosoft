part of 'camera_bloc.dart';

abstract class CameraState extends Equatable {
  const CameraState();

  @override
  List<Object> get props => [];
}

class CameraInitial extends CameraState {}

class CameraLoading extends CameraState {}

class CameraLoaded extends CameraState {
  final List<Camera> cameras;

  const CameraLoaded({required this.cameras});

  @override
  List<Object> get props => [cameras];
}

class CameraError extends CameraState {}
