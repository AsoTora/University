package com.example.lab4;

import android.os.Bundle;
import android.app.Activity;
import android.view.ContextMenu;
import android.view.ContextMenu.ContextMenuInfo;
import android.view.MenuItem;
import android.view.View;
import android.view.animation.Animation;
import android.view.animation.AnimationUtils;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ImageView;

public class MainActivity extends Activity{

    // константы для ID пунктов меню
    final int MENU_ALPHA_ID = 1;
    final int MENU_SCALE_ID = 2;
    final int MENU_SCALE_ID_ASYNC = 3;
    final int MENU_ALPHA_ID_ASYNC = 4;
    final int MENU_ALPHA_ID_DUR = 5;
    final int MENU_SCALE_ID_DUR = 6;

    ImageView image2;
    ImageView image1;
    Button button1;
    Button button2;
    Button button3;
    EditText edit_t;


    /** Called when the activity is first created. */
    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        button1 = (Button) findViewById(R.id.button1);
        button2 = (Button) findViewById(R.id.button2);
        button3 = (Button) findViewById(R.id.button3);
        image1 = (ImageView) findViewById(R.id.image1);
        image2 = (ImageView) findViewById(R.id.image2);
        edit_t = (EditText) findViewById(R.id.edit_t);
        // регистрируем контекстное меню для компонента tv
        registerForContextMenu(button1);
        registerForContextMenu(button2);
        registerForContextMenu(button3);

    }

    @Override
    public void onCreateContextMenu(ContextMenu menu, View v,
                                    ContextMenuInfo menuInfo) {
        // TODO Auto-generated method stub
        switch (v.getId()) {
            case R.id.button1:
                // добавляем пункты
                menu.add(0, MENU_ALPHA_ID, 0, "alpha");
                menu.add(0, MENU_SCALE_ID, 0, "scale");
                break;
            case R.id.button2:
                // добавляем пункты
                menu.add(0, MENU_ALPHA_ID_ASYNC, 0, "alpha");
                menu.add(0, MENU_SCALE_ID_ASYNC, 0, "scale");
                break;
            case R.id.button3:
                // добавляем пункты
                menu.add(0, MENU_ALPHA_ID_DUR, 0, "alpha");
                menu.add(0, MENU_SCALE_ID_DUR, 0, "scale");
                break;

        }
        super.onCreateContextMenu(menu, v, menuInfo);
    }


    @Override
    public boolean onContextItemSelected(MenuItem item) {
        Animation anim1 = null;
        Animation anim2 = null;

        switch (item.getItemId()) {
            case MENU_ALPHA_ID:
                // use anim/myalpha
                anim1 = AnimationUtils.loadAnimation(this, R.anim.myalpha);
                anim2 = AnimationUtils.loadAnimation(this, R.anim.myalpha);
                break;
            case MENU_SCALE_ID:
                anim1 = AnimationUtils.loadAnimation(this, R.anim.myscale);
                anim2 = AnimationUtils.loadAnimation(this, R.anim.myscale);
                break;
            case MENU_SCALE_ID_ASYNC:
                anim1 = AnimationUtils.loadAnimation(this, R.anim.myscale);
                anim2 = AnimationUtils.loadAnimation(this, R.anim.myscale_for_async);
                break;
            case MENU_ALPHA_ID_ASYNC:
                anim1 = AnimationUtils.loadAnimation(this, R.anim.myalpha);
                anim2 = AnimationUtils.loadAnimation(this, R.anim.myalpha_for_async);
                break;
            case MENU_ALPHA_ID_DUR:
                anim1 = AnimationUtils.loadAnimation(this, R.anim.myalpha_set_duration);
                String t1 = edit_t.getText().toString();
                int i1 = Integer.parseInt(t1);
                anim1.setDuration(i1);
                anim2 = AnimationUtils.loadAnimation(this, R.anim.myalpha_set_duration);
                anim2.setDuration(i1);
                break;
            case MENU_SCALE_ID_DUR:
                anim1 = AnimationUtils.loadAnimation(this, R.anim.myscale_set_duration);
                String t = edit_t.getText().toString();
                int i = Integer.parseInt(t);
                anim1.setDuration(i);
                anim2 = AnimationUtils.loadAnimation(this, R.anim.myscale_set_duration);
                anim2.setDuration(i);
                break;
        }

        // animation
        image1.startAnimation(anim1);
        image2.startAnimation(anim2);
        return super.onContextItemSelected(item);
    }
}