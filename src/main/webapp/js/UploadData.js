// Sample data, replace with your actual data
var slidesData = [
   { header: "Lesson 2: Extend the family model", para: "", body: "", input: "" },
    { header: "Recall the family", para: "What we know", body: "John is the father of Peter\nJohn is also the father of Sara and Linda", input: "", questions: "Old ones" },
    { header: "Extend Our Model for Parent of Peter -- 1", para: "Extend your model: Assume the relation you will use is parent(P1, P2) means that person P1 is the parent of person P2.", body: "", input: "yes" }
];

var currentSlide = 0;

function createSlide(slideData) {
    var slide = document.createElement("div");
    slide.className = "slide";
    var h2 = document.createElement("h2");
    h2.textContent = slideData.header;
    slide.appendChild(h2);
    if (slideData.para) {
        var pPara = document.createElement("p");
        pPara.textContent = slideData.para;
        slide.appendChild(pPara);
    }
    if (slideData.body) {
        var pBody = document.createElement("p");
        pBody.textContent = slideData.body;
        slide.appendChild(pBody);
    }
    if (slideData.input === "yes") {
        var input = document.createElement("input");
        input.setAttribute("type", "text");
        input.setAttribute("placeholder", "Your input");
        slide.appendChild(input);
    }
    return slide;
}

function showSlide(step) {
    currentSlide += step;
    if (currentSlide < 0) currentSlide = 0;
    if (currentSlide >= slidesData.length) currentSlide = slidesData.length - 1;
    var slides = document.getElementsByClassName("slide");
    for (var i = 0; i < slides.length; i++) {
        slides[i].style.display = "none";
    }
    slides[currentSlide].style.display = "block";
}

window.onload = function () {
    var slidesContainer = document.getElementById("slides");
    for (var i = 0; i < slidesData.length; i++) {
        var slide = createSlide(slidesData[i]);
        slidesContainer.appendChild(slide);
    }
    showSlide(0);
};
