package Empcrud;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConn {
	static String url = "jdbc:postgresql://192.168.110.48/postgres";
	static String username = "plf_training_admin";
	static String password = "pff123";
	Connection con;

	public Connection getDBConnection() {
		// TODO Auto-generated method stub
		try {
			Class.forName("org.postgresql.Driver");
			try {
				con = DriverManager.getConnection(url, username, password);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} catch (ClassNotFoundException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		return con;
	}
}
