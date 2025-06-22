<%@ include file="/dbconn.jsp" %>
<%@ page import="java.sql.PreparedStatement" %>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" href="register.css">
</head>
<body>
  <h1>THE COMPUTER STORE</h1>


    <h1>Register Page</h1>
    <a href="/Ajavaca2/index.jsp">Go to Main Page</a>
    <br>
    <form method="POST">
        <p>Enter your Username</p>
        <input type="text" name="name" required>
        <p>Enter your phone number</p>
        <input type="text" name="phone_number">
        <p>Enter your email</p>
        <input type="email" name="email" required>
        <p>Create your password</p>
        <input type="password" name="password" required>
        <input type="submit" value="Register">
    </form>
    <br>
    <p>Not signed in yet? Click <a href="/Ajavaca2/login/login.jsp">here</a> to login.</p>

    <% 
        if (request.getMethod().equalsIgnoreCase("POST")) {
            String name = request.getParameter("name");
            String phone = request.getParameter("phone_number");
            String email = request.getParameter("email");
            String Password = request.getParameter("password");

            if (email != null && Password != null) {
                PreparedStatement pst = null;
                try {
                    String sql = "INSERT INTO customers (username, email, phone, password) VALUES (?, ?, ?, ?)";
                    pst = connection.prepareStatement(sql);

                    pst.setString(1, name);
                    pst.setString(2, email);
                    pst.setString(3, phone);
                    pst.setString(4, Password);

                    int rowsInserted = pst.executeUpdate();

                    if (rowsInserted > 0) {
                        out.println("<p class='success'>Registration successful!</p>");
                    } else {
                        out.println("<p class='error'>Error: Could not register the customer.</p>");
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                    out.println("<p class='error'>Error: " + e.getMessage() + "</p>");
                } finally {
                    try {
                        if (pst != null) pst.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
            } else {
                out.println("<p class='error'>Error: Email and password are required fields.</p>");
            }
        }
    %>
</body>
</html>
