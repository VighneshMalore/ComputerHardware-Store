<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@include file="/dbconn.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="cart.css">
        <title>Your Cart</title>
    </head>
    <body>
        <div class="container">
            <h1>Your Shopping Cart</h1>
            <%
                String message = (String) session.getAttribute("message");
                if (message != null) {
                    out.println("<p class='message'>" + message + "</p>");
                    session.removeAttribute("message");
                }

                Integer cust_id = (Integer) session.getAttribute("cust_id");

                if (cust_id == null) {
                    out.println("<p class='error'>You are not logged in. Please log in to view your cart.</p>");
                } else {
                    PreparedStatement stmt = null;
                    ResultSet rs = null;

                    try {
                        String sql = "SELECT product_id, quantity FROM cart WHERE customer_id = ?";
                        stmt = connection.prepareStatement(sql);
                        stmt.setInt(1, cust_id);
                        rs = stmt.executeQuery();

                        if (!rs.next()) {
                            out.println("<p class='info'>Your cart is empty.</p>");
                        } else {
                            out.println("<table class='cart-table'>");
                            out.println("<tr><th>Product Name</th><th>Quantity</th><th>Action</th></tr>");

                            do {
                                int productId = rs.getInt("product_id");
                                int quantity = rs.getInt("quantity");

                                PreparedStatement productStmt = connection.prepareStatement("SELECT product_name FROM products WHERE product_id = ?");
                                productStmt.setInt(1, productId);
                                ResultSet productRs = productStmt.executeQuery();

                                if (productRs.next()) {
                                    String productName = productRs.getString("product_name");

                                    out.println("<tr>");
                                    out.println("<td>" + productName + "</td>");
                                    out.println("<td>" + quantity + "</td>");
                                    out.println("<td>");
                                    
                                    out.println("<form action='processOrder.jsp' method='post'>");
                                    out.println("<input type='hidden' name='product_id' value='" + productId + "' />");
                                    out.println("<input type='hidden' name='quantity' value='" + quantity + "' />");
                                    out.println("<button type='submit' class='order-btn'>Order</button>");
                                    out.println("</form>");
                                    out.println("</td>");
                                    out.println("</tr>");
                                }

                                productRs.close();
                                productStmt.close();
                            } while (rs.next());

                            out.println("</table>");
                        }
                    } catch (Exception e) {
                        out.println("<p class='error'>Error: " + e.getMessage() + "</p>");
                        e.printStackTrace();
                    } finally {
                        try {
                            if (rs != null) rs.close();
                            if (stmt != null) stmt.close();
                        } catch (Exception e) {
                            out.println("<p class='error'>Error closing resources: " + e.getMessage() + "</p>");
                        }
                    }
                }
            %>
        </div>
    </body>
</html>
