import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

class ARView extends StatefulWidget {
  final String productName;
  final String modelPath; // Nueva propiedad para la ruta del modelo

  const ARView({
    super.key,
    required this.productName,
    required this.modelPath,
  });

  @override
  _ARViewState createState() => _ARViewState();
}

class _ARViewState extends State<ARView> {
  CameraController? _controller;
  bool _isCameraInitialized = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    try {
      final cameras = await availableCameras();
      final rearCamera = cameras.firstWhere((camera) => camera.lensDirection == CameraLensDirection.back);

      _controller = CameraController(rearCamera, ResolutionPreset.high);
      await _controller!.initialize();

      setState(() {
        _isCameraInitialized = true;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Error al inicializar la cámara: $e';
      });
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Realidad Aumentada: ${widget.productName}'),
      ),
      body: _errorMessage != null
          ? Center(child: Text(_errorMessage!))
          : _isCameraInitialized
              ? Stack(
                  children: [
                    CameraPreview(_controller!),
                    Align(
                      alignment: Alignment.center,
                      child: ModelViewer(
                        src: widget.modelPath, // Usa la ruta del modelo 3D
                        alt: "Modelo 3D de ${widget.productName}",
                        ar: true,
                        autoRotate: true,
                        cameraControls: true,
                      ),
                    ),
                  ],
                )
              : const Center(child: CircularProgressIndicator()),
    );
  }
}
