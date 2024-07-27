import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/camera_bloc.dart';
import 'models/camera_model.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ФИЛОСОФТ',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        create: (context) => CameraBloc()..add(LoadCameras()),
        child: CameraListScreen(),
      ),
    );
  }
}

class CameraListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ФИЛОСОФТ Cameras'),
        centerTitle: true,
      ),
      body: BlocBuilder<CameraBloc, CameraState>(
        builder: (context, state) {
          if (state is CameraLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is CameraLoaded) {
            return ListView.builder(
              padding: EdgeInsets.symmetric(vertical: 10),
              itemCount: state.cameras.length,
              itemBuilder: (context, index) {
                final camera = state.cameras[index];
                return CameraThumbnail(camera: camera);
              },
            );
          } else if (state is CameraError) {
            return Center(child: Text('Failed to load cameras'));
          } else {
            return Container();
          }
        },
      ),
    );
  }
}

class CameraThumbnail extends StatefulWidget {
  final Camera camera;

  CameraThumbnail({required this.camera, super.key});

  @override
  _CameraThumbnailState createState() => _CameraThumbnailState();
}

class _CameraThumbnailState extends State<CameraThumbnail> {
  late VlcPlayerController _vlcPlayerController;

  @override
  void initState() {
    super.initState();
    _vlcPlayerController = VlcPlayerController.network(
      widget.camera.url,
      hwAcc: HwAcc.full,
    );
  }

  @override
  void dispose() {
    _vlcPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(
        'Camera ${widget.camera.id}',
        style: TextStyle(fontSize: 20),
      ),
      title: Container(
        padding: EdgeInsets.all(10),
        height: 230,
        child: VlcPlayer(
          controller: _vlcPlayerController,
          aspectRatio: 1.1,
          placeholder: Center(child: CircularProgressIndicator()),
        ),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CameraViewerScreen(camera: widget.camera),
          ),
        );
      },
    );
  }
}

class CameraViewerScreen extends StatefulWidget {
  final Camera camera;

  CameraViewerScreen({required this.camera});

  @override
  _CameraViewerScreenState createState() => _CameraViewerScreenState();
}

class _CameraViewerScreenState extends State<CameraViewerScreen> {
  late VlcPlayerController _vlcPlayerController;

  @override
  void initState() {
    super.initState();
    _vlcPlayerController = VlcPlayerController.network(
      widget.camera.url,
      hwAcc: HwAcc.full,
    );
  }

  @override
  void dispose() {
    _vlcPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Camera ${widget.camera.id}')),
      body: VlcPlayer(
        controller: _vlcPlayerController,
        aspectRatio: 16 / 9,
        placeholder: Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
