<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, height=device-height">
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <title>Lesson Editor</title>
    <style>
        /* Custom styles */
        .header {
            display: flex;
            align-items: center;
            padding: 1.25rem!important;
        }
        .editor textarea {
            width: 30vw;
            height: 80vh; 
            resize: none;          
        }
        .sidebar {
            background-color: #f8f9fa;
            padding-top: 20px;
            border: 0.25px solid black;
            height: 90vh;
            border-radius: 20px;
        }
        .editor, .preview {
            background-color: #f8f9fa;
            border: 1px solid black;
            border-radius: 20px;
            padding: 20px;
        }
        .editor h2, .preview h2 {
            margin: 0;
        }
        #preview {
            height: 80vh;
            width: 30vw;
        }
        .status-message {
            padding: 10px;
            margin-top: 10px;
            border-radius: 5px;
        }
        .success-message {
            background-color: #d4edda;
            border-color: #c3e6cb;
            color: #155724;
        }
        .error-message {
            background-color: #f8d7da;
            border-color: #f5c6cb;
            color: #721c24;
        }
        /* Selected slide style */
        .selected {
            border: 2px solid #007bff; /* Highlight with blue border */
            background-color: #e2e6ea; /* Light gray background */
        }
    </style>
    <!-- Include header file -->
    <%@ include file = "header.jsp" %>
    <!-- Custom CSS -->
</head>
<body>
    <div class="container-fluid">
        <div class="row mt-2 ml-2">
            <div class="col-sm-3 sidebar">
                <div class="d-flex justify-content-between">
                    <button type="button" id="newSlide" class="btn btn-primary">New Slide</button>
                    <button type="button" id="deleteSlide" class="btn btn-danger">Delete Slide</button>
                </div>
                <br>
                <div id="slidesContainer" class="d-flex flex-column">
                    <!-- Slide buttons will be added dynamically -->
                </div>
            </div>
            <div class="col-sm-4 editor">
                <div class="d-flex justify-content-center">
                    <h2>Editor</h2>
                    <div id="statusMessage" class="status-message" style="display: none;"></div>
                </div>
                <textarea id="editor" rows="10" cols="50"></textarea>
                <div class="d-flex justify-content-end">
                    <button type="button" id="compile" class="btn btn-secondary">Compile</button>
                </div>
            </div>
            <div class="col-sm-4 preview">
                <div class="d-flex justify-content-center">
                    <h2>Preview</h2>
                </div>
                <div id="preview"></div>
                <!-- Save Button -->
                <div class="d-flex justify-content-end mt-2">
                    <button type="button" id="save" class="btn btn-success">Save</button>
                </div>
            </div>
        </div>
    </div>
    <%@ include file = "footer.jsp" %>
    <!-- jQuery and Font Awesome -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>

    <!-- JavaScript Logic -->
    <script>
    var slideCount = 0; // Track the number of slides
    var selectedSlideId = 4; // Set to the ID of the slide you want to update

    // Function to set the correct slide ID when a slide is selected
    function setSelectedSlideId() {
        var selectedSlide = document.querySelector(".sidebar .selected");
        if (selectedSlide) {
            selectedSlideId = selectedSlide.getAttribute("data-slide-id");
        }
    }

    function getUrlParams(url) {
        var params = {};
        var parser = document.createElement('a');
        parser.href = url;
        var query = parser.search.substring(1);
        var vars = query.split('&');
        for (var i = 0; i < vars.length; i++) {
            var pair = vars[i].split('=');
            params[pair[0]] = decodeURIComponent(pair[1]);
        }
        return params;
    }

document.getElementById("save").addEventListener("click", function() {
    setSelectedSlideId();

    var editorContent = document.getElementById("editor").value; 
    var previewContent = document.getElementById("preview").innerHTML;
    if (!previewContent) {
        displayMessage("No content in the preview to save.", "error");
        return; 
    }

    var userId = sessionStorage.getItem('userId'); 
    var modifiedAt = new Date().toISOString(); 

    var url = window.location.href;
    var params = getUrlParams(url);
    var lessonId = params['lessonId'];
    var courseId = params['courseId'];

    var requestData = {
        slideHtmlFormat: previewContent,
        slideMarkdownFormat: editorContent,
        createdBy: userId,
        createdAt: modifiedAt,
        modifiedBy: userId,
        modifiedAt: modifiedAt
    };

    var apiUrl = `https://localhost:7155/api/LessonSlide/add?courseId=${courseId}&lessonId=${lessonId}`;

    
    $.ajax({
        url: apiUrl,
        type: 'POST',
        contentType: 'application/json',
        data: JSON.stringify(requestData),
        success: function(response) {
            console.log("Response:", response);
            if (response.success) {
                displayMessage("Slide added successfully.", "success");
            } else {
                displayMessage("Failed to add the slide.", "error");
            }
        },
        error: function(xhr, status, error) {
            console.log("Error:", xhr.responseText);
            displayMessage("Error occurred while adding the slide: " + xhr.responseText, "error");
        }
    });
});


