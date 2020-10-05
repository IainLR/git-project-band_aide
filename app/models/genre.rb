class Genre < ApplicationRecord
    has_many :musician_genres
    has_many :musicians, through: :musician_genres

    def self.most_popular
        self.all.max_by {|genre| genre.musicians.count}
    end

    def self.least_popular
        self.all.min_by {|genre| genre.musicians.count}
    end

    def self.most_popular_by_location(location)
        @musician_arr = Musician.find_by_location(location)
        @genres = @musician_arr.map {|musician| musician.genres}.flatten
        @gen_names = @genres.map{|g| g.name}
        freq = @gen_names.inject(Hash.new(0)) { |h,v| h[v] += 1; h }
        @popular = @gen_names.max_by { |v| freq[v] }
        @popular
    end

    def self.least_popular_by_location(location)
        @musician_arr = Musician.find_by_location(location)
        @genres = @musician_arr.map {|musician| musician.genres}.flatten
        @gen_names = @genres.map{|g| g.name}
        freq = @gen_names.inject(Hash.new(0)) { |h,v| h[v] += 1; h }
        @popular = @gen_names.min_by { |v| freq[v] }
        @popular
    end


end
