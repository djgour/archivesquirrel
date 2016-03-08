class ItemsController < ApplicationController

  before_action :require_project_member
  
  def show
    @item = Item.find(params[:id])
    @project = @item.project
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
  
  def edit
    @item = Item.find(params[:id])
    @project = @item.project
  end
  
  def update
    @item = Item.find(params[:id])
    @project = @item.project
    if @item.update(item_params)
      redirect_to project_item_path(@project, @item), notice: "Changes saved."
    else
      render :edit
    end
  end
  
  def destroy
    @item = Item.find(params[:id])
    @project = @item.project
    if @item.deletable_by?(current_user)
      @item.destroy
      redirect_to project_path(@project)
    else
      redirect_to :back, notice: "You are not authorized to do this."
    end
  end
  
  private
  
  def item_params
    params.require(:item).permit(:name, :description, :level)
  end

end
