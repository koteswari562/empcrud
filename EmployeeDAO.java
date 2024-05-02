package Empcrud;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class EmployeeDAO {

	public static List<Employee> getEmployees() {
		List<Employee> employees = new ArrayList<>();
		DBConn dbobj = new DBConn();
		Connection con = dbobj.getDBConnection();
		try {
			PreparedStatement stmt = con.prepareStatement("SELECT * FROM emp_k");
			ResultSet rs = stmt.executeQuery();
			while (rs.next()) {
				int empNo = rs.getInt("empno");
				String empName = rs.getString("ename");
				String job = rs.getString("job");
				int salary = rs.getInt("salary");
				Employee employee = new Employee(empNo, empName, job, salary);
				employees.add(employee);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return employees;
	}

	public static void addEmployee(int empno, String empname, String job, int salary) {
		// TODO Auto-generated method stub
		DBConn dbobj = new DBConn();
		Connection con = dbobj.getDBConnection();
		try {
			PreparedStatement stmt = con.prepareStatement("insert into emp_k(empno,ename,job,salary) values(?,?,?,?)");
			stmt.setInt(1, empno);
			stmt.setString(2, empname);
			stmt.setString(3, job);
			stmt.setInt(4, salary);
			stmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public static void editEmployee(int empno, String empname, String job, int salary) {
		// TODO Auto-generated method stub
		DBConn dbobj = new DBConn();
		Connection con = dbobj.getDBConnection();
		try {
			PreparedStatement stmt = con.prepareStatement("update emp_k set ename=?,job=?,salary=? where empno=?");
			stmt.setString(1, empname);
			stmt.setString(2, job);
			stmt.setInt(3, salary);
			stmt.setInt(4, empno);
			stmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public static void deleteEmployee(int empno) {
		// TODO Auto-generated method stub
		DBConn dbobj = new DBConn();
		Connection con = dbobj.getDBConnection();
		try {
			PreparedStatement stmt = con.prepareStatement("delete from emp_k where empno=?");
			stmt.setInt(1, empno);
			stmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

}
