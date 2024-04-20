<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Course Dashboard</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    <!-- jQuery -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <!-- Bootstrap JavaScript -->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
    <!-- JavaScript function to clear session -->
    <script type="text/javascript">
        function reInitiateFreshPage(){
            sessionStorage.setItem("pageIdToShow",'');
        }
    </script>
    <!-- Meta charset and title -->
    <meta charset="UTF-8">
    <title>Insert title here</title>
    <!-- Include header file -->
    <%@ include file = "header.jsp" %>
    <!-- Custom CSS -->
    <style>
        a.disabled {
            /* Make the disabled links grayish */
            color: gray;
            /* And disable the pointer events */
            pointer-events: none;
        }
        .course-item{
     background-color: rgb(242, 242, 242);
    display: flex;
    justify-content: space-between;
    padding: 8px;
    border-radius: 8px;
    margin-bottom: 12px;
        }
        
        .search-bar {
            margin-right: 10px; /* Adjust margin as needed */
        }
       
       #courseList {
    list-style-type: disc; /* Apply bullets to list items */
    padding-left: 20px; /* Adjust padding for bullets */
    list-style-position: inside; /* Ensure bullets are displayed inside the flex container */
}

        
        
    </style>
</head>
<body>
    <!-- Container for content -->
    <div class="container ">
        <div class="row gx-4">
            <!-- First column for Courses heading -->
            
             <div style="display: flex; margin: 10px 0px;">
                    <!-- Search bar -->
                    <input type="text" class="form-control search-bar" placeholder="Search...">
                    <button class="btn btn-primary" data-toggle="modal" data-target="#createCourseModal"style='border-radius:999px'>Create Course</button>
                    <!-- Button for creating a course -->
                </div>
            </div>
        
        <div>
            <h2>Courses:</h2>
            <ul id="courseList"></ul>
        </div>
    </div>

    <!-- Create Course Modal -->
    <div id="createCourseModal" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <!-- Modal content -->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title" >Create Course</h4>
                </div>
                <div class="modal-body">
                    <form>
                        <div class="form-group">
                            <label for="courseName">Course Name:</label>
                            <input type="text" class="form-control" id="courseName">
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-success" onclick="saveCourse()"style='border-radius:999px '>Save</button>
                    <button type="button" class="btn btn-danger" data-dismiss="modal"style='border-radius:999px'>Cancel</button>
                </div>
            </div>
        </div>
    </div>
    <!-- End Create Course Modal -->

    <!-- Include footer file -->
    <%@ include file = "footer.jsp" %>

    <!-- JavaScript function to save the course -->
    <script type="text/javascript">
    function saveCourse() {
        // Retrieve the course name from the input field
        var courseName = $("#courseName").val();

        // Create a new row element with the course name and buttons
        var newRow = $("<li class='course-item'></li>");
        newRow.css("background-color", "#f2f2f2"); // Set background color to ash color
        

        // Append the course name to the new row
        newRow.append("<span>" + courseName + "</span>");

        // Add buttons for publish, edit, and delete
        var buttons = $("<div class='course-buttons'></div>");
        buttons.append("<button class='btn btn-success'style='border-radius:999px'>Publish/UnPublish</button>");
        buttons.append("<button class='btn btn-warning'style='margin-left: 5px; border-radius:999px'>Edit</button>");
        buttons.append("<button class='btn btn-danger'style='margin-left: 5px;border-radius:999px'>Delete</button>");

        // Append buttons to the new row
        newRow.append(buttons);

        // Append the new row to the course list
        $("#courseList").append(newRow);

        // Close the modal
        $("#createCourseModal").modal("hide");

        // Clear the input field for the next entry
        $("#courseName").val("");
    }

    </script>
</body>
</html>
