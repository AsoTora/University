
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/MyServlet")
public class MyServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            processRequest(req, resp);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(MyServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(MyServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            processRequest(req, resp);
        } catch (ClassNotFoundException ex) {
            System.out.println(ex);
        } catch (SQLException ex) {
            System.out.println(ex);
        }
    }

    protected void processRequest(HttpServletRequest req, HttpServletResponse resp) throws ClassNotFoundException, SQLException, ServletException, IOException {
        resp.setContentType("text/html;charset=UTF-8");
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        String driver = "com.mysql.jdbc.Driver";
        String url = "jdbc:mysql://localhost/translate?serverTimezone=Europe/Moscow&useSSL=false";
        String username = "root";
        String password = "KS.991017";
        Class.forName(driver);
        Connection conn = DriverManager.getConnection(url, username, password);
        String word = req.getParameter("txt");
        String q = "Select tran, rus FROM tab1 where rus = ? or tran = ?";
        PreparedStatement st = conn.prepareStatement(q);
        st.setString(1, word);
        st.setString(2, word);
        ResultSet set = st.executeQuery();
        set.next();
        String w_en = set.getString(1);
        String w_rus = set.getString(2);
        String w2 = req.getParameter("txt");
                req.setAttribute("txt", w2);
        if (w_en.equals(word)) {
            req.setAttribute("trans", w_rus);    
        } else {
            req.setAttribute("trans", w_en);
        }
        getServletContext().getRequestDispatcher("/index.jsp").forward(req, resp);
    }
}
