$(function () {
  $("#year").text(new Date().getFullYear());

  $(".navbar-nav .nav-link, .navbar-brand").on("click", function () {
    $(".navbar-collapse").collapse("hide");
  });

  $("#careerForm").on("submit", function (event) {
    event.preventDefault();
    $("#formMessage").removeClass("d-none").hide().fadeIn(250);
  });

  $(window).on("scroll", function () {
    if ($(window).scrollTop() > 420) {
      $("#backToTop").css("display", "flex");
    } else {
      $("#backToTop").hide();
    }
  });

  $("#backToTop").on("click", function () {
    $("html, body").animate({ scrollTop: 0 }, 450);
  });
});
