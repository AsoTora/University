package com.example.a777;

import androidx.appcompat.app.AppCompatActivity;
import androidx.core.app.ActivityCompat;
import androidx.core.content.ContextCompat;

import android.Manifest;
import android.content.pm.PackageManager;
import android.os.Bundle;
import android.widget.Toast;

public class DroidActivity2 extends AppCompatActivity {
    private final int MY_PERMISSION_REQUEST_CAMERA=100;
    private final int MY_PERMISSION_REQUEST_INTERNET=101;
    private final int MY_PERMISSION_REQUEST_READ_CONTACTS=102;
    private final int MY_PERMISSION_REQUEST_WRITE_CONTACTS=103;
    private final int MY_PERMISSION_REQUEST_ACCESS_WIFI_STATE=104;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_droid2);

        if(ContextCompat.checkSelfPermission(this, Manifest.permission.READ_CONTACTS)!= PackageManager.PERMISSION_GRANTED){
            //ActivityCompat.requestPermissions(this,new String[]{Manifest.permission.READ_CONTACTS},MY_PERMISSION_REQUEST_READ_CONTACTS);
            Toast.makeText(getApplicationContext(),"READ_CONTACTS PERMISSION NOT GRANTED!",Toast.LENGTH_LONG).show();
        }
        else{
            Toast.makeText(getApplicationContext(),"READ_CONTACTS PERMISSION GRANTED!",Toast.LENGTH_LONG).show();
        }

        if(ContextCompat.checkSelfPermission(this,Manifest.permission.WRITE_CONTACTS)!=PackageManager.PERMISSION_GRANTED){
            //ActivityCompat.requestPermissions(this,new String[]{Manifest.permission.WRITE_CONTACTS},MY_PERMISSION_REQUEST_WRITE_CONTACTS);
            Toast.makeText(getApplicationContext(),"WRITE_CONTACTS PERMISSION NOT GRANTED!",Toast.LENGTH_LONG).show();
        }
        else{
            Toast.makeText(getApplicationContext(),"WRITE_CONTACTS PERMISSION GRANTED!",Toast.LENGTH_LONG).show();
        }

        if(ContextCompat.checkSelfPermission(this,Manifest.permission.ACCESS_WIFI_STATE)!=PackageManager.PERMISSION_GRANTED) {
            //ActivityCompat.requestPermissions(this,new String[]{Manifest.permission.ACCESS_WIFI_STATE},MY_PERMISSION_REQUEST_ACCESS_WIFI_STATE);
            Toast.makeText(getApplicationContext(), "ACCESS_WIFI_STATE PERMISSION NOT GRANTED!", Toast.LENGTH_LONG).show();
        }
        else{
            Toast.makeText(getApplicationContext(),"ACCESS_WIFI_STATE PERMISSION GRANTED!",Toast.LENGTH_LONG).show();
        }

        if(ContextCompat.checkSelfPermission(this,Manifest.permission.INTERNET)!=PackageManager.PERMISSION_GRANTED){
           // ActivityCompat.requestPermissions(this,new String[]{Manifest.permission.INTERNET},MY_PERMISSION_REQUEST_INTERNET);
            Toast.makeText(getApplicationContext(),"INTERNET PERMISSION NOT GRANTED!",Toast.LENGTH_LONG).show();
        }
        else{
            Toast.makeText(getApplicationContext(),"INTERNET PERMISSION GRANTED!",Toast.LENGTH_LONG).show();
        }

        if(ContextCompat.checkSelfPermission(this,Manifest.permission.CAMERA)!=PackageManager.PERMISSION_GRANTED){
            //ActivityCompat.requestPermissions(this,new String[]{Manifest.permission.CAMERA},MY_PERMISSION_REQUEST_CAMERA);
            Toast.makeText(getApplicationContext(),"CAMERA PERMISSION NOT GRANTED!",Toast.LENGTH_LONG).show();
        }
        else{
            Toast.makeText(getApplicationContext(),"CAMERA PERMISSION GRANTED!",Toast.LENGTH_LONG).show();
        }

    }
