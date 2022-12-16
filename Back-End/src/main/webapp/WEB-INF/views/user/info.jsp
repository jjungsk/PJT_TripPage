<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
{
	"result" : "${result}",
	"user" : {
		"id" : "${user.id}",
		"password" : "${user.password}",
		"name" : "${user.name}",
		"email" : "${user.email}",
		"tel" : "${user.tel}",
		"isManager" : "${user.isManager}"
	}
}