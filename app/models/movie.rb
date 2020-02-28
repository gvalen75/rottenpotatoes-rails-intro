class Movie < ActiveRecord::Base
    
    def self.find_all_ratings()
        ratings = []
        movies = Movie.all
        movies.each do |movie|
            #puts movie.rating
            if !(ratings.include?(movie.rating))
                ratings.append(movie.rating)
            end
        end
        ratings.sort!
        return ratings
        #ratings.each do |rating|
          # puts rating
       # end
    end
    
    def self.with_ratings(ratings, sort_column)
        return Movie.where("rating IN (?)", ratings).order(sort_column)
      #movies each do |movie|
        #puts movie
      #end
    end
            
        
    
end
