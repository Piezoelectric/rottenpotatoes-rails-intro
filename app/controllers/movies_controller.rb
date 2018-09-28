class MoviesController < ApplicationController

  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index()
    # filter by rating -- init @all_ratings, get params[:ratings] from view
    @all_ratings = Movie.uniq.pluck(:rating)
    if params[:ratings]
      selectedRatings = params[:ratings].keys
      session[:ratings] = params[:ratings] #have session use new user-inpt value
      printf("filter: " + @ratings.to_s + "\n")
    else #no ratings input
      selectedRatings = session[:ratings].keys
      printf("no filter\n")
    end
    
    # sort movies by columns -- set @movies for data, @hiliteCol for styling col header,
    # get params[:sortBy] from view
    if ["title", "release_date"].include? params[:sortBy]
      sortCriteria = params[:sortBy]
      print("sort on " + params[:sortBy].to_s + "\n")
    else
      printf("no sort\n")
      sortCriteria = ""
    end
    
    @hiliteCol = sortCriteria
    @ratings = selectedRatings
    @movies = Movie.where({rating: selectedRatings}).order(sortCriteria)
    
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

end
