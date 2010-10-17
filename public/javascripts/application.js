jQuery(function() {

  function ClearForm() {
    document.new_invitation.invitation_email.value= "";
  }

	var organization = $("#organization_nav h1 a").text();
	$("#organization_nav").hover(function() {
		$(this).find("a:first").text("Edit");
	}, function() {
		$(this).find("a:first").text(organization);
	});


  var scroll = 448;
  var maxScroll = $("#months").width() - $("#timeline").width();
  var currentScroll = 0;

  $("a[href='#next']").click(function() {
    if (currentScroll < maxScroll) {
      $("#timeline .project, .month, #today_bar").animate({ left: "-=" + scroll + "px" });
      currentScroll += scroll;
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

  $(document).keydown(function(e) {
    if (e.keyCode == 37) {
      $("a[href='#prev']").click();
      return false;
    }
    if (e.keyCode == 39) {
      $("a[href='#next']").click();
      return false;
    }
  });


  if ($("#inner_timeline").length == 1) {
    var top = $("#inner_timeline").height() / 2 - $("#outer_timeline a.nav img").height() / 2
    $("#outer_timeline a.nav").css({ top: top + "px" });
  }
  

  $(".relatize").relatizeDate();
  
  $(".datepicker").datepicker({ dateFormat: 'd MM yy' });
  
  $("input.person:checked").each(function(){
    $("label[for=" + $(this).attr("id") + "]").addClass("selected");
  });
  
  $("input.person").hide();
  
  $(".person label.collection_check_boxes").click(function() {
    if ($("#" + $(this).attr("for")).attr("checked") == true)
    {
      $(this).removeClass("selected");
    }
    else
    {
      $(this).addClass("selected");
    }
  });
  
  $("#project_active").hide();
  
  $("label[for=project_active].toggle").click(function() {
    if ($("#project_active[type=checkbox]").attr("checked") == true)
    {
      $(this).removeClass("green").addClass("red");
      $(this).text("On hold");
    }
    else
    {
      $(this).addClass("green").removeClass("red");
      $(this).text("Working");
    }
  });
  
  $("#post-receive").click(function() {
    $(this).focus().select();
  });

  $(".projectcontent, #timeline .project").click(function() {
    window.location = $(this).find("a").attr("href");
    return false;
  });
  

  $("#onav").hide(); 

  $("#organization_nav #control").click(function () {
    $(this).next("#onav").slideToggle("fast");
  });
 
  $("body").click(function () {
    $("#onav").hide();
  });

  $("#organization_nav #control").click(function(e) {
    e.stopPropagation();
  });


  $("#timeline .project").hover(function() {
    $(this).css({ overflow: "visible" });
  }, function() {
    $(this).css({ overflow: "hidden" });
  });
  
});
