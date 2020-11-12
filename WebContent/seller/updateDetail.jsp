<%@page import="myshop.shopuser.UserDAO"%>
<%@page import="myshop.shopuser.UserDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "myshop.goods.*" %>
<h1> goodsDetail.jsp</h1>

<%
	String code = request.getParameter("goods_code");
	if(code == null){
		System.out.println("코드못받음");
	}
	int goods_code = Integer.parseInt(code);
	
	String pageNum = request.getParameter("pageNum");
	if(pageNum == null) {
		pageNum = "1";
		
	}
		GoodsDAO dao = GoodsDAO.getInstance();
		GoodsDTO dto = dao.updateGetAlbum(goods_code);
		
%>

	<form method="post" action="updateDetailPro.jsp" enctype="multipart/form-data">
	<table border="1" align="center">
	
	<col style="width:px;">
	<tbody>
		<tr>
		<th>
		<input type="text" name="goods_name" value="<%=dto.getGoods_name()%>"></th>
		<td>
		<img src="/myShop/imgsave/sellerimg/<%=dto.getGoods_img()%>"><br>
		<input type="file" name="goods_img" value="/myShop/imgsave/sellerimg/<%=dto.getGoods_img()%>">
		
		</td>
		
		<tr>
		<th>판매가</th>
		<td>
		<input type="text" name="goods_price" value="<%=dto.getGoods_price()%>"></td>
		</tr>
		
		<tr>
		<th>상품코드</th>
		<td>
		<input type="text" name="goods_code" value="<%=dto.getGoods_code()%>"></td>
		</tr>
		
		<tr>
		<th>제조사/공급사</th>
		<td>
		<input type="text" name="goods_brand" value="<%=dto.getGoods_brand() %>"></td>
		</tr>
		
		<tr>	
		<th>남은수량</th>
		<td>
		<input type="text" name="goods_count" value="<%=dto.getGoods_count()%>"></td>
		</td>
		</tr>
		
		<tr>
		<th>옵션선택</th>
		<td> 
		<select name="goods_option">
			<option>옵션</option>
			<option>옵션1</option>
			<option>옵션2</option>
			<option>옵션3</option>
			<option>옵션4</option>
		</select>
		</td>	
		</tr>
		
		<tr>
		<th>배송비</th>
		<td>
		<input type="text" name="goods_delivery" value="<%=dto.getGoods_delivery()%>"></td>
		</tr>
		</tbody>
		</table>
		
		<center> 
		
		<% String goods_brand = (String)session.getAttribute("user_id");
		
		UserDTO udto = new UserDTO();
		UserDAO udao = new UserDAO();
		UserDTO infodto = udao.myInfo(goods_brand);
		String rating = infodto.getRating();
		
		if(rating.equals("2")){ %>  
	<input type="submit" value="수정하기" ><%} %> 	
		
		
		<h2>제품설명</h2>  
	<br>
	
	
	<img src="<%=dto.getGoods_msg() %>"></br>

	 
	</center>
	</form>
	<h2>상품댓글</h2>
	
	
	<h2>상품 Q&A</h2>