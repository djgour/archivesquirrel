class ProjectsController < ApplicationController
  
  before_action :require_login
  
  def new
    @project = Project.new
  end
  
  def create
    @project = Project.new(project_params)
    @project.user_id = current_user.id
    if @project.save
      redirect_to @project, notice: "Project successfully created!"
    else
      render :new
    end
  end
  
  def show
    @project = Project.find(params[:id])
  end
  
  private
  
  def project_params
    params.require(:project).permit(:name, :description)
  end
  
end
