package com.example.lab2;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.Toast;

public class Second extends Activity {
    private Toast toast;

    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_second);

        toast = Toast.makeText(this, "", Toast.LENGTH_SHORT);
    }

    public void onClickSave(View view){
        toast.setText("Сохранено");
        toast.show();
    }

    public void onClickBack (View view){
        startActivity(new Intent(this, MainActivity.class));
    }
}
