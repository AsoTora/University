import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

public class MyServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html");
        req.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html;charset=UTF-8");

        String inputWord="" + req.getParameter("inputWord");
        String outWord="";
        PrintWriter writer=resp.getWriter();

        try{
            String url="jdbc:mysql://localhost:3306/Lab3_for_AIPRP";
            String username= "root";
            String password = "sasha991999a";
            Class.forName("com.mysql.jdbc.Driver");
            try (Connection conn=DriverManager.getConnection(url, username, password)){
                Statement statement = conn.createStatement();
                char[] c=inputWord.toCharArray();
                if ((c[0] >= 'a')&&(c[0] <= 'z')){
                    ResultSet resultSet = statement.executeQuery("SELECT * FROM dictionary where english='" + inputWord + "'");
                    while (resultSet.next()) {
                        outWord += resultSet.getString("russian");
                    }
                } else {
                    ResultSet resultSet = statement.executeQuery("SELECT * FROM dictionary where russian='" + inputWord + "'");
                    while (resultSet.next()) {
                        outWord += resultSet.getString("english");
                    }
                }
            }

            if(inputWord=="" || outWord =="") outWord="NOT FOUND";
            StringBuilder a = new StringBuilder();

            a.append("<!DOCTYPE html>\n" +
                    "<html>\n" +
                    "      <head>\n" +
                    "        <title></title>\n" +
                    "        <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">\n" +
                    "    </head>\n" +
                    "    <body bgcolor=\"#aaccff\">\n" +
                    "        <Font color=\"green\" size=\"10\">\n" +
                    "         Форма для работы со словарем\n" +
                    "        </Font>\n" +
                    "        <br>\n" +
                    "        <br>\n" +
                    "        <form name=\"frm\" method=\"Get\" action=\"MyServlet\">\n" +
                    "            <Font color=\"blue\" size=\"6\">Слово:</Font><Input type=\"Text\" name=\"inputWord\" Value=\"" + inputWord + "\"/>\n" +
                    "            <br>\n" +
                    "            <br>\n" +
                    "        <Font color=\"blue\" size=\"6\">Перевод:</Font><input type=\"text\" name =\"outWord\" value=\""+ outWord+"\"/disabled><br>\n" +
                    "        <h4>Кликните здесь для получения перевода :<Input type=\"submit\" value=\"Перевести\"/>\n" +
                    "        </h4>\n" +
                    "           \n" +
                    "        </form>\n" +
                    "    </body>\n" +
                    "</html>");

            inputWord = "";
            writer.println(a);



        } catch (Exception e) {
            writer.println("Connection failed...");
            writer.println(e);
        }
        finally {
            writer.close();
        }
    }
}