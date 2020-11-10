package com.example.tasker;

import android.os.Build;

public class Config {
    //Phần này cần thống nhất với config phía flutter
    public static String method_channel_name = "tasker_channel";
    public static String method_test = "method_test";
    public static String method_mute = "method_mute";
    public static String method_unmute = "method_unmute";

    static String method_call_sv_on = "method_call_sv_on";
    static String method_call_sv_off = "method_call_sv_off";
    static String method_call_rod_on = "method_call_rod_on";
    static String method_call_rod_off = "method_call_rod_off";
    static String method_call_rob_on = "method_call_rob_on";
    static String method_call_rob_off = "method_call_rob_off";

    //Phần này config phía broadcastReceiver
    static String msg_broadcast_on_sv_destroy = "tasker.ON_SERVICE_DESTROY";
    static String msg_broadcast_set_rod_on = "tasker.SET_ROD_ON";
    static String msg_broadcast_set_rod_off = "tasker.SET_ROD_OFF";
    static String msg_broadcast_set_rob_on = "tasker.SET_ROB_ON";
    static String msg_broadcast_set_rob_off = "tasker.SET_ROB_OFF";

    //Phần này config notification
    static String notification_channel_id = "tasker_channel_id";
    static String notification_channel_name = "tasker_channel_name";
    static int notification_id = 999;

    //Phần này config timer
    static int timer_delay = 5000;
    static int timer_interval = 600000;

    //Kiểm tra version > O
    static boolean buildVersionO(){
        return Build.VERSION.SDK_INT >= Build.VERSION_CODES.O;
    }
}
