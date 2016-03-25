class ItemsController < ApplicationController

  # This before filter also defines @project for the use of each method.
  before_action :require_project_member
  
  def show
    @item = Item.find(params[:id])
  end
  
  def new
    @item = @project.items.new
  end
  
  def new_child
    @parent = Item.find(params[:id])
    @item = @project.items.new
    render :new
  end
  
  def create
    
    # This looks very messy and should be cleaned up, but right now I just
    # want my tests to pass.
    
    @item = @project.items.new(item_params)
    @item.project = @project
    @item.user = current_user
    @parent = @project.items.find_by(id: params[:parent]) if params[:parent]
    if @item.save
      if @parent
        ItemRelationship.create!(parent: @parent, child: @item) 
      else
        TopLevelRelationship.create!(project: @project, 
                                     item: @item, 
                                     relationship: params[:top_level])
      end
      redirect_to project_item_path(@project, @item),
                 notice: "Item successfully added!"
    else
      render :new
    end 
  end
  
  def edit
    @item = Item.find(params[:id])
  end
  
  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      redirect_to project_item_path(@project, @item), notice: "Changes saved."
    else
      render :edit
    end
  end
  
  def destroy
    @item = Item.find(params[:id])
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
