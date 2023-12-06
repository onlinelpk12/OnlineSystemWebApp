<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dynamic Rendering</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    <!-- Bootstrap and jQuery JS libraries -->
	<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</head>
<body>

<section id="dynamicContent" class="container" hidden>
    <div class="row">
        <div class="col-md-6 content" style="margin-left: 20rem;">
            <h1 class="text-primary" id="header"></h1>
            <div id="data"></div>

            <div id="questionsAndInputs"></div>
		</div>
    </div>
</section>

<script>
    // Replace this JSON string with the actual data from your database
    var jsonData = '{"course_name":"OnlineLpk12","lesson_name":"Lesson4","page_num":3,"header":"Extend Our Model for Parent of Peter -- 1","data":"\\r\\nExtend your model:\\r\\nAssume the relation you will use is\\r\\nparent(P1, P2)means that person P1 is the parent of person P2.","questions":"Write your knowledge as a comment?~Represent your knowledge as a fact?","answers":""}';

    // Parse JSON data
    var lessonData;
    try {
        lessonData = JSON.parse(jsonData.replace(/\\r\\n/g, '\\n'));
    } catch (error) {
        console.error('Error parsing JSON:', error);
    }

        if (!lessonData) {
            console.error('Invalid lesson data.');
        }

        // Set header
        document.getElementById('header').innerText = lessonData.header;

        // Set data
        document.getElementById('data').innerText = lessonData.data;

        // Split questions by "~"
        var questions = lessonData.questions.split('~');

        // Render questions and input fields
        var questionsAndInputsContainer = document.getElementById('questionsAndInputs');
        console.log(questions);
        questions.forEach(function (question) {
            var questionElement = document.createElement('p');
            questionElement.innerText = question;

            var inputElement = document.createElement('input');
            inputElement.type = 'text';
            inputElement.className = 'form-control';

            console.log(inputElement);
            console.log(questionElement);
            // Append question and input to the container
            questionsAndInputsContainer.appendChild(questionElement);
            questionsAndInputsContainer.appendChild(inputElement);
        });
        console.log(questionsAndInputsContainer);
        var dynCon = document.getElementById('dynamicContent');
        dynCon.appendChild(questionsAndInputsContainer);
        
        dynCon.hidden = false;

    // Call the render function on page load
    
</script>



</body>
</html>
