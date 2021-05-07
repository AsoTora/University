package com.example.lab3;

import android.annotation.SuppressLint;
import android.app.Activity;
import android.app.AlertDialog;
import android.content.DialogInterface;
import android.graphics.Color;
import android.os.Bundle;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.Button;
import android.widget.LinearLayout;
import android.widget.Toast;


public class MainActivity extends Activity implements OnClickListener {

    private Button switchToGreen;
    private Button switchToRed;
    private Button switchToBlue;
    private Button switchToYellow;
    private Button switchToImg;
    private Button TextDevelop;
    private LinearLayout screenLayout;
    private Toast informationToast;

    @SuppressLint("ShowToast")
    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        switchToBlue = (Button) findViewById(R.id.switchBlue);
        switchToGreen = (Button) findViewById(R.id.switchGreen);
        switchToRed = (Button) findViewById(R.id.switchRed);
        switchToYellow = (Button) findViewById(R.id.switchYellow);
        switchToImg = (Button) findViewById(R.id.switchImg);
        TextDevelop = (Button) findViewById(R.id.TextDevelop);
        screenLayout = (LinearLayout) findViewById(R.id.screenLayout);

        switchToBlue.setOnClickListener(this);
        switchToRed.setOnClickListener(this);
        switchToGreen.setOnClickListener(this);
        switchToYellow.setOnClickListener(this);
        switchToImg.setOnClickListener(this);
        TextDevelop.setOnClickListener(this);
        informationToast = Toast.makeText(this, "", Toast.LENGTH_SHORT);
    }

    public void onClick(View view) {
        if (switchToBlue.equals(view)) {
            screenLayout.setBackgroundColor(Color.BLUE);
            showToast("Hello blue");
        } else if (switchToRed.equals(view)) {
            screenLayout.setBackgroundColor(Color.RED);
            showToast("Hello red");
        } else if (switchToGreen.equals(view)) {
            screenLayout.setBackgroundColor(Color.GREEN);
            showToast("Hello green");
        } else if (switchToYellow.equals(view)) {
            screenLayout.setBackgroundColor(Color.YELLOW);
            showToast("Hello yellow");
        } else if (switchToImg.equals(view)) {
            screenLayout.setBackgroundResource(R.drawable.image);
            showToast("Hello image");
        } else if (TextDevelop.equals(view)) {
            Dialog();
        }
    }

    private void showToast(String text) {
        if (text == null) {
            informationToast.cancel();
        }
        informationToast.setText(text);
        informationToast.show();
    }

    private void Dialog(){
        AlertDialog.Builder dialog = new AlertDialog.Builder(this);
        dialog.setTitle("Made by")
                .setMessage("Shvedau Andrei")
                .setPositiveButton("Back", new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialog, int which) {
                        dialog.cancel();
                    }
                });
        AlertDialog Information = dialog.create();
        Information.show();
    }
}