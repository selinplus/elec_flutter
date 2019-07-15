package com.bigear.remote_hospital_doctor;

import android.content.ContentResolver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.os.Bundle;
import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {
  private static final String CHANNEL = "com.daerdo.premed";
  static final String eventBackDesktop = "backDesktop";
  private static String resourceToUriString(Context context, int resId) {
    return
            ContentResolver.SCHEME_ANDROID_RESOURCE
                    + "://"
                    + context.getResources().getResourcePackageName(resId)
                    + "/"
                    + context.getResources().getResourceTypeName(resId)
                    + "/"
                    + context.getResources().getResourceEntryName(resId);
  }

  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    GeneratedPluginRegistrant.registerWith(this);
    initBackTop();
    new MethodChannel(getFlutterView(), "crossingthestreams.io/resourceResolver").setMethodCallHandler(
            (call, result) -> {
              if ("drawableToUri".equals(call.method)) {
                int resourceId = MainActivity.this.getResources().getIdentifier((String) call.arguments, "drawable", MainActivity.this.getPackageName());
                String uriString = resourceToUriString(MainActivity.this.getApplicationContext(), resourceId);
                result.success(uriString);
              }
            });

    MethodChannel methodChannel = new MethodChannel(getFlutterView(), CHANNEL);
    MessageBroadcastReceiver receiver = new MessageBroadcastReceiver(methodChannel);
    IntentFilter mTime = new IntentFilter(Intent.ACTION_TIME_TICK);
    registerReceiver(receiver, mTime);
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
