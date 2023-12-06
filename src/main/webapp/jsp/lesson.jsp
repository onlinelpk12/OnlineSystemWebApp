<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
   <script src="../js/verifytoken.js" type="text/javascript"></script>
  <script type="text/javascript">
    $(function(){
      verifytoken();
    });
    
    function reInitiateFreshPage(){
    	sessionStorage.setItem("pageIdToShow",'');
    }
  </script>
<meta charset="UTF-8">
<title>Lessons</title>
<%@ include file = "header.jsp" %>
<style>
a.disabled {
/* Make the disabled links grayish*/color: gray;
/* And disable the pointer events */pointer-events: none;
}
</style>
</head>
<body>
	<div class="container pt-5">
		<div class="row">
		<div class="col-sm-6">
		<h2>Click below links to view the lessons:</h2>
		<ul id="lessonList"></ul>
		</div>
	</div>
<script src="../js/lesson.js"></script>
<%@ include file = "footer.jsp" %>
</body>
</html>
