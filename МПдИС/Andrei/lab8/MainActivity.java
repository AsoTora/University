package com.e.pz8;


import android.app.Activity;

import android.os.Bundle;

import android.view.Menu;

import android.view.MenuItem;

import android.view.View;

import android.webkit.WebView;

import android.webkit.WebViewClient;

import android.widget.Button;

import android.widget.EditText;

import android.widget.TextView;

import android.widget.Toast;

import java.io.FileInputStream;

import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;

public class MainActivity extends Activity {
    private final static String FILE_NAME = "content.txt";
    Button b1;

    EditText ed1;

    private WebView wv1;

    @Override

    protected void onCreate(Bundle savedInstanceState) {

        super.onCreate(savedInstanceState);

        setContentView(R.layout.activity_main);

        b1=(Button)findViewById(R.id.button);

        ed1=(EditText)findViewById(R.id.editText);

        wv1=(WebView)findViewById(R.id.webView);

        wv1.setWebViewClient(new MyBrowser());

        b1.setOnClickListener(new View.OnClickListener() {

            @Override

            public void onClick(View v) {

                String url = ed1.getText().toString();

                wv1.getSettings().setLoadsImagesAutomatically(true);

                wv1.getSettings().setJavaScriptEnabled(true);

                wv1.setScrollBarStyle(View.SCROLLBARS_INSIDE_OVERLAY);

                wv1.loadUrl(url);
                FileOutputStream fos = null;
                try {
                    EditText row1 = (EditText) findViewById(R.id.editText);

                    String text1 = row1.getText().toString();

                    String text = text1 + '\n';
                    try {
                        fos = openFileOutput(FILE_NAME, MODE_APPEND);
                    } catch (FileNotFoundException e) {
                        e.printStackTrace();
                    }
                    try {
                        fos.write(text.getBytes());
                    } catch (IOException e) {
                        e.printStackTrace();
                    }

                } catch (Exception e) {
                    e.printStackTrace();
                }

            }

        });

    }
    public  void openText(View v) throws FileNotFoundException {
        FileInputStream fin = null;
        TextView textView = (TextView) findViewById(R.id.textView);
        try {
            fin = openFileInput(FILE_NAME);
            byte[] bytes = new byte[fin.available()];
            fin.read(bytes);
            String text = new String (bytes);
            textView.setText(text);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
    private class MyBrowser extends WebViewClient {

        @Override

        public boolean shouldOverrideUrlLoading(WebView view, String url) {

            view.loadUrl(url);

            return true;

        }

    }



}