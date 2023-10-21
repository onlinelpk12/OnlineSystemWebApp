<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
 <!-- <script src="../js/verifytoken.js" type="text/javascript"></script> -->
<meta charset="UTF-8">
<title>Home</title>
<%-- <%@ include file = "header.jsp" %> --%>
</head>
<body>
<div style="text-align:center">
     
<h2 id="title"> Welcome to Online LPK12 Project</h2>
</div>
<div class="container pt-5" style="text-align:center">
<div class="row">
<div class="col-md-6">
<h2>OnlineLPK</h2>
<div class="card" style="width:400px">
<form action="lessonnumber.jsp">
<img class="card-img-top" src="../images/lpkimage.jpg" alt="lessons" style="width:100%" height="100%">
<div class="card-body">
<!-- <p class="card-text">Click below to view lessons</p> -->
<a href="home.jsp" class="btn btn-primary">Take me there!</a>
</div>
</form>
</div>
</div>

<div class="col-sm-6">
<h2>Logic DS</h2>
<div class="card" style="width:400px">
<form action="progress.jsp">






<img class="card-img-top" src="../images/lpkimage.jpg" alt="OnlineLpk" style="width:100%">
<div class="card-body">
<!-- <p class="card-text">Click below to view progress</p> -->
<a href="../jsp/student.jsp" class="btn btn-primary">Take me there!</a>
</div>
</form>
</div>
</div>

</div>
</div>
<br>
<div class="footer">
  <h4>Online LPK12 Project</h4>
</div>
<%-- <%@ include file = "footer.jsp" %> --%>
<script>

/* $(function() {
 verifytoken();
$("#goBackButton").hide();
}); */

</script>
</body>
<style>
.footer {
  position: fixed;
  left: 0;
  bottom: 0;
  width: 100%;
  background-color: steelblue;
  color: white;
  text-align: center;
}

</style>
</html>
