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
});
