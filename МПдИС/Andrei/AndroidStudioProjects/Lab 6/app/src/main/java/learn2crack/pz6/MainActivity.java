package learn2crack.pz6;


import android.os.Bundle;
import android.view.View;
import android.widget.EditText;
import android.widget.TextView;
import android.widget.Toast;

import androidx.appcompat.app.AppCompatActivity;

import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;

public class MainActivity extends AppCompatActivity {

    private final static String FILE_NAME = "content.txt";

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
    }
    // сохранение файла
    public void saveText(View view){

        FileOutputStream fos = null;
        try {
            EditText row1 = (EditText) findViewById(R.id.surname);
            EditText row2 = (EditText) findViewById(R.id.group);
            EditText row3 = (EditText) findViewById(R.id.faculty);
            String text1 = row1.getText().toString();
            String text2 = row2.getText().toString();
            String text3 = row3.getText().toString();
            String text = text1 + ' ' + text2 + ' ' + text3 + '\n';
            fos = openFileOutput(FILE_NAME, MODE_APPEND);
            fos.write(text.getBytes());
            Toast.makeText(this, "Файл сохранен", Toast.LENGTH_SHORT).show();
        }
        catch(IOException ex) {

            Toast.makeText(this, ex.getMessage(), Toast.LENGTH_SHORT).show();
        }
        finally{
            try{
                if(fos!=null)
                    fos.close();
            }
            catch(IOException ex){

                Toast.makeText(this, ex.getMessage(), Toast.LENGTH_SHORT).show();
            }
        }
    }
    // открытие файла
    public void openText(View view){

        FileInputStream fin = null;
        TextView textView = (TextView) findViewById(R.id.open_text);
        try {
            fin = openFileInput(FILE_NAME);
            byte[] bytes = new byte[fin.available()];
            fin.read(bytes);
            String text = new String (bytes);
            textView.setText(text);
        }
        catch(IOException ex) {

            Toast.makeText(this, ex.getMessage(), Toast.LENGTH_SHORT).show();
        }
        finally{

            try{
                if(fin!=null)
                    fin.close();
            }
            catch(IOException ex){

                Toast.makeText(this, ex.getMessage(), Toast.LENGTH_SHORT).show();
            }
        }
    }
    public void findText(View view){

        FileInputStream fin = null;
        TextView textView = (TextView) findViewById(R.id.open_text);
        try {
            EditText search_info = (EditText) findViewById(R.id.search_info);
            String value = search_info.getText().toString();
            fin = openFileInput(FILE_NAME);
            byte[] bytes = new byte[fin.available()];
            fin.read(bytes);
            String text = new String (bytes);
            String[] substr, subsubstring;
            substr = text.split("\n");
            text = "";
            for(int i = 0; i < substr.length; i++)
            {
                subsubstring = substr[i].split(" ");
                for(int j = 0; j < subsubstring.length; j++)
                {
                    if(subsubstring[j].equals(value))
                    {
                        text += substr[i] + '\n';
                    }
                }
            }
            textView.setText(text);
        }
        catch(IOException ex) {

            Toast.makeText(this, ex.getMessage(), Toast.LENGTH_SHORT).show();
        }
        finally{

            try{
                if(fin!=null)
                    fin.close();
            }
            catch(IOException ex){

                Toast.makeText(this, ex.getMessage(), Toast.LENGTH_SHORT).show();
            }
        }
    }
}