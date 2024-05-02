package Empcrud;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class SaveServlet
 */
@WebServlet("/AddServlet")
public class AddServlet extends HttpServlet {
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		int empno = Integer.parseInt(request.getParameter("eno"));
		String empname = request.getParameter("ename");
		String job = request.getParameter("ejob");
		int salary = Integer.parseInt(request.getParameter("esalary"));
		EmployeeDAO.addEmployee(empno, empname, job, salary);
	}

}
