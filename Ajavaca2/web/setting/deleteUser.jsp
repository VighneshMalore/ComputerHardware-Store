<%@ include file="/dbconn.jsp" %>
<%@ page import="java.sql.Connection, java.sql.PreparedStatement" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" href="deleteUser.css">
        <title>Delete Account</title>
    </head>
    <body>
        <div class="container">
            <a href="/Ajavaca2/index.jsp" class="main-page-link">Go to main page</a>
            <h1>Deleting Account...</h1>
            <div class="message-container">
                <%
                    String email = (String) session.getAttribute("email");

                    if (email == null) {
                        out.println("<p class='error'>Error: Session expired or invalid. Please log in again.</p>");
                    } else {
                        PreparedStatement pst = null;
                        try {
                            String query = "DELETE FROM customers WHERE email = ?";
                            pst = connection.prepareStatement(query);
                            pst.setString(1, email);

                            int rowsDeleted = pst.executeUpdate();
                            if (rowsDeleted > 0) {
                                out.println("<p class='success'>Account deleted successfully. Redirecting to login...</p>");
                                session.invalidate();
                                response.sendRedirect("/Ajavaca2/login/login.jsp");
                            } else {
                                out.println("<p class='error'>Failed to delete account. Please try again.</p>");
                            }
                        } catch (Exception e) {
                            out.println("<p class='error'>Error: " + e.getMessage() + "</p>");
                        } finally {
                            if (pst != null) try { pst.close(); } catch (Exception ex) { }
                        }
                    }
                %>
            </div>
        </div>
    </body>
</html>
