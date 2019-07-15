package com.bigear.remote_hospital;

import android.os.Bundle;

import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {
  private static final String CHANNEL = "com.daerdo.remote_hospital";
  static final String eventBackDesktop = "backDesktop";
  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    GeneratedPluginRegistrant.registerWith(this);
    initBackTop();
  }
  private void initBackTop() {
    new MethodChannel(getFlutterView(), CHANNEL).setMethodCallHandler(
            (methodCall, result) -> {
              if (methodCall.method.equals(eventBackDesktop)) {
                moveTaskToBack(false);
                result.success(true);
              }
            }
    );
  }
}
