<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@include file="/dbconn.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="processOrder.css">
        <meta http-equiv="refresh" content="2; url=/Ajavaca2/index.jsp" />
        <title>Place Order</title>
    </head>
    <body>
        <%
           
            int productId = Integer.parseInt(request.getParameter("product_id"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));

            
            Integer cust_id = (Integer) session.getAttribute("cust_id");

            if (cust_id == null) {
                out.println("<p>You are not logged in. Please log in to place an order.</p>");
            } else {
                PreparedStatement productStmt = null;
                PreparedStatement orderStmt = null;
                PreparedStatement orderDetailsStmt = null;
                ResultSet productRs = null;
                ResultSet orderRs = null;

                try {
                    
                    String productQuery = "SELECT price FROM products WHERE product_id = ?";
                    productStmt = connection.prepareStatement(productQuery);
                    productStmt.setInt(1, productId);
                    productRs = productStmt.executeQuery();

                    if (productRs.next()) {
                        double price = productRs.getDouble("price");

                       
                        double totalAmount = price * quantity;

                      
                        String orderQuery = "INSERT INTO orders (customer_id, total_amount) VALUES (?, ?)";
                        orderStmt = connection.prepareStatement(orderQuery, PreparedStatement.RETURN_GENERATED_KEYS);
                        orderStmt.setInt(1, cust_id);
                        orderStmt.setDouble(2, totalAmount);
                        int rowsInserted = orderStmt.executeUpdate();

                        if (rowsInserted > 0) {
                         
                            orderRs = orderStmt.getGeneratedKeys();
                            if (orderRs.next()) {
                                int orderId = orderRs.getInt(1);

                              
                                String orderDetailsQuery = "INSERT INTO order_details (order_id, product_id, quantity, price) VALUES (?, ?, ?, ?)";
                                orderDetailsStmt = connection.prepareStatement(orderDetailsQuery);
                                orderDetailsStmt.setInt(1, orderId);
                                orderDetailsStmt.setInt(2, productId);
                                orderDetailsStmt.setInt(3, quantity);
                                orderDetailsStmt.setDouble(4, price);
                                int orderDetailsInserted = orderDetailsStmt.executeUpdate();

                                if (orderDetailsInserted > 0) {
                                    out.println("<p>Order placed successfully, and order details recorded!</p>");
                                } else {
                                    out.println("<p>Order placed, but failed to record order details. Please contact support.</p>");
                                }
                            }
                        } else {
                            out.println("<p>Failed to place the order. Please try again.</p>");
                        }
                    } else {
                        out.println("<p>Invalid product. Please try again.</p>");
                    }
                } catch (Exception e) {
                    out.println("<p>Error: " + e.getMessage() + "</p>");
                    e.printStackTrace();
                } finally {
                    try {
                        if (productRs != null) productRs.close();
                        if (orderRs != null) orderRs.close();
                        if (productStmt != null) productStmt.close();
                        if (orderStmt != null) orderStmt.close();
                        if (orderDetailsStmt != null) orderDetailsStmt.close();
                    } catch (Exception e) {
                        out.println("<p>Error closing resources: " + e.getMessage() + "</p>");
                    }
                }
            }
        %>
    </body>
</html>
