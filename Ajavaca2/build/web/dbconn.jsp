<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>

<%
    String url = "jdbc:mysql://localhost:3306/computerstore?allowPublicKeyRetrieval=true&useSSL=false";
    String username = "root"; 
    String password = "root75";
    Connection connection = null;
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        connection = DriverManager.getConnection(url, username, password);
    } catch (SQLException e) {
        out.println("<p>Error: " + e.getMessage() + "</p>");
        e.printStackTrace();
    } catch (ClassNotFoundException e) {
        out.println("<p>JDBC Driver not found: " + e.getMessage() + "</p>");
    }
%>
