<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Logic DS Lessons</title>
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    
    <style>
        body {
    font-family: 'Arial', sans-serif;
}
.row.equal-height > .col-md-3 {
            display: flex;
            flex-flow: column;
        }

.card {
    margin-bottom: 30px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    transition: 0.3s;

    margin: 15px;
            border-radius: 10px;
            overflow: hidden;
            flex: 1; 
    
    
}

.card:hover {
    box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
}

.card img {
    width: 100%;
    height: 200px;  /* adjust based on your design */
    object-fit: cover;
    
    
}

.card-title {
    font-size: 1.2em;
    margin-bottom: 10px;
}

.card-text {
    font-size: 1em;
    color: #777;
    margin-bottom: 15px;
}
.footer {
  position: fixed;
  left: 0;
  bottom: 0;
  width: 100%;
  color: white;
  text-align: center;
}

    </style>
    <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
</head>
<body>
<div class="my-10  text-white" style="display: flex; background-color :#1b84f5;width: 100%; height: 10%; margin-bottom: 5%; justify-content: space-between; align-items: center; padding-left: 1%; padding-right: 1%;">
  <div style="flex: 0 0 auto; width: auto; max-width: none;">
    <form action="header.jsp">
      <a href="#" id="goBackButton" onclick="history.back()"><img height="30" width="40" src="../images/back.png"></a>
      <a id="homepagelink" href="home.jsp"><img height="30" width="40" src="../images/home.png"></a>
    </form>
  </div>
  <div style="flex: 1 0 auto; text-align: center;">
    <h2 id="title" style="color: white;">Welcome to Online LPK12 Course</h2>
  </div>
  <div style="flex: 0 0 auto; text-align: right;">
    <h4 id="userName" style="color: white; margin-right: 10px;"></h4>
  </div>
  <div style="flex: 0 0 auto; text-align: right;">
    <a onclick="sessionclear()" class="btn btn-warning">Logout</a>
  </div>
</div>

    <div class="container mt-5">
        <h2 class="mb-4">Get Started with These Lessons:</h2>
        <div class="row">
			<div class="col-md-3">
         		<div class="card">
              		<img src="../images/Screenshot 2023-10-29 180624.png" class="card-img-top" alt="Lesson Image">
                   	<div class="card-body">
                       <p class="card-text">Lesson 0</p>
                       <a href="../jsp/lesson0Ids.jsp" class="btn btn-primary">View Lesson</a>
                    </div>
         	</div>
     	</div>
     	
     	<div class="col-md-3">
         		<div class="card">
              		<img src="../images/Screenshot 2023-10-29 180624.png" class="card-img-top" alt="Lesson Image">
                   	<div class="card-body">
                       <p class="card-text">Lesson 1</p>
                       <a href="../jsp/lesson1Part1Ids.jsp" class="btn btn-primary">View Lesson</a>
                    </div>
         	</div>
         	</div>
            <!-- You can repeat this block for each lesson -->
            <div class="col-md-3">
                <div class="card">
                    <img src="../images/Screenshot 2023-10-29 180624.png" class="card-img-top" alt="Lesson Image">
                    <div class="card-body">
                        <p class="card-text">Lesson 2</p>
                        <!--<button id="view-lesson2-btn" class="btn btn-primary">View Lesson</button>-->

                        <a href="../jsp/lesson2Ids.jsp" onclick="reInitiateFreshPage()" class="btn btn-primary">View Lesson</a> 
                    </div>
                </div>
            </div>
            
            
            <!-- End of block -->
            <div class="col-md-3">
                <div class="card">
                    <img src="../images/Lesson2.jpg" class="card-img-top" alt="Lesson Image">
                    <div class="card-body">
                        <p class="card-text">Lesson 3</p>
                        <a href="../jsp/lesson3Ids.jsp" onclick="reInitiateFreshPage()" class="btn btn-primary">View Lesson</a>
                       
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card">
                    <img src="../images/puzzle.png" class="card-img-top" alt="Lesson Image">
                    <div class="card-body">
                        <p class="card-text">Lesson 4</p>
                        <a href="../jsp/lesson4lds.jsp" onclick="reInitiateFreshPage()" class="btn btn-primary">View Lesson</a>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card">
                    <img src="../images/puzzle.png" class="card-img-top" alt="Lesson Image">
                    <div class="card-body">
                        <p class="card-text">Lesson 4.1</p>
                        <a href="../jsp/lesson4N5ReviewIds.jsp" onclick="reInitiateFreshPage()" class="btn btn-primary">View Lesson</a>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card">
                    <img src="../images/Lesson5.jpg" class="card-img-top" alt="Lesson Image">
                    <div class="card-body">
                        <p class="card-text">Lesson 5</p>
                        <a href="../jsp/lesson5lds.jsp" onclick="reInitiateFreshPage()" class="btn btn-primary">View Lesson</a>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card">
                    <img src="../images/Lesson6.png" class="card-img-top" alt="Lesson Image">
                    <div class="card-body">
                        <p class="card-text">Lesson 6</p>
                        <a href="../jsp/lesson6Ids.jsp" onclick="reInitiateFreshPage()" class="btn btn-primary">View Lesson</a>
                    </div>
                </div>
            </div>

	<%@ include file="footer.jsp"%>
</body>
</html>
