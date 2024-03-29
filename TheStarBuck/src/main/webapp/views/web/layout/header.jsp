<%@ page import="vn.edu.hcmuaf.fit.laptrinhweb.model.Cart" %>
<%@ include file="/common/taglib.jsp"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    Cart cart = (Cart) session.getAttribute("cart");
%>
<nav id="header" class="nav">
    <div class="wrapper container">
        <div class="logo"><a href="<c:url value='/user-home'/>">
            <img src="<c:url value='https://i.ibb.co/nMxcqW4/logo.png'/>" alt="">
        </a>
        </div>
        <ul class="nav-list">
            <div class="top">
                <label class="btn close-btn"><i class="fas fa-times"></i></label>
            </div>
            <li><a href="<c:url value='/user-home'/>">Home</a></li>
            <li><a href="<c:url value='/menu'/>">Menu</a></li>
            <li><a href="<c:url value='/blog'/>">Blog</a></li>


            <li>
                <a href="" class="desktop-item">Page <span><i class="fas fa-chevron-down"></i></span></a>
                <input type="checkbox" id="showdrop2" />
                <label for="showdrop2" class="mobile-item">Page <span><i class="fas fa-chevron-down"></i></span></label>
                <ul class="drop-menu2">
                    <li><a href="<c:url value='/views/web/aboutUs.jsp'/>">About Us</a></li>
                    <li><a href="<c:url value='/contact'/>">Contact</a></li>
                </ul>
            </li>

            <!-- icons -->

            <li class="icons">
                <a href="#">
                    <span class="searchBt"><img src="<c:url value='/template/web/image/search.svg'/>" alt="" /></span>
                </a>
            </li>
            <li class="icons">
                <a href="<%=request.getContextPath()%>/cart">
              <span>
                <img src="<c:url value='/template/web/image/shoppingBag.svg'/>" alt="" />
                <small class="count d-flex" id="itemcart">0</small>
              </span>
                </a>
            </li>
            <li class="icons login">
              <span>
                <img src="<c:url value='/template/web/image/user.svg'/>" alt="" />
              </span>
                <input type="checkbox" id="showdrop1" />
                <label for="showdrop1" class="mobile-item"><span><i class="fas fa-chevron-down"></i></span></label>
                <ul class="drop-menu1 <c:if test="${account == null}"> d-none </c:if>" >
                    <li id="manual-ajax"><a href="#">Profile</a></li>
                    <li><a href="${pageContext.request.contextPath}/user-profile-pass">Change password</a></li>
                    <li><a href="<c:url value='/views/web/history.jsp'/>">History</a></li>
                    <li><a href="${pageContext.request.contextPath}/user-management">User Management</a></li>
                    <li><a href="<c:url value='/doLogout'/>">Logout</a></li>
                </ul>
                <ul class="drop-menu1 <c:if test="${account != null}"> d-none </c:if>" >
                    <li><a href="<c:url value='/views/web/login.jsp'/>" >Login</a></li>

                </ul>

            </li>
        </ul>
        <label class="btn open-btn"><i class="fas fa-bars"></i></label>
    </div>
</nav>
<!-- serchBar -->
<section class="ipSearchBox"></section>
<!-- thumbnail -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<script>
function updateCart(){
    $.ajax({
        url: '<%=request.getContextPath()%>/num-cart',
        type: 'GET',
        success: function (data) {
          $("#itemcart").text(data);
        },
        error: function (data) {
            alert('Product is not in cart');
        }
    });

}
updateCart();
</script>