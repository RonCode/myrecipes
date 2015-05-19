class PagesController < ApplicationController 
  
  def home
    #redirect to recipe listing if logged in
    redirect_to recipes_path if logged_in?
  end
end
