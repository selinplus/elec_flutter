package com.bigear.remote_hospital_doctor;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;

import io.flutter.app.FlutterActivity;

import io.flutter.plugin.common.MethodChannel;

public class MessageBroadcastReceiver extends BroadcastReceiver {
    MethodChannel methodChannel;
    MessageBroadcastReceiver(MethodChannel methodChannel){
        this.methodChannel=methodChannel;
    }

    @Override
    public void onReceive(final Context context, Intent intent) {
        methodChannel.invokeMethod("_showNotification","");
    }
}
