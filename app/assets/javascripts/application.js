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
//= require bootstrap
//= require_tree .


(function(){
    bindClickListeners()
}())

// Index Action

function bindClickListeners() {
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
                    let projectHTML = `
                     <div class="row">
                     <div class="col-md-6">
                     <a class="show-link" href="/users/${data[i].user.id}/projects/${data[i].id}"} data-project=${data[i].id} data-user=${data[i].user.id}>${name}</a>
                     <img src="${image}" height=505 width=505>
                     </div></div><br>
                     `
                    $("#indexcontainer").append(projectHTML)
                    $("#title").css ({
                        'text-align': 'center'
                    })
                }
            }
        })
        event.preventDefault()
    })


// Show Action

    $(document).on('click', '.show-link', function(event) {
      var projectId = $(this).data('project');
      var userId = $(this).data('user');
      $(".app-container").html("")
      $.ajax({
        type: 'GET',
        dataType: 'json',
        url: `/users/${userId}/projects/${projectId}`,
        success: function(data) {
            let projectHTML = `
             <div class="show-project">
             <img src="${data.image}" height=500 width=500><br></br>
             <p><label>Name:</label></p>
             <p>${data.name}</p>
             <p><label>Materials:</label></p>
             <p>${data.materials}</p>
             <p><label>Length:</label></p>
             <p>${data.length}</p>
             <p><label>Themes:</label></p>
             <p>${data.themes[0].name}</p>
             Created by: ${data.user.name}
             </div>
             `
            $(".app-container").append(projectHTML)
        }
    })
      event.preventDefault()
    })


// POST Request

$(document).on('submit', '.new_project', function(e) {
    var userId = $(this).data('user');
    $(".app-container").html("")
    $.ajax({
      type: 'POST',
      url: `/users/${userId}/projects/`,
      data: $(this).serialize(), //problem!
      success: function(data) {
          let newProject = new Project(data)
          let html = newProject.renderShow()
          $('.app-container').append(html)
        }
    })
  e.preventDefault()
  })



JS Model Object

    function Project(project) {
        this.id = project.id;
        this.image = project.image;
        this.name = project.name;
        this.materials = project.materials;
        this.length = project.length;
        this.user = project.user;
        this.themes = project.themes;
        this.created_at = project.created_at
    }

    Project.prototype.renderDate = function() {
        var today = new Date(this.created_at);
        var dd = today.getDate();
        var mm = today.getMonth()+1;
        var yyyy = today.getFullYear();

        if(dd<10) {
            dd = '0'+dd
        }

        if(mm<10) {
            mm = '0'+mm
        }

        var projectDate = mm + '/' + dd + '/' + yyyy;
        return projectDate;
    }

    Project.prototype.renderImage = function() {
        return `<img src="${this.image}" height=400 width=400><br></br>`
    }

    Project.prototype.renderShow = function() {
        var projectId = this.id;
          return `
           <div class="show-project">
           ${this.renderImage()}
           <p><label>Name:</label></p>
           <p>${this.name}</p>
           <p><label>Material:</label></p>
           <p>${this.materials}</p>
           <p><label>Length:</label></p>
           <p>${this.length}</p>
           <p><label>Themes:</label></p>
           <p>${this.themes[0].name}</p>
           Created by: ${this.user.name} on ${this.renderDate()}
           <a href="/users/${this.user.id}/projects/${projectId}/edit"><br></br>Edit Project</a>
           <a href="/users/${this.user.id}/projects/${projectId}/" data-method='delete'><br></br>Delete Project</a>
           </div>
          `
        }
