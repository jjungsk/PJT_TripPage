<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
{
"list" : [
				<c:forEach varStatus="i" var="article" items="${list}">
					{
					"subject" : "${article.subject}",
					"hit" : "${article.hit}"
					}
					<c:if test="${i.index != list.size() - 1}">,</c:if>
				</c:forEach>
			]
}