class Musician < ApplicationRecord
    has_many :active_relationships, class_name: "Relationship", foreign_key: :follower_id, dependent: :destroy
    has_many :followeds, through: :active_relationships, source: :followed
    has_many :passive_relationships, class_name: "Relationship", foreign_key: :followed_id, dependent: :destroy
    has_many :followers, through: :passive_relationships, source: :follower

    has_many :musician_genres 
    has_many :genres, through: :musician_genres

    has_many :commenters, foreign_key: :commenter_id , class_name: "Comment"
    has_many :commentee, through: :commenters
    has_many :commentee, foreign_key: :commentee_id, class_name: "Comment"
    has_many :commenters, through: :commentee

    has_secure_password

    

    def self.most_followers
        @most_popular = self.all.max_by {|musician| musician.followers.count}
      
    end 

    def self.least_followers
        @least_popular = self.all.min_by {|musician| musician.followers.count}
    
    end 

    def self.most_active_follower
        @most_active = self.all.max_by {|musician| musician.followeds.count}
    end 

    def self.least_active_follower
        @least_active = self.all.min_by {|musician| musician.followeds.count}
    end 

    def self.instrument_arr
        @instruments = self.all.map {|musician| musician.instrument}
    end

    def self.most_popular_instrument 
        @instruments = self.instrument_arr
        freq = @instruments.inject(Hash.new(0)) { |h,v| h[v] += 1; h }
        @mp_instrument = @instruments.max_by { |v| freq[v] }
        @mp_instrument
    end

    def self.location_arr
        @locations = self.all.map {|musician| musician.location}
    end

    def self.most_popular_location 
        @locations = self.location_arr
        freq = @locations.inject(Hash.new(0)) { |h,v| h[v] += 1; h }
        @mp_location = @locations.max_by { |v| freq[v] }
        @mp_location
    end

    def self.find_by_intrument(instrument)
        @specific_muscicians = self.all.select {|musician| musician.instrument == instrument}
    end

    def self.find_by_location(location)
        @specific_muscicians = self.all.select {|musician| musician.location == location}
    end

    def self.most_versitile
        self.all.max_by {|musician| musician.genres.count}
    end

    def self.most_recent_accounts
        @most_recent = self.all.order('created_at DESC').limit(5)
    end 

    def self.popular_instrument_by_location(location)
        @musicians = self.find_by_location(location)
        @instruments = @musicians.map {|musician| musician.instrument}
        freq = @instruments.inject(Hash.new(0)) { |h,v| h[v] += 1; h }
        @pop_inst = @instruments.max_by { |v| freq[v] }
        @pop_inst
    end

    def self.least_popular_instrument_by_location(location)
        @musicians = self.find_by_location(location)
        @instruments = @musicians.map {|musician| musician.instrument}
        freq = @instruments.inject(Hash.new(0)) { |h,v| h[v] += 1; h }
        @pop_inst = @instruments.min_by { |v| freq[v] }
        @pop_inst
    end

end
