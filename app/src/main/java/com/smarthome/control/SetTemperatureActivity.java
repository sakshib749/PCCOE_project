package com.smarthome.control;

import android.os.Bundle;
import android.view.View;
import android.widget.SeekBar;
import android.widget.TextView;
import android.widget.Toast;
import androidx.appcompat.app.AppCompatActivity;
import com.google.android.material.button.MaterialButton;

/**
 * SetTemperatureActivity - Screen for setting target temperature
 * Allows user to adjust temperature using a seekbar and save or cancel
 */
public class SetTemperatureActivity extends AppCompatActivity {

    // UI Components
    private TextView temperatureDisplay;
    private SeekBar temperatureSeekBar;
    private MaterialButton saveButton;
    private MaterialButton cancelButton;

    // Current temperature value
    private int currentTemperature = 72;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_set_temperature);

        // Get intent data (mode and default temperature)
        Bundle extras = getIntent().getExtras();
        if (extras != null) {
            int defaultTemp = extras.getInt("defaultTemp", 72);
            currentTemperature = defaultTemp;
        }

        // Initialize UI components
        initializeViews();

        // Set up temperature seekbar
        setupTemperatureSeekBar();

        // Set up button listeners
        setupButtonListeners();
    }

    /**
     * Initialize all view references
     */
    private void initializeViews() {
        temperatureDisplay = findViewById(R.id.tv_temperature_display);
        temperatureSeekBar = findViewById(R.id.seekbar_temperature);
        saveButton = findViewById(R.id.btn_save);
        cancelButton = findViewById(R.id.btn_cancel);
    }

    /**
     * Set up the temperature seekbar with min/max values and listener
     * Note: SeekBar range is 0-50 (for API compatibility), representing 50-100°F
     */
    private void setupTemperatureSeekBar() {
        // Set temperature range (0-50 represents 50-100 degrees)
        // This approach works on all Android versions
        temperatureSeekBar.setMax(50);
        
        // Convert temperature to seekbar progress (50°F = 0, 100°F = 50)
        int progress = currentTemperature - 50;
        temperatureSeekBar.setProgress(progress);

        // Update display with current temperature
        updateTemperatureDisplay(currentTemperature);

        // Listen for temperature changes
        temperatureSeekBar.setOnSeekBarChangeListener(new SeekBar.OnSeekBarChangeListener() {
            @Override
            public void onProgressChanged(SeekBar seekBar, int progress, boolean fromUser) {
                // Convert progress back to temperature (progress 0-50 -> temp 50-100)
                currentTemperature = progress + 50;
                updateTemperatureDisplay(currentTemperature);
            }

            @Override
            public void onStartTrackingTouch(SeekBar seekBar) {
                // Not needed
            }

            @Override
            public void onStopTrackingTouch(SeekBar seekBar) {
                // Not needed
            }
        });
    }

    /**
     * Update the temperature display text
     * @param temperature - Temperature value to display
     */
    private void updateTemperatureDisplay(int temperature) {
        temperatureDisplay.setText(temperature + "°F");
    }

    /**
     * Set up save and cancel button listeners
     */
    private void setupButtonListeners() {
        // Save button - shows toast and returns to previous screen
        saveButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                // Show confirmation toast
                Toast.makeText(SetTemperatureActivity.this, 
                    getString(R.string.temperature_saved), 
                    Toast.LENGTH_SHORT).show();
                
                // Return to previous screen
                finish();
            }
        });

        // Cancel button - returns to previous screen without saving
        cancelButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                // Return to previous screen without saving
                finish();
            }
        });
    }
}

