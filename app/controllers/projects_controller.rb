class ProjectsController < ApplicationController

  def new
    @project = Project.new
  end

  def show
    @project = Project.find(params[:id])
  end

  def create
    @project = Project.new(project_params)
     if @project.save
       current_user.projects << @project
       redirect_to @project
     else
       render :new
    end
  end


  private

  def project_params
    params.require(:project).permit(:name, :materials, :length, :tag_name, :image)
  end
end
