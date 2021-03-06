class RecipesController < ApplicationController
  before_action :set_recipe, only: [:edit, :update, :show, :like]
  before_action :require_user, except: [:show, :index] #in application_controller
  before_action :require_same_user, only: [:edit, :update]
  
  def index
    #returns all recipes in order of most likes
    #@recipes = Recipe.all.sort_by{|likes| likes.thumbs_up_total}.reverse
    
    #using pagiante gem, 4 recipes per page
    @recipes = Recipe.paginate(page: params[:page], per_page: 4)
    
  end
  
  def show

  end
  
  def new
    @recipe = Recipe.new
  end
  
  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.chef = current_user
    
    if @recipe.save
      flash[:success] = "Your recipe was created successfully!"
      redirect_to recipes_path
    else
      render :new
    end
  end
  
  #edit action
  def edit

  end
  
  #update action
  def update
    if @recipe.update(recipe_params)
      flash[:success] = "Your recipe was updated successfully"
      redirect_to recipes_path
    else
      render :edit
    end
  end
  
  def like
    like = Like.create(like: params[:like], chef: current_user, recipe: @recipe)
    if like.valid?
      flash[:success] = "Your selection was successful"
      redirect_to :back
    else
      flash[:danger] = "Your can only like/dislike a recipe once"
      redirect_to :back
    end
  end
  
  private
    def recipe_params
      params.require(:recipe).permit(:name, :summary, :description, :picture)
    end
  
    def set_recipe
      @recipe = Recipe.find(params[:id])
    end
    
    def require_same_user
      if current_user != @recipe.chef 
        flash[:danger] = "You can only edit your own recipes"
        redirect_to recipes_path
      end
    end
end
