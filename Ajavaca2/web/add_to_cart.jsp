<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.sql.SQLException"%>
<%@ page import="javax.servlet.http.HttpSession"%>
<%@ page import="javax.servlet.RequestDispatcher"%>
<%@ include file="dbconn.jsp" %>

<%
    String message = null;
    String email = (String) session.getAttribute("email");
    if (email != null) {
        int productId = Integer.parseInt(request.getParameter("product_id"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        PreparedStatement stmt = null;
        ResultSet rs = null;
        try {
            String sql = "SELECT customer_id FROM customers WHERE email = ?";
            stmt = connection.prepareStatement(sql);
            stmt.setString(1, email);
            rs = stmt.executeQuery();
            if (rs.next()) {
                int customerId = rs.getInt("customer_id");
                String insertSql = "INSERT INTO cart (customer_id, product_id, quantity) VALUES (?, ?, ?)";
                stmt = connection.prepareStatement(insertSql);
                stmt.setInt(1, customerId);
                stmt.setInt(2, productId);
                stmt.setInt(3, quantity);
                int rowsInserted = stmt.executeUpdate();
                if (rowsInserted > 0) {
                    session.setAttribute("cust_id", customerId);
                    message = "Product added to your cart!";
                } else {
                    message = "There was an issue adding the product to your cart.";
                }
            } else {
                message = "Customer not found!";
            }
        } catch (SQLException e) {
            message = "Error: " + e.getMessage();
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    } else {
        message = "You need to log in to add items to your cart.";
    }
    session.setAttribute("message", message);
    response.sendRedirect("cart/cart.jsp");
%>
