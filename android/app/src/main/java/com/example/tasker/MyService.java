//package com.example.tasker;
//
//import android.app.NotificationChannel;
//import android.app.NotificationManager;
//import android.app.Service;
//import android.content.Intent;
//import android.os.Handler;
//import android.os.IBinder;
//import android.os.Looper;
//
//import androidx.annotation.Nullable;
//import androidx.core.app.NotificationCompat;
//
//import java.util.Random;
//import java.util.Timer;
//import java.util.TimerTask;
//
//public class MyService extends Service {
//    private NotificationManager notificationManager;
//    private NotificationCompat.Builder builder = null;
//
//    private Timer timer = null;
//
//    @Override
//    public int onStartCommand(Intent intent, int flags, int startId) {
//        super.onStartCommand(intent, flags, startId);
//        return START_STICKY;
//    }
//
//    @Override
//    public void onCreate() {
//        super.onCreate();
//        initNotification();
//        startTimer();
//    }
//
//    @Override
//    public void onDestroy() {
//        super.onDestroy();
//        stopTimer();
//        sendBroacastOnDestroy();
//    }
//
//    @Nullable
//    @Override
//    public IBinder onBind(Intent intent) {
//        return null;
//    }
//
//    /* khởi tạo notification */
//    void initNotification(){
//        if(Config.buildVersionO()){
//            NotificationChannel notificationChannel = new NotificationChannel(
//                    Config.notification_channel_id, Config.notification_channel_name,
//                    NotificationManager.IMPORTANCE_LOW
//            );
//
//            notificationManager = getSystemService(NotificationManager.class);
//            notificationManager.createNotificationChannel(notificationChannel);
//
//            builder = new NotificationCompat.Builder(this, Config.notification_channel_id)
//                    .setContentTitle("Background service")
//                    .setContentText("waiting...")
//                    .setSmallIcon(R.drawable.launch_background);
//
//            /* Notification luôn hiển thị trong khi sv chạy */
//            startForeground(Config.notification_id, builder.build());
//
//            /* Notification bắn 1 lần, có thể vuốt để loại bỏ khỏi thanh thông báo */
//            //notificationManager.notify(Config.notification_id, builder.build());
//        }
//    }
//
//    /* cập nhật builder và cập nhật là notification */
//    void updateNotificationMessage(String msg){
//        builder.setContentText(msg);
//        notificationManager.notify(Config.notification_id, builder.build());
//    }
//
//    /* khởi tạo timer, lấy 1 con số ngẫu nhiên và bắn notification */
//    void startTimer(){
//        if(timer == null){
//            timer = new Timer();
//            TimerTask timerTask = new TimerTask() {
//                @Override
//                public void run() {
//                    new Handler(Looper.getMainLooper()).post(new Runnable() {
//                        @Override
//                        public void run() {
//                            MainActivity.callFLT();
//                        }
//                    });
//                    updateNotificationMessage("geting locale");
//                }
//            };
//
//            timer.schedule(timerTask, Config.timer_delay, Config.timer_interval);
//        }
//    }
//
//    /* hủy bỏ timer */
//    void stopTimer(){
//        if(timer != null){
//            timer.cancel();
//            timer = null;
//        }
//    }
//
//    /* gửi một tin nhắn tới broacastReceiver cho biết sv đã bị hủy */
//    void sendBroacastOnDestroy(){
//        Intent megIntent = new Intent(Config.msg_broacast_on_sv_destroy);
//        sendBroadcast(megIntent);
//    }
//}