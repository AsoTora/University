import java.io.DataInputStream;
import java.io.IOException;
import java.net.Socket;

public class Client2Thread extends Thread {
    Socket socket;
    DataInputStream dataInputStream;

    public Client2Thread(){
        try{
            socket = new Socket("127.0.0.1",3003);
            dataInputStream = new DataInputStream(socket.getInputStream());
        }
        catch (IOException e){
            System.out.println("Error in LordThread "+ e);
        }
    }

    public void run(){
        while(true){
            try {
                sleep(300);
            } catch (InterruptedException e){
                System.out.println("Error " +e);
            }
            try {
                String message = dataInputStream.readLine();
                if (message == null) break;
                   Serverus.appendText("From Client2 " + message);
                    //System.out.println("After Mum" +message);
                } catch (Exception e){
                    System.out.println("Captain, we have an Error "+ e);
            }
        }
    }
}


