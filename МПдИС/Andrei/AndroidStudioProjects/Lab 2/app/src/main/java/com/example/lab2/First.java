package com.example.lab2;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.Toast;

public class First extends Activity {

    private Toast toast;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_first);

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
