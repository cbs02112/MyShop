<%@page import="myshop.shopuser.UserDTO"%>
<%@page import="myshop.shopuser.UserDAO"%>
<%@page import="myshop.goods.MyShopDAO"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="myshop.cart.CartDAO"%>
<%@page import="myshop.cart.CartDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>



<html>
<head>
<title>구매정보 입력</title>
</head>

<%
    String sessionId = (String)session.getAttribute("sessionId");
	String[] chkbox = request.getParameterValues("cartCheck");
    if(sessionId==null)
     {
%>
   <script>
      alert("로그인 후 이용 가능합니다");
      window.location='/myShop/login/loginForm.jsp';
    </script>

<%}else{ %>
<% 
   int count = 0; //담긴 상품 개수
   int goods_code=0; 
   int number=0;
   int cartTotalPrice = 0; //장바구니 총액
   int startRow=0;
   int endRow=5;
   
   List cartList = null;
   CartDTO dto = new CartDTO();
   CartDAO c_dao = CartDAO.getInstance();
   DecimalFormat df = new DecimalFormat("###,###");
   MyShopDAO dao = MyShopDAO.getInstance();
   count = c_dao.getCartCount(sessionId);
   goods_code = dto.getGoods_code(); 

   if (count > 0){
      cartList = c_dao.getCartList(sessionId, startRow, endRow);
   }
   
   UserDAO userdao = new UserDAO();
   UserDTO userdto = userdao.myInfo(sessionId);
   int cash = Integer.parseInt(userdto.getUser_cash());
%>


<center><h3><b>구매목록</b></h3></center>


<table width="600" border=1 cellpadding="0" ceppspacing="0" align=center>
   <tr>
      <td align="center" width="50">번호</td>
      <td align="center" width="250">상품</td>
      <td align="center" width="100">수량</td>
      <td align="center" width="100">금액</td>
   </tr>
   <%
	for( int i = 0; i < chkbox.length; i++ ){
		CartDTO cart = (CartDTO)cartList.get(Integer.parseInt(chkbox[i])-1);
   %>
   <tr height="30">
      <td align="center"><%=++number %></td>
      <td align="center" width="250" ><%=cart.getGoods_name()%></td>
      <td align="center" width="100" ><%=cart.getAmount()%></td>
      <td align="center" width="100" ><%=cart.getGoods_price()%></td>
      <% cartTotalPrice += (cart.getAmount() * cart.getGoods_price()); %>
     <%}%>
      <tr>
        <td align="right" colspan="5"> 총 금액: <%=df.format(cartTotalPrice)%> 원<br/>
           
     </tr>
</table>
	
   <br />
      <table width="600" border="1" cellspacing="0" cellpadding="3" align="center">
      <tr>
         <td colspan="2" align="center"><b>주문자 정보</b></td>
      </tr>
      <tr>
         <td width="200">성명</td>
         <td width="400"><%= userdto.getUser_name()%></td>
      </tr>
      <tr>
         <td width="200">전화번호</td>
         <td width="400"><%= userdto.getUser_phone()%></td>
      </tr>
      <tr>
         <td width="200">주소</td>
         <td width="400"><%= userdto.getUser_address() %></td>
      </tr>
      </table>
<br />
     <form method = "post" action="buyPro.jsp" >
     <table width="600" border="1" cellspacing="0" cellpadding="3" align="center">
      <tr>
         <td colspan="2" align="center"><b>배송지 정보</b></td>
      </tr>
      <tr>
         <td width="200">성명</td>
         <td width="400">
            <input type="text" name="re_name" style="width:400px;"></td>
      </tr>
      <tr>
         <td width="200">전화번호</td>
         <td width="400">
            <input type="text" name="re_Tel" style="width:400px;"></td>
      </tr>
      <tr>
         <td width="200">주소</td>
         <td width="400">
            <input type="text" name="re_address" style="width:400px;"></td>
      </tr>
      </table>
<br />   
       <table width="600" border="1" cellspacing="0" cellpadding="3" align="center">
      <tr>
         <td colspan="2" align="center"><b>결제 정보</b></td>
      </tr>
      <tr>
         <td width="200">보유 캐시</td>
         <td width="400"><%=df.format(cash)%></td>
      </tr>
      <tr>
         <td width="200">결제 금액</td>
         <td width="400"><%=df.format(cartTotalPrice)%></td>
      </tr>
      <tr>
         <td width="200">남는 캐시</td>
         <% 
         int remain = Integer.parseInt(userdto.getUser_cash())-cartTotalPrice;
         if(remain > 0){%>
         <td width="400"><%=df.format(remain)%></td>
            <%}else{ %>
         <td width="400">보유 캐시가 부족합니다.</td>
         <%} %>
      <input type="hidden" name="totalPrice" value=<%=cartTotalPrice%>>
      </tr>
      <tr>
         <td colspan="2" align="center" >
         <%if(remain > 0){ %>
            <input type="submit" value="결제">
            <%}else{ %>
            <input type="button" value="충전하기" onclick="document.location.href='/myShop/member/cash.jsp'">
            <%} %>
            <input type="button" value="취소" onclick="document.location.href='/myShop/member/cartList.jsp'">
         </td>
      </tr>
      </table>
   </form>
<%} %>
</body>
</html>

   