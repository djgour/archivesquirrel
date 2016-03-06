class ItemsController < ApplicationController

  before_action :require_project_member
  
  def show
    @item = Item.find(params[:id])
  end
  
  def new
    @project = Project.find(params[:project_id])
    @item = @project.items.new
  end
  
  def create
    @project = Project.find_by(id: params[:project])
    unless @project && @project.project_member?(current_user)
      redirect_to root, notice: "You are not authorized 
                                 to take this action."
      return
    end
    @item = @project.items.new(item_params)
    @item.project = @project
    @item.user = current_user
    if @item.save
      redirect_to project_item_path(@project, @item),
                   notice: "Item successfully added!"
    else
      render :new
    end
  end
  
  private
  
  def item_params
    params.require(:item).permit(:name, :description, :level)
  end

end
