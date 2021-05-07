package com.example.myapplication5;

import java.io.FileNotFoundException;
import java.io.InputStream;
import android.net.Uri;
import android.os.Bundle;
import android.app.Activity;
import android.content.Intent;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.Button;
import android.widget.ImageView;

import com.example.myapplication5.R;

public class MainActivity extends Activity {

    //Объявляем используемые переменные:
    private ImageView imageView;
    private final int Pick_image = 1;
    
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        // Связываемся с ImageView:
        imageView = (ImageView)findViewById(R.id.imageView);

        // Связываемся с кнопкой Button:
        Button PickImage = (Button) findViewById(R.id.button);
        //Настраиваем для нее обработчик нажатий OnClickListener:
        PickImage.setOnClickListener(new OnClickListener() {

            @Override
            public void onClick(View view) {
                // Intent - абстрактное описание операции, которое вызывает что-то с атрибутами
                Intent photoPickerIntent = new Intent(Intent.ACTION_PICK);
                // Тип получаемых объектов - image:
                photoPickerIntent.setType("image/*");
                // Запускаем переход с ожиданием обратного результата в виде информации об изображении:
                startActivityForResult(photoPickerIntent, Pick_image);
            }
        });
    }

    // Обрабатываем результат выбора в галерее:
    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent imageReturnedIntent) {
        super.onActivityResult(requestCode, resultCode, imageReturnedIntent);

        switch(requestCode) {
            case Pick_image:
                if(resultCode == RESULT_OK){
                    try {
                        //Получаем URI изображения, преобразуем его в Bitmap
                        //объект и отображаем в элементе ImageView нашего интерфейса:
                        final Uri imageUri = imageReturnedIntent.getData();
                        final InputStream imageStream = getContentResolver().openInputStream(imageUri);
                        final Bitmap selectedImage = BitmapFactory.decodeStream(imageStream);
                        imageView.setImageBitmap(selectedImage);    //для чтения ресурса изображения в объект Bitmap

                    } catch (FileNotFoundException e) {
                        e.printStackTrace();
                    }
                }
        }
    }
}