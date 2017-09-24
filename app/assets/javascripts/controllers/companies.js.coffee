Controllers['companies'] = -> class Companies
  show: (action) ->
    url = window.location.href
    activeTab = url.substring(url.indexOf("#") + 1)

    if (activeTab.indexOf("opportunities") != -1)
      opportunityId = activeTab.split("-")[1]
      $(".company-navigation .active").removeClass("active")
      $(".company-navigation .opportunities-tab").addClass("active")

      $(".tab-content .active").removeClass("active")
      $(".tab-content #opportunities").addClass("active")

      $("#collapse-opportunity-"+opportunityId).addClass("in")
      $("html, body").animate({ scrollTop: $("#collapse-opportunity-"+opportunityId).offset().top }, 1000);
