require 'pry'
class ProjectsController < ApplicationController
  before_action :find_user, only: [:new, :edit, :create]

  def index
    if params[:other_users] == "true"
      @projects = Project.other_users_projects(current_user.id)
    else
      @projects = current_user.projects
    end
      respond_to do |f|
          f.html {render :index}
          f.json {render json: @projects}
    end
  end

  def new
    @project = current_user.projects.new
  end

  def show
    @project = Project.find_by_id(params[:id])
    respond_to do |f|
        f.html {render :show}
        f.json {render json: @project}
    end
  end

  def create
    @project = current_user.projects.new(project_params)
     if @project.save
       render json: @project 
     else
       render :new
    end
  end

  def edit
    @project = Project.find(params[:id])
    if !current_user
      redirect_to new_user_session_path, alert: "This project can only be edited by it's author."
    end
  end


  def update
    @project = Project.find(params[:id])
    if !current_user
      redirect_to new_user_session_path, alert: "This project can only be edited by it's author."
    elsif current_user != @project.user
      redirect_to user_project_path, alert: "You must be the author in order to edit a project."
    else
      @project.update(project_params)
        redirect_to user_project_path(current_user, @project)
    end
  end

  def destroy
    @project = Project.find(params[:id])
    if !current_user
      redirect_to new_user_session_path, alert: "You cannot delete this project."
    elsif current_user != @project.user
      redirect_to user_project_path, alert: "You cannot delete this project."
    else
    @project.destroy
    redirect_to user_projects_path
    end
  end

  private

  def find_user
    @user = User.find(params[:user_id])
  end

  def project_params
    params.require(:project).permit(:name, :materials, :length, :image, :theme_attributes, theme_ids: [])
  end
end
