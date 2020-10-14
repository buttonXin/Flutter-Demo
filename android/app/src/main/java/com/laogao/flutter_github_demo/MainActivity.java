package com.laogao.flutter_github_demo;

import android.Manifest;
import android.os.Build;
import android.os.Bundle;
import android.util.Log;

import androidx.annotation.Nullable;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.android.SplashScreen;

public class MainActivity extends FlutterActivity {

    @Nullable
    @Override
    public SplashScreen provideSplashScreen() {
        Log.e("lao_gao", "provideSplashScreen: 11");
        return new  SimpleSplashScreen();
    }


    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        Log.e("lao_gao", "onCreate: 22");
    }
}
