package com.smarthome.control;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.TextView;
import androidx.appcompat.app.AppCompatActivity;
import com.google.android.material.bottomnavigation.BottomNavigationView;
import com.google.android.material.card.MaterialCardView;

/**
 * MainActivity - Home screen with room information, temperature controls,
 * hold options, and bottom navigation
 */
public class MainActivity extends AppCompatActivity {

    // UI Components
    private MaterialCardView heatCard;
    private MaterialCardView coolCard;
    private BottomNavigationView bottomNavigation;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        // Initialize UI components
        initializeViews();

        // Set up click listeners
        setupClickListeners();

        // Set up bottom navigation
        setupBottomNavigation();
    }

    /**
     * Initialize all view references
     */
    private void initializeViews() {
        heatCard = findViewById(R.id.card_heat);
        coolCard = findViewById(R.id.card_cool);
        bottomNavigation = findViewById(R.id.bottom_navigation);
    }

    /**
     * Set up click listeners for heat and cool cards
     */
    private void setupClickListeners() {
        // When user clicks "Heat to 50°" card
        heatCard.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                openSetTemperatureScreen("heat", 50);
            }
        });

        // When user clicks "Cool to 90°" card
        coolCard.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                openSetTemperatureScreen("cool", 90);
            }
        });
    }

    /**
     * Opens the Set Temperature Screen
     * @param mode - "heat" or "cool"
     * @param defaultTemp - Default temperature value
     */
    private void openSetTemperatureScreen(String mode, int defaultTemp) {
        Intent intent = new Intent(MainActivity.this, SetTemperatureActivity.class);
        intent.putExtra("mode", mode);
        intent.putExtra("defaultTemp", defaultTemp);
        startActivity(intent);
    }

    /**
     * Set up bottom navigation menu
     */
    private void setupBottomNavigation() {
        bottomNavigation.setOnItemSelectedListener(item -> {
            int itemId = item.getItemId();
            
            if (itemId == R.id.nav_home) {
                // Already on home screen
                return true;
            } else if (itemId == R.id.nav_system) {
                // Open System Mode Screen
                Intent intent = new Intent(MainActivity.this, SystemModeActivity.class);
                startActivity(intent);
                return true;
            } else if (itemId == R.id.nav_fan || itemId == R.id.nav_priority) {
                // These could be implemented for future features
                // For now, just keep the selection active
                return true;
            }
            
            return false;
        });

        // Set home as selected by default
        bottomNavigation.setSelectedItemId(R.id.nav_home);
    }
}

