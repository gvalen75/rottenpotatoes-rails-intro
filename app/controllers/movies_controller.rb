class MoviesController < ApplicationController

  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    #@movies = Movie.all
    #puts params[:ratings]
    #@temp = params[:sort_by]
    #if params[:sort_by] == session[:sort_by]
      #@movies = Movie.order(session[:sort_by])
    #elsif session[:sort_by] == nil
      #session[:sort_by] = params[:sort_by]
    #else
      #session[:sort_by].reverse_merge!(params[:sort_by])
     # @temp each do |key,value|
        #new_hash = Hash.new
        #new_hash[key] = value
        #if !(session[:sort_by].has_value?(value))
          #session[:sort_by][key] = value
        #end
      #end
    #end
    #if session[:sort_by] == ''
      #session[:sort_by] = params[:sort_by]
    #end
    #puts params[:sort_by]
    #puts session[:sort_by]
    #@movies = Movie.order(params[:sort_by])
    @sort_column = params[:sort_by] || session[:sort_by]
    @all_ratings = Movie.find_all_ratings()
    @selected_ratings = (params[:ratings].present? && params[:ratings].is_a?(Hash) ? params[:ratings].keys : (session[:ratings]) || @all_ratings)
    @movies = Movie.with_ratings(@selected_ratings, @sort_column)
    
    if (params[:sort_by] != session[:sort_by]) || (params[:ratings] != session[:ratings])
      session[:sort_by] = @sort_column
      session[:ratings] = @selected_ratings
    end
    
    if (params[:sort_by].nil? && !(session[:sort_by].nil?)) || (params[:ratings].nil? && !(session[:ratings].nil?))
      flash.keep
      redirect_to movies_path(sort_by: @sort_column, ratings: @selected_ratings)
      #redirect_to movies_path(sort: @sort, ratings: @ratings)
    end
    
    #if !(params[:ratings] == nil)
      #params[:ratings].hash each do |rating|
        #puts rating
      #end
    #end
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end
  
  helper_method :sort_column_check
  def sort_column_check(column)
    "hilite" if @sort_column == column
  end
end
