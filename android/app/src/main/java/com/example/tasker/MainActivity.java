package com.example.tasker;

import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.media.AudioManager;
import android.os.Bundle;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import java.util.Objects;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class MainActivity extends FlutterActivity {
    private MyBroacastReceiver broadcastReceiver = null;
    private Intent svIntent;
    private IntentFilter msgIntentRodOn, msgIntentRodOff, msgIntentRobOn, msgIntentRobOff, msgIntentOsd;
    static MethodChannel platform;

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        initSvIntent();
        initBroadcastIntent();
        registerMethodChannel();
    }

    @Override
    protected void onPause() {
        super.onPause();
        unRegisterBroadcastListener();
    }

    @Override
    protected void onResume() {
        super.onResume();
        registerBroadcastListener();
    }

    void initSvIntent() {
        svIntent = new Intent(MainActivity.this, MyService.class);
    }

    void initBroadcastIntent() {
        if (broadcastReceiver == null) {
            broadcastReceiver = new MyBroacastReceiver();
            msgIntentOsd = new IntentFilter(Config.msg_broadcast_on_sv_destroy);
            msgIntentRodOn = new IntentFilter(Config.msg_broadcast_set_rod_on);
            msgIntentRodOff = new IntentFilter(Config.msg_broadcast_set_rod_off);
            msgIntentRobOn = new IntentFilter(Config.msg_broadcast_set_rob_on);
            msgIntentRobOff = new IntentFilter(Config.msg_broadcast_set_rob_off);
        }
    }

    void registerBroadcastListener() {
        registerReceiver(broadcastReceiver, msgIntentOsd);
        registerReceiver(broadcastReceiver, msgIntentRodOn);
        registerReceiver(broadcastReceiver, msgIntentRodOff);
        registerReceiver(broadcastReceiver, msgIntentRobOn);
        registerReceiver(broadcastReceiver, msgIntentRobOff);
    }

    void unRegisterBroadcastListener() {
        unregisterReceiver(broadcastReceiver);
    }

    void registerMethodChannel() {
        platform = new MethodChannel(Objects.requireNonNull(getFlutterEngine()).getDartExecutor().getBinaryMessenger(), Config.method_channel_name);
        platform.setMethodCallHandler(this::flutterMsgHandler);
    }

    static void callFLT() {
        platform.invokeMethod("locale", "");
    }

    void flutterMsgHandler(@NonNull MethodCall call, MethodChannel.Result result) {
        if (call.method.equals(Config.method_mute)) {
            AudioManager am = (AudioManager) getContext().getSystemService(Context.AUDIO_SERVICE);
            am.setStreamVolume(AudioManager.STREAM_SYSTEM, 0, AudioManager.FLAG_REMOVE_SOUND_AND_VIBRATE);
            am.setStreamVolume(AudioManager.STREAM_RING, 0, AudioManager.FLAG_REMOVE_SOUND_AND_VIBRATE);
            am.setStreamVolume(AudioManager.STREAM_MUSIC, 0, AudioManager.FLAG_REMOVE_SOUND_AND_VIBRATE);
            am.setStreamVolume(AudioManager.STREAM_ALARM, 0, AudioManager.FLAG_REMOVE_SOUND_AND_VIBRATE);
            am.setStreamVolume(AudioManager.STREAM_NOTIFICATION, 0, AudioManager.FLAG_REMOVE_SOUND_AND_VIBRATE);
            result.success("MUTE");
        }
        if (call.method.equals(Config.method_unmute)) {
            AudioManager am = (AudioManager) getContext().getSystemService(Context.AUDIO_SERVICE);
            am.setStreamVolume(AudioManager.STREAM_SYSTEM, 100, AudioManager.FLAG_REMOVE_SOUND_AND_VIBRATE);
            am.setStreamVolume(AudioManager.STREAM_RING, 100, AudioManager.FLAG_REMOVE_SOUND_AND_VIBRATE);
            am.setStreamVolume(AudioManager.STREAM_MUSIC, 100, AudioManager.FLAG_REMOVE_SOUND_AND_VIBRATE);
            am.setStreamVolume(AudioManager.STREAM_ALARM, 100, AudioManager.FLAG_REMOVE_SOUND_AND_VIBRATE);
            am.setStreamVolume(AudioManager.STREAM_NOTIFICATION, 100, AudioManager.FLAG_REMOVE_SOUND_AND_VIBRATE);
            result.success("UNMUTE");
        }

        if (call.method.equals(Config.method_call_sv_on)) {
            startSV();
            result.success("Service running, checkout notification!");
        }
        if (call.method.equals(Config.method_call_sv_off)) {
            stopSV();
            result.success("Service stopped!");
        }
        if (call.method.equals(Config.method_call_rod_on)) {
            setRod(true);
            result.success(true);
        }
        if (call.method.equals(Config.method_call_rod_off)) {
            setRod(false);
            result.success(true);
        }
        if (call.method.equals(Config.method_call_rob_on)) {
            setRob(true);
            result.success(true);
        }
        if (call.method.equals(Config.method_call_rob_off)) {
            setRob(false);
            result.success(true);
        }
    }

    //Khởi tạo sv
    void startSV() {
        Intent svIntent = new Intent(this, MyService.class);
        if (Config.buildVersionO())
            startForegroundService(svIntent);
        else
            startService(svIntent);
    }

    //Đóng sv
    void stopSV() {
        stopService(svIntent);
    }

    //Đặt giá trị RestartOnDestroy
    void setRod(boolean enable) {
        Intent setRodIntent = new Intent(enable ? Config.msg_broadcast_set_rod_on : Config.msg_broadcast_set_rod_off);
        sendBroadcast(setRodIntent);
    }

    //Đặt giá trị RestartOnReboot
    void setRob(boolean enable) {
        Intent setRodIntent = new Intent(enable ? Config.msg_broadcast_set_rob_on : Config.msg_broadcast_set_rob_off);
        sendBroadcast(setRodIntent);
    }
}
