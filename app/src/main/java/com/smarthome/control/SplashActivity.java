package com.smarthome.control;

import android.content.Intent;
import android.os.Bundle;
import android.os.Handler;
import android.os.Looper;
import androidx.appcompat.app.AppCompatActivity;

/**
 * SplashActivity - Shows a flash screen when the app first launches
 * Displays for 2 seconds then navigates to MainActivity
 */
public class SplashActivity extends AppCompatActivity {

    // Duration of splash screen in milliseconds
    private static final int SPLASH_DURATION = 2000;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_splash);

        // Handler to delay navigation to MainActivity
        new Handler(Looper.getMainLooper()).postDelayed(new Runnable() {
            @Override
            public void run() {
                // Navigate to MainActivity after splash duration
                Intent intent = new Intent(SplashActivity.this, MainActivity.class);
                startActivity(intent);
                finish(); // Close splash activity so user can't go back to it
            }
        }, SPLASH_DURATION);
    }
}

