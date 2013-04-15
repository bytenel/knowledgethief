# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
  $ ->
    $(".userTabLink_path").click ->
       $("#userPaths").show("slow")
       $("#userResources").hide()

  $ ->
    $(".userTabLink_resource").click ->
       $("#userResources").show("slow")
       $("#userPaths").hide()

  $ ->
    $("#resumeEdit").click ->
    	$("#editbutton").show("slow")
    	$("#editbutton2").show("slow")
    	$("#editbutton3").show("slow")
    	$("#editbutton4").show("slow")
    	$("#editbutton5").show("slow")