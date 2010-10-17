jQuery(function() {

  function ClearForm() {
    document.new_invitation.invitation_email.value= "";
  }


  var scroll = 448;
  var maxScroll = $("#months").width() - $("#timeline").width();
  var currentScroll = 0;

  $("a[href='#next']").click(function() {
    if (currentScroll < maxScroll) {
      $("#timeline .project, .month, #today_bar").animate({ left: "-=" + scroll + "px" });
      currentScroll += scroll;
      console.log(currentScroll);
    }
    return false;
  });

  $("a[href='#prev']").click(function() {
    if (currentScroll >= scroll) {
      $("#timeline .project, .month, #today_bar").animate({ left: "+=" + scroll + "px" });
      currentScroll -= scroll;
    }
    return false;
  });
  

  $(".relatize").relatizeDate();
  
  $(".datepicker").datepicker({ dateFormat: 'd MM yy' });

  $(".projectcontent").click(function() {
    window.location = $(this).find("h2 a").attr("href");
    return false;
  });
});
