class RecipesController < ApplicationController
  
  def index
    #returns all recipes in order of most likes
    #@recipes = Recipe.all.sort_by{|likes| likes.thumbs_up_total}.reverse
    
    #using pagiante gem
    @recipes = Recipe.paginate(page: params[:page], per_page: 4)
    
  end
  
  def show
    @recipe = Recipe.find(params[:id])
  end
  
  def new
    @recipe = Recipe.new
  end
  
  def create
    @recipe = Recipe.new(recipe_params)
    #hardcode a chef for now
    @recipe.chef = Chef.find(1)
    
    if @recipe.save
      flash[:success] = "Your recipe was created successfully!"
      redirect_to recipes_path
    else
      render :new
    end
  end
  
  #edit action
  def edit
    @recipe = Recipe.find(params[:id])
  end
  
  #update action
  def update
    @recipe = Recipe.find(params[:id])
    if @recipe.update(recipe_params)
      flash[:success] = "Your recipe was updated successfully"
      redirect_to recipe_path(@recipe)
    else
      render :edit
    end
  end
  
  def like
    @recipe = Recipe.find(params[:id])
    like = Like.create(like: params[:like], chef: Chef.first, recipe: @recipe)
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
  
end
