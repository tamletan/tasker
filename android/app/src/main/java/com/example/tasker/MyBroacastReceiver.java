//package com.example.tasker;
//
//import android.content.BroadcastReceiver;
//import android.content.Context;
//import android.content.Intent;
//
//public class MyBroacastReceiver extends BroadcastReceiver {
//    private boolean rob = false;
//    private boolean rod = false;
//
//    @Override
//    public void onReceive(Context context, Intent intent) {
//        if(intent.getAction() == null) return;
//        //Khi device khởi động lại, receiver này sẽ nhận dc 1 message từ hệ thống android là ACTION_BOOT_COMPLETED, mình sẽ kiểm tra xem rob(restartOnReboot) có bật hay không, nếu có thì mình sẽ khởi động sv một lần nữa.
//        if(intent.getAction().equals(Intent.ACTION_BOOT_COMPLETED)){
//            if(rob) startSV(context);
//        }
//        //Kể từ đây là các custom message, chúng cần được đăng ký với broadcastReceiver để có thể hoạt động.
//        if(intent.getAction().equals(Config.msg_broacast_on_sv_destroy)){
//            if(rod) startSV(context);
//        }
//
//        if(intent.getAction().equals(Config.msg_broacast_set_rod_on)){
//            rod = true;
//        }
//
//        if(intent.getAction().equals(Config.msg_broacast_set_rod_off)){
//            rod = false;
//        }
//
//        if(intent.getAction().equals(Config.msg_broacast_set_rob_on)){
//            rob = true;
//        }
//
//        if(intent.getAction().equals(Config.msg_broacast_set_rob_off)){
//            rob = false;
//        }
//    }
//
//    void startSV(Context context){
//        Intent svIntent = new Intent(context, MyService.class);
//        if(Config.buildVersionO())
//            context.startForegroundService(svIntent);
//        else
//            context.startService(svIntent);
//    }
//}