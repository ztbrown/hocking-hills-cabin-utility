#= require jquery
#= require_tree .

getResults= (success) ->
    $.ajax({
        type: "GET",
        url: "/results",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: success
    })

describe "LoadingDiv", ->
  it "shows the loading div on ajaxStart", ->
    spyOn $, "ajax"
    getResults()
    expect $('#loadingDiv').is('visible')

  it "hides the loading div on ajaxEnd", ->
  	spyOn($, "ajax").andCallFake((options) -> options.success())
  	callback = jasmine.createSpy()
  	getResults(callback)
	expect $('#loadingDiv').is('visible')  	
  	



