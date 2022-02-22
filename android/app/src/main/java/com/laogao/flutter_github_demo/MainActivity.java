package com.laogao.flutter_github_demo;

import android.Manifest;
import android.app.Activity;
import android.os.Build;
import android.os.Bundle;
import android.util.Log;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import com.laogao.flutter_github_demo.account.AccountPlugin;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.android.SplashScreen;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.platform.PlatformPlugin;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {

//    @Nullable
//    @Override
//    public SplashScreen provideSplashScreen() {
//        Log.e("lao_gao", "provideSplashScreen: 11");
//        return new  SimpleSplashScreen();
//    }


    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        Log.e("lao_gao", "onCreate: 22");
    }


    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine);

        // 操作数据库
        flutterEngine.getPlugins().add(new AccountPlugin(this));

    }
}
