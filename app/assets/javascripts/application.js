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
                $(".app-container").html(`<div class="container" id="indexcontainer"></div>`)
                $("#indexcontainer").html(`<h1><div class="col-md-15" id="title">New Projects!</div></h1>`)
                for(var i = 0; i < data.length; i++) {
                    let name = data[i].name
                    let image = data[i].image
                    // let user = '/users/${user}'
                    let projectHTML = ``
                    projectHTML += `<div class="row">`
                    projectHTML += `<div class="col-md-6">`
                    projectHTML += `<a href="/users/${data[i].user.id}/projects/${data[i].id}">${name}</a>`
                    projectHTML += `<img src="${image}" height=500 width=500>`
                    projectHTML += `</div></div><br>`
                    $("#indexcontainer").append(projectHTML)
                    $("#title").css ({
                        'text-align': 'center'
                    })
                    // $("<a>", {        //adding <a> tag stops preventDefault() from working
                    //     href:
                    // users/user_id/projects/id    //seen as literal string but is an integer. How to get the integer, no to_i can be used
                    // "users/user[id]/projects/projects[id] ">
                    // '/users/${user.id}/projects/${projects.id}'
                    // users/${user_id}/projects/${projects_id}
                    // "/users/" + users["id"] + "projects" + projects["id"]
                    // })

                    // $( "a" ).click(function(e) {
                    //     e.preventDefault();
                    //     // alert( "event occured" );

                    //     $.ajax({
                    //         type: 'GET',
                    //         dataType: 'json',
                    //         url: '/users/user_id/projects/id',
                    //         success: function(data) {
                    //         }                            //doesn't work
                    // });
                }
            }
        })
        event.preventDefault()
    })
})()
