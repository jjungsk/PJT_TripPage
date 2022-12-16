<%@ page language="java" contentType="application/json; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %> 
{
"list" : [
			<c:forEach varStatus="i" var="article" items="${list}">
				{
				"articleNo" : "${article.articleNo}",
				"subject" : "${article.subject}",
				"userId" : "${article.userId}",
				"hit" : "${article.hit}",
				"registerTime": "${article.registerTime}"
				}
				<c:if test="${i.index != list.size() - 1}">,</c:if>
			</c:forEach>
		]
}
