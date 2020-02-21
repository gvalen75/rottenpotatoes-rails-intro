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
        ratings.each do |rating|
           puts rating
        end
    end
            
        
    
end
