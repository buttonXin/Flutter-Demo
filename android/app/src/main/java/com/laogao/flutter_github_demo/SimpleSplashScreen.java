package com.laogao.flutter_github_demo;

import android.content.Context;
import android.graphics.Color;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.ImageView;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import io.flutter.embedding.android.SplashScreen;

public class SimpleSplashScreen implements SplashScreen {
    @Nullable
    @Override
    public View createSplashView(@NonNull Context context, @Nullable Bundle savedInstanceState) {

        Log.e("lao_gao", "createSplashView: 33");

        ImageView textView = new ImageView(context);
        textView.setBackgroundResource(R.drawable.launch_background);
//        textView.setScaleType(ImageView.ScaleType.FIT_XY);
        return textView;
    }

    @Override
    public void transitionToFlutter(@NonNull Runnable onTransitionComplete) {
        onTransitionComplete.run();
    }
}
