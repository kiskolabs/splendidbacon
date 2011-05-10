function ClearForm() {
  document.new_invitation.invitation_email.value= "";
}

function countdown(iso8601) {
  date = $.timeago.parse(iso8601)
  days = Math.round((date.getTime() - new Date().getTime()) / 1000 / 60 / 60 / 24);
  var suffix;
  
  if (days < -1) {
    days = -days;
    suffix = " days late";
  }
  else if (days == -1) {
    days = -days;
    suffix = " day late";
  }
  else if (days > 1 || days == 0) {
    suffix = " days";
  }
  else if (days == 1) {
    suffix = " day";
  };
  
  return (days + suffix);
}


jQuery(function() {

	var organization = $("#organization_nav h1 a").text();
	$("#organization_nav").hover(function() {
		$(this).find("a:first").text("Edit");
	}, function() {
		$(this).find("a:first").text(organization);
	});

  // Timeline

  var scroll = 448;
  var maxScroll = $("#months").width() - $("#timeline").width() - 870;
  var currentScroll = 0;

  function updateTimelineNavigation() {
    if($("#timeline").length > 0) {
      if (currentScroll < maxScroll) {
        $("a[href='#next']").addClass("active");
      } else {
        $("a[href='#next']").removeClass("active");
      }

      if (currentScroll >= scroll) {
        $("a[href='#prev']").addClass("active");
      } else {
        $("a[href='#prev']").removeClass("active");
      }
    }
  };
  updateTimelineNavigation();

  $("a[href='#next']").click(function() {
    if (currentScroll < maxScroll) {
      $("#timeline .project, .month, #today_bar").animate({ left: "-=" + scroll + "px" });
      currentScroll += scroll;
      updateTimelineNavigation();
    }
    return false;
  });

  $("a[href='#prev']").click(function() {
    if (currentScroll >= scroll) {
      $("#timeline .project, .month, #today_bar").animate({ left: "+=" + scroll + "px" });
      currentScroll -= scroll;
      updateTimelineNavigation();
    }
    return false;
  });

  $(document).keydown(function(e) {
    if (e.keyCode == 37) {
      $("a[href='#prev']").click();
    }
    if (e.keyCode == 39) {
      $("a[href='#next']").click();
    }
  });

  if ($("#inner_timeline").length == 1) {
    var top = $("#inner_timeline").height() / 2 - $("#outer_timeline a.nav img").height() / 2
    $("#outer_timeline a.nav").css({ top: top + "px" });
  }

  // Filters
  var ProjectToggle = function(elements) {
    var self = this;
    self.elements = $(elements);
    self.elements.click(function() {
      $(this).addClass("selected").siblings().removeClass("selected");
      applyProjectFilters();
    });
    return self;
  };
  ProjectToggle.prototype.filterType = function() {
    var element = this.elements.first();
    return element.data("type");
  };
  ProjectToggle.prototype.filterValue = function() {
    var element = this.elements.filter(".selected");
    return element.data("value");
  };

  var ProjectCustomDropdown = function(element) {
    var self = this;
    self.element = $(element);
    self.options = self.element.find(".options");
    self.current = element.find(".current");
    /* self.current.css("width", _.max(_.map(self.options.children, function(option) { return $(option).width(); }))); */

    self.options.hide();
    self.element.click(function(e) {
      if($("body > .options").length == 0) {
        var select = self.options.clone();
        select.css({"display": "block", "position": "absolute", "left": e.pageX + "px", "top": e.pageY + "px"});
        var hide = function() {
          select.remove();
          $(this).unbind("click", hide);
        }
        select.click(function(e) {
          var selection = $(e.target);
          if(selection.data("value")) {
            self.current.text(selection.text());
            self.options.children().removeClass("selected");
            self.options.children("[data-value=" + selection.data("value") + "]").addClass("selected");
            applyProjectFilters();
            hide();
          }
          e.stopPropagation();
        });
        $("body").append(select).click(hide);
      }
      e.stopPropagation();
    });
    return self;
  };
  ProjectCustomDropdown.prototype.filterType = function() {
    return this.element.data("type");
  };
  ProjectCustomDropdown.prototype.filterValue = function() {
    var element = this.options.find(".selected");
    return element.data("value");
  };

  var projectFilters = [];
  projectFilters.push(new ProjectToggle($(".project_status a")));
  projectFilters.push(new ProjectCustomDropdown($(".project_mate")));

  applyProjectFilters();

  function applyProjectFilters() {
    var values = [];
    _.each(projectFilters, function(filter) {
      values.push([filter.filterType(), filter.filterValue()]);
    });

    var timelineProjects = $(".filterable_project").removeClass("dimmed");

    values = _.reject(values, function(val) { return val[1] == "all"; });
    if(_.isEmpty(values)) {
      timelineProjects.fadeTo("fast", 1.0);
    } else {
      _.each(values, function(val) {
        var type = val[0];
        var value = val[1];

        if(type == "user") {
          timelineProjects.filter(function() {
            return !_.include($(this).data("users"), parseInt(value));
          }).fadeTo("fast", 0.1).addClass("dimmed");
        } else if(type == "project_status") {
          $(".filterable_project[data-state!=" + value + "]").fadeTo("fast", 0.1).addClass("dimmed");
        }
      });
      timelineProjects.filter(function() { return !$(this).hasClass("dimmed")}).fadeTo("fast", 1.0);
    }
  }
  
  // Project form
  // $(".relatize").relatizeDate();
  $.timeago.settings.allowFuture = true;
  $("abbr.timeago").timeago();
  
  $.timeago.settings.strings = {
    prefixAgo: null,
    prefixFromNow: null,
    suffixAgo: null,
    suffixFromNow: null,
    seconds: "Today",
    minute: "Today",
    minutes: "Today",
    hour: "Today",
    hours: "Today",
    day: "Yesterday",
    days: "%d days ago",
    month: "%d days ago",
    months: "%d months ago",
    year: "%d months ago",
    years: "%d years ago",
    numbers: []
  };
  
  $("abbr.date_to_words").timeago();
  
  $("abbr.countdown").text(function() {
    var text = countdown($(this).attr("title"));
    $(this).attr("title", text);
    return text;
  });
  
  if ( $('.datepicker').length ) {
    $(".datepicker").datepicker({ dateFormat: 'd MM yy' });
  };
  
  $(".project_state label.collection_radio").click(function() {
    $(this).addClass("selected").siblings().removeClass("selected");
  });

  $(".project_state input.radio").hide().filter(":checked").each(function() {
    $("label[for=" + this.id + "]").click();
  });
  
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
  
  $(".copy_url").click(function() {
    $(this).focus().select();
  });

  $(".projectcontent, #timeline .project").click(function() {
    window.location = $(this).find("a").attr("href");
    return false;
  });

  $("#onav").hide(); 

  $("#organization_nav #control").click(function (e) {
    $(this).next("#onav").slideToggle("fast");
    e.stopPropagation();
  });
 
  $("body").click(function () {
    $("#onav").hide();
  });

  $("#timeline .project").hover(function() {
    $(this).css({ overflow: "visible" });
  }, function() {
    $(this).css({ overflow: "hidden" });
  });
  
  if ($.browser.webkit) {
      $('input').attr('autocomplete', 'off');
  }
  
  if ( $('meta[name="broadcast-title"]').length ) {
    $.jGrowl($('meta[name="broadcast-text"]').attr("content"), {
      sticky: true, 
      header: $('meta[name="broadcast-title"]').attr("content"),
      close: function() {
        $.ajax({
          url: $('meta[name="broadcast-url"]').attr("content"),
          type: 'POST'
        });
      }
    })
  }
  
  if ( $('.magic_datepicker').length ) {
    $(".magic_datepicker").datepicker({
      showOn: "button",
      buttonText: "\\",
      onSelect: function(dateText, inst) {
        $("#broadcast_expiry_1i").val(inst.selectedYear);
        $("#broadcast_expiry_2i").val(inst.selectedMonth + 1);
        $("#broadcast_expiry_3i").val(inst.selectedDay);
      }
    });
  };
  
  $("#demo a").click(function() {
    $("#spinner").show();
  });
  
  $("#more_statuses_link").css("display", "block");
  
  $("span.text").autolink();
});
