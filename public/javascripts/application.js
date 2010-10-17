jQuery(function() {

  function ClearForm() {
    document.new_invitation.invitation_email.value= "";
  }

  var scroll = 448;

  $("a[href='#next']").click(function() {
    $("#timeline .project, .month, #today_bar").animate({ left: "-=" + scroll + "px" });
    return false;
  });

  $("a[href='#prev']").click(function() {
    $("#timeline .project, .month, #today_bar").animate({ left: "+=" + scroll + "px" });
    return false;
  });
  
  $(".relatize").relatizeDate();
  
  $(".datepicker").datepicker({ dateFormat: 'd MM yy' });
  
  $("input.person:checked").each(function(){
    $("label[for=" + $(this).attr("id") + "]").addClass("selected");
  });
  
  $("input.person").hide();
  
  $(".person label.collection_check_boxes").click(function() {
    if ($(this).hasClass("selected"))
    {
      $("#" + $(this).attr("for")).attr("value", "0");
      $(this).removeClass("selected");
    }
    else
    {
      $("#" + $(this).attr("for")).attr("value", "1");
      $(this).addClass("selected");
    }
  });

  $(".projectcontent").click(function() {
    window.location = $(this).find("h2 a").attr("href");
    return false;
  });
});
