package com.smarthome.control;

import android.os.Bundle;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ListView;
import android.widget.Toast;
import androidx.appcompat.app.AppCompatActivity;
import java.util.ArrayList;

/**
 * SystemModeActivity - Screen for selecting system mode (Auto, Cool, Heat, Off)
 * Displays a list of available modes with selection functionality
 */
public class SystemModeActivity extends AppCompatActivity {

    // UI Components
    private ListView modeListView;
    
    // Available system modes
    private ArrayList<String> systemModes;
    
    // Currently selected mode index
    private int selectedModeIndex = 0;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_system_mode);

        // Initialize UI components
        initializeViews();

        // Set up system modes list
        setupSystemModes();

        // Set up list view listener
        setupListViewListener();
    }

    /**
     * Initialize all view references
     */
    private void initializeViews() {
        modeListView = findViewById(R.id.listview_modes);
    }

    /**
     * Create and populate the system modes list
     */
    private void setupSystemModes() {
        // Create list of available modes
        systemModes = new ArrayList<>();
        systemModes.add(getString(R.string.auto_mode));
        systemModes.add(getString(R.string.cool_mode));
        systemModes.add(getString(R.string.heat_mode));
        systemModes.add(getString(R.string.off_mode));

        // Create and set adapter (using a simple adapter with built-in layout)
        android.widget.ArrayAdapter<String> adapter = new android.widget.ArrayAdapter<>(
            this,
            android.R.layout.simple_list_item_single_choice,
            systemModes
        );
        
        modeListView.setAdapter(adapter);
        modeListView.setChoiceMode(ListView.CHOICE_MODE_SINGLE);
        
        // Set default selection (Auto mode)
        modeListView.setItemChecked(0, true);
    }

    /**
     * Set up listener for mode selection
     */
    private void setupListViewListener() {
        modeListView.setOnItemClickListener(new AdapterView.OnItemClickListener() {
            @Override
            public void onItemClick(AdapterView<?> parent, View view, int position, long id) {
                // Update selected mode
                selectedModeIndex = position;
                String selectedMode = systemModes.get(position);
                
                // Show confirmation toast
                Toast.makeText(SystemModeActivity.this, 
                    getString(R.string.mode_saved) + ": " + selectedMode, 
                    Toast.LENGTH_SHORT).show();
                
                // Return to previous screen after a short delay
                new android.os.Handler(android.os.Looper.getMainLooper()).postDelayed(
                    new Runnable() {
                        @Override
                        public void run() {
                            finish();
                        }
                    }, 
                    1000 // 1 second delay
                );
            }
        });
    }
}

