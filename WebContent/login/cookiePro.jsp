<%@page import="myshop.user.UserDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<h1>cookiePro</h1>

<jsp:useBean id="dto" class="myshop.user.UserDTO" />
<jsp:setProperty property="*" name="dto" />

 
<%
    	UserDAO dao = UserDAO.getInstance();
    	boolean result = dao.loginCheck(dto);
    
    	if(result){//쿠키생성하는 부분
    		session.setAttribute("sessionId", dto.getUser_id());
    		session.setAttribute("sessionAuto",dto.getAuto());
    		response.sendRedirect("/myShop/index.jsp");
		}else {
%>
			<script>
				alert("아이디 / 패스워드를 다시 입력해주십시오.");
				location.href = "/myShop/login/loginForm.jsp";
			</script>
		  
<%
		} 
%>		  
		  