document.addEventListener("DOMContentLoaded", function() {
    fetchSlidesForLesson();
});

function fetchSlidesForLesson() {
    var url = window.location.href;
    var params = getUrlParams(url);
    var lessonId = params['lessonId'];
    var courseId = params['courseId'];

    if (!lessonId || !courseId) {
        displayMessage("Lesson ID or Course ID is missing.", "error");
        return;
    }

    var apiUrl = `https://localhost:7155/api/courselesson/GetSlidesToEditById/${courseId}/${lessonId}`;

    $.ajax({
        url: apiUrl,
        type: 'GET',
        success: function(response) {
            console.log("Fetched Slides:", response);
            displaySlides(response.content); // Pass the slides array to the displaySlides function
            displayMessage("Slides fetched successfully.", "success");
        },
        error: function(xhr) {
            console.log("Error fetching slides:", xhr);
            displayMessage("Failed to fetch slides.", "error");
        }
    });
}

function displaySlides(slides) {
    var slidesContainer = document.getElementById("slidesContainer");
    
    // Check if slidesContainer exists
    if (!slidesContainer) {
        console.error("Slides container not found.");
        return;
    }

    slidesContainer.innerHTML = ""; 

    slides.forEach(slide => {
        var slideElement = document.createElement("div");
        slideElement.innerHTML = `<h3>${slide.id}</h3><p>${slide.slideHtmlFormat}</p>`;
        slidesContainer.appendChild(slideElement);
    });
}

    function displayMessage(message, type) {
        var statusMessage = document.getElementById("statusMessage");
        statusMessage.innerHTML = message;
        statusMessage.className = "status-message " + type + "-message";
        statusMessage.style.display = "block";
        setTimeout(function() {
            statusMessage.style.display = "none";
            statusMessage.innerHTML = "";
        }, 3000);
    }

    // Set the slide ID when a slide is selected
    var slideButtons = document.querySelectorAll(".sidebar .btn-primary");
    slideButtons.forEach(button => {
        button.addEventListener("click", function() {
            setSelectedSlideId(); // Ensure `selectedSlideId` is correct
        });
    });

    // Additional event listeners (Compile, New Slide, etc.)
    document.getElementById("compile").addEventListener("click", function() {
        var editorContent = document.getElementById("editor").value;
        var previewContent = editorContent.replace(/\n/g, "<br>");
        document.getElementById("preview").innerHTML = previewContent;
        displayMessage("Compiled successfully!", "success");
    });

    // Function to add a new slide and set the ID
    function addNewSlide() {
        slideCount++; // Increment the slide count
        var slidesContainer = document.getElementById("slidesContainer");
        var newSlideButton = document.createElement("button");
        newSlideButton.className = "btn btn-primary mb-2";
        newSlideButton.textContent = "Slide " + slideCount;
        newSlideButton.setAttribute("data-slide-id", slideCount); // Set a unique ID for each slide
        
        // Slide selection handler
        newSlideButton.addEventListener("click", function() {
            // Deselect other slides
            Array.from(slidesContainer.children).forEach(btn => btn.classList.remove("selected"));
            this.classList.add("selected");
            setSelectedSlideId(); // Update the ID of the selected slide
        });

        slidesContainer.appendChild(newSlideButton); // Add the new slide button to the list
    }
    

    
 	// Function to append a parameter to the current URL
    function redirectToNewUrl(lesson, course) {
	      // Get the current URL as an object
	      let currentUrl = new URL(window.location.href);
	
	      // Define your query parameter key-value pairs
	      let params = {
	        lessonId: lesson, 
	        courseId: course
	      };
	
	      // Add each key-value pair to the URL's search params
	      for (const [key, value] of Object.entries(params)) {
	        currentUrl.searchParams.set(key, value);
	      }
	
	      // Update the address bar URL without reloading the page
	      window.history.replaceState({}, '', currentUrl);
 	}

    // Add event listeners for other controls
    document.getElementById("newSlide").addEventListener("click", addNewSlide);
    document.getElementById("deleteSlide").addEventListener("click", function() {
        var slidesContainer = document.getElementById("slidesContainer");
        var selectedSlide = Array.from(slidesContainer.children).find(button => button.classList.contains("selected"));

        if (!selectedSlide) {
            displayMessage("No slide selected.", "error");
            return;
        }

        slidesContainer.removeChild(selectedSlide); // Delete the selected slide
        slideCount--; // Decrement the slide count
        selectedSlideId = null; // Clear the selected slide ID
        displayMessage("Slide deleted successfully.", "success");
    });

</script>
</body>
</html>
