<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // Invalidate the current user session to log out
    session.invalidate();

    // Redirect back to login page
    response.sendRedirect("login.jsp");
%>
