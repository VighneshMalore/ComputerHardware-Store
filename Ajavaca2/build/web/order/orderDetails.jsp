<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@include file="/dbconn.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Order Details</title>
        <link rel="stylesheet" href="orderDetails.css">
    </head>
    <body>
        <h1>Order Details</h1>
        <a href="/Ajavaca2/index.jsp">Go to main page</a>
        <table>
            <thead>
                <tr>
                    <th>Order Detail ID</th>
                    <th>Order ID</th>
                    <th>Product Name</th>
                    <th>Quantity</th>
                    <th>Price</th>
                </tr>
            </thead>
            <tbody>
                <%
                    PreparedStatement stmt = null;
                    ResultSet rs = null;

                    try {
                        String query = "SELECT od.order_detail_id, od.order_id, p.product_name, od.quantity, od.price " +
                                       "FROM order_details od " +
                                       "JOIN products p ON od.product_id = p.product_id";

                        stmt = connection.prepareStatement(query);
                        rs = stmt.executeQuery();

                        while (rs.next()) {
                            int orderDetailId = rs.getInt("order_detail_id");
                            int orderId = rs.getInt("order_id");
                            String productName = rs.getString("product_name");
                            int quantity = rs.getInt("quantity");
                            double price = rs.getDouble("price");

                            %>
                            <tr>
                                <td><%= orderDetailId %></td>
                                <td><%= orderId %></td>
                                <td><%= productName %></td>
                                <td><%= quantity %></td>
                                <td><%= price %></td>
                            </tr>
                            <%
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
                %>
            </tbody>
        </table>
    </body>
</html>
