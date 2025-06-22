<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@include file="dbconn.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>Main page</title>
    <link rel="stylesheet" href="index.css">
</head>
<body>
    <nav class="nav">
        <ul>
            <li><a href="register/register.jsp">Register</a></li>
            <li><a href="login/login.jsp">Login</a></li>
            <li><a href="setting/setting.jsp">Setting</a></li>
            <li><a href="cart/cart.jsp">Cart</a></li>
            <li><a href="order/orderDetails.jsp">Order</a></li>
        </ul>
    </nav>
    <div class="product-container">
    <%
        if (connection != null) {
            PreparedStatement stmt = null;
            ResultSet rs = null;

            try {
                String sql = "SELECT * FROM products";
                stmt = connection.prepareStatement(sql);
                rs = stmt.executeQuery();
                
                while (rs.next()) {
                    int productId = rs.getInt("product_id");
                    String productName = rs.getString("product_name");
                    double price = rs.getDouble("price");
                    int stock = rs.getInt("stock");
                    String imageUrl = rs.getString("image_url");

                    out.println("<div class='product-card'>");
                    out.println("<div class='product-image'>");
                    out.println("<img src='images/" + imageUrl + "' alt='" + productName + "' />");
                    out.println("</div>");
                    out.println("<div class='product-details'>");
                    out.println("<h3>" + productName + "</h3>");
                    out.println("<p class='price'>Rs " + price + "</p>");
                    out.println("<p>Stock: " + stock + "</p>");
                    out.println("<form action='add_to_cart.jsp' method='post'>");
                    out.println("<input type='hidden' name='product_id' value='" + productId + "' />");
                    out.println("<input type='number' name='quantity' value='1' min='1' max='" + stock + "' />");
                    out.println("<button type='submit'>Add to Cart</button>");
                    out.println("</form>");
                    out.println("</div>");
                    out.println("</div>");
                }
            } catch (SQLException e) {
                out.println("<p>Error: " + e.getMessage() + "</p>");
                e.printStackTrace();
            } finally {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
            }
        } else {
            out.println("<p>Connection not available!</p>");
        }
    %>
    </div>
</body>
</html>
