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
    
    def self.with_ratings(ratings)
        return Movie.where("rating IN (?)", ratings.keys)
      #movies each do |movie|
        #puts movie
      #end
    end
            
        
    
end
