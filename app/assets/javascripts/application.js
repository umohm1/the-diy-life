// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require bootstrap
//= require_tree .


(function() {
    $(document).on('click', '.otherProjects', function(event) {
        $('.app-container').html("")
        $.ajax({
            type: 'GET',
            dataType: 'json',
            url: '/projects?other_users=true',
            success: function(data) {
                $(".app-container").html(`<div class="container" id="indexcontainer"></div>`)//create div w/ container class, give specific id to reference
                $("#indexcontainer").html(`<div class="col-md-6" id="title">New Projects!</div>`) //.innerHTML new container id
                for(var i = 0; i < data.length; i++) {
                    let name = data[i].name
                    let image = data[i].image
                    let projectHTML = ``
                    projectHTML += `<div class="row">`
                    projectHTML += `<div class="col-md-6">`
                    projectHTML += `<a>${name}</a>`
                    projectHTML += `<img src="${image}" height=100 width=100>`
                    projectHTML += `</div></div>`
                    // projectHTML += `<img src="project.image.url(:medium)" />`
                    $("#indexcontainer").append(projectHTML) //select id of title
                    // $(".app-container").append(image)
                    // let projectImage = ``
                    // $(".show-project").append("<img src="project.image.url(:medium)" />")
                    // $(".app-container").append(`<p>${materials}</p>`)
                }
            }
        })
        event.preventDefault()
    })
})()
