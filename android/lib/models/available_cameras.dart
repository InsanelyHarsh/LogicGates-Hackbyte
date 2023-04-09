import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';

class AvailableCameras with ChangeNotifier{
  
  List<CameraDescription>? cameras;
  setAvailableCameras(List<CameraDescription>? c){
    cameras=c;
    notifyListeners();
  }
  getAvailableCameras(){
    return cameras;
  }
}