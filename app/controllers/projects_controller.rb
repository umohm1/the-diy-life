class ProjectsController < ApplicationController
  before_action :find_user, only: [:new, :edit]

  def index
    @projects = current_user.projects
  end

  def new
    @project = current_user.projects.new
  end

  def show
    @project = Project.find(params[:id])
  end

  def create
    # @project = Project.new(project_params)
    @project = current_user.projects.new(project_params)
     if @project.save
       redirect_to user_project_path(current_user, @project)
     else
       render :new
    end
  end

  def edit
    @project = Project.find(params[:id])
  end


  def update
    @project = Project.find(params[:id])
      if @project.update(project_params)
        redirect_to user_project_path(current_user, @project)
      else
      render :edit
     end
  end

  def destroy
    @project = Project.find(params[:id])
    @project.destroy
    redirect_to user_projects_path
  end

  private

  def find_user
    @user = User.find(params[:user_id])
  end

  def project_params
    params.require(:project).permit(:name, :materials, :length, :image, :all_themes, theme_ids: [])
  end
end