/*
        public void onRequestPermissionsResult(int requestCode, String permissions[], int[] grantResults){
        if (requestCode==MY_PERMISSION_REQUEST_CAMERA){
            if (grantResults.length > 0 && grantResults[0]==PackageManager.PERMISSION_GRANTED){
                Toast.makeText(getApplicationContext(),"CAMERA PERMISSION GRANTED!",Toast.LENGTH_SHORT).show();
//разрешение было предоставлено
            }
            else {
                Toast.makeText(getApplicationContext(),"CAMERA PERMISSION NOT GRANTED!",Toast.LENGTH_SHORT).show();
// разрешение не было предоставлено


            }
            return;
        }

    }

*/





        /*
            switch (requestCode){
            case MY_PERMISSION_REQUEST_CAMERA:{
                if (grantResults.length > 0 && grantResults[0]==PackageManager.PERMISSION_GRANTED){
                    Toast.makeText(getApplicationContext(),"CAMERA PERMISSION GRANTED!",Toast.LENGTH_SHORT).show();
//разрешение было предоставлено
                }
                else {
                    Toast.makeText(getApplicationContext(),"CAMERA PERMISSION NOT GRANTED!",Toast.LENGTH_SHORT).show();
// разрешение не было предоставлено
                }
                return;
            }
            case MY_PERMISSION_REQUEST_INTERNET:{
                if (grantResults.length > 0 && grantResults[0]==PackageManager.PERMISSION_GRANTED){
                    Toast.makeText(getApplicationContext(),"INTERNET PERMISSION GRANTED!",Toast.LENGTH_SHORT).show();
//разрешение было предоставлено
                }
                else {
                    Toast.makeText(getApplicationContext(),"INTERNET PERMISSION NOT GRANTED!",Toast.LENGTH_SHORT).show();
// разрешение не было предоставлено
                }
                return;
            }
            case MY_PERMISSION_REQUEST_READ_CONTACTS:{
                if (grantResults.length > 0 && grantResults[0]==PackageManager.PERMISSION_GRANTED){
                    Toast.makeText(getApplicationContext(),"READ_CONTACTS PERMISSION GRANTED!",Toast.LENGTH_SHORT).show();
//разрешение было предоставлено
                }
                else {
                    Toast.makeText(getApplicationContext(),"READ_CONTACTS PERMISSION NOT GRANTED!",Toast.LENGTH_SHORT).show();
// разрешение не было предоставлено
                }
                return;
            }
            case MY_PERMISSION_REQUEST_WRITE_CONTACTS:{
                if (grantResults.length > 0 && grantResults[0]==PackageManager.PERMISSION_GRANTED){
                    Toast.makeText(getApplicationContext(),"WRITE_CONTACTS PERMISSION GRANTED!",Toast.LENGTH_SHORT).show();
//разрешение было предоставлено
                }
                else {
                    Toast.makeText(getApplicationContext(),"WRITE_CONTACTS PERMISSION NOT GRANTED!",Toast.LENGTH_SHORT).show();
// разрешение не было предоставлено
                }
                return;
            }
            case MY_PERMISSION_REQUEST_ACCESS_WIFI_STATE:{
                if (grantResults.length > 0 && grantResults[0]==PackageManager.PERMISSION_GRANTED){
                    Toast.makeText(getApplicationContext(),"ACCESS_WIFI_STATE PERMISSION GRANTED!",Toast.LENGTH_SHORT).show();
//разрешение было предоставлено
                }
                else {
                    Toast.makeText(getApplicationContext(),"ACCESS_WIFI_STATE PERMISSION NOT GRANTED!",Toast.LENGTH_SHORT).show();
// разрешение не было предоставлено
                }
                return;
            }
        }
    }
*/
}
