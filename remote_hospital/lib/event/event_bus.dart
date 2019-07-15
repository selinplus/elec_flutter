import 'package:event_bus/event_bus.dart';

//Bus初始化
EventBus eventBus = EventBus();

class PresHadDoctorEvent {
  bool isHad=false;
  PresHadDoctorEvent(bool val){
      this.isHad = val;
  }
}