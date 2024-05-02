package Empcrud;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

/**
 * Servlet implementation class EmpDisplayServlet
 */
@WebServlet("/EmpDisplayServlet")
public class EmpDisplayServlet extends HttpServlet {
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		List<Employee> products = EmployeeDAO.getEmployees();
		response.setContentType("application/json");
		Gson gson = new Gson();
		String productsJson = gson.toJson(products);
		response.getWriter().write(productsJson);
	}

}
