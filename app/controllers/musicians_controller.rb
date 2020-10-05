class MusiciansController < ApplicationController
    before_action :authenticated?, only:[:index, :show]
    #before_action :edit_authentication, only:[:edit]


    def index
        @musicians = Musician.all
        #byebug
        @current_user = Musician.find_by(id: session[:id])
        @local_musicians = Musician.all.select {|musician| musician.location == @current_user.location}
    end 

    def analytics
        @current_user = Musician.find_by(id: session[:id])
        #byebug
        @current_location = @current_user.location
        if defined?(@@location_test)
            @current_location = @@location_test
        else 
            @current_location = @current_user.location
        end
        #byebug
        @locations = [ 'Houston, TX', 'Austin, TX', 'San Antonio, TX', 'Waco, TX', 'Lubbock, TX']
        @instruments = ["Guitar", "Bass", "Drums", "Trumpet", "Multi-instrumentalist"]
        @most_popular = Musician.most_followers
        @least_pop = Musician.least_followers
        @most_active = Musician.most_active_follower
        @least_active = Musician.least_active_follower
        @popular_instrument = Musician.most_popular_instrument
        @pop_location = Musician.most_popular_location
        @versitile = Musician.most_versitile
        @most_recent = Musician.most_recent_accounts
        @pop_inst_location = Musician.popular_instrument_by_location(@current_location)
        @musicians_by_location = Musician.find_by_location(@current_location)
        @genre_by_loc = Genre.most_popular_by_location(@current_location)
        @least_genre_by_loc = Genre.least_popular_by_location(@current_location)
        
    end 

    def spec_analytics
        #byebug
        @location = params[:location]
        @@location_test = params[:location]
        redirect_to analytics_path
    end

    def new
        @musician = Musician.new
        @genres = Genre.all
        @locations = [ 'Houston, TX', 'Austin, TX', 'San Antonio, TX', 'Waco, TX', 'Lubbock, TX']
        @instruments = ["Guitar", "Bass", "Drums", "Trumpet", "Multi-instrumentalist"]
        #byebug
    end 

    def show
        @musician = Musician.find(params[:id])
        @current_user = Musician.find_by(id: session[:id])
        @bool_check = @musician.followers.include?(@current_user)
        @comments = Comment.where(commentee_id: @musician.id)
    end

    def create
        
        @musician = Musician.new(mus_params)
        if params[:musician][:password] != params[:musician][:confirm_password]
            flash[:error] = "Passwords did not mach, please try again"
            redirect_to '/musicians/new'
        else
        #byebug
            Genre.find(params[:musician][:genres]).each do |genre|
                MusicianGenre.create(musician_id: @musician.id, genre_id: genre.id)
            end
            @musician.save
            redirect_to '/login'
        end

    end 

    def edit
        #@musician = Musician.find(params[:id])
        @musician = Musician.find(session[:id])
        @genres = Genre.all
        @locations = [ 'Houston, TX', 'Austin, TX', 'San Antonio, TX', 'Waco, TX', 'Lubbock, TX']
        @instruments = ["Guitar", "Bass", "Drums", "Trumpet", "Vocalist", "piano", "synth", "keys", "Multi-instrumentalist"]
    end 

    def update
        @musician = Musician.find(params[:id])
        @musician.assign_attributes(mus_params)
        #Genre.find(params[:musician][:genres]).each {|genre| MusicianGenre.create(musician_id: @musician.id, genre_id: genre.id)}
        @musician.genres.clear
        Genre.find(params[:musician][:genres]).each do |genre|
            MusicianGenre.create(musician_id: @musician.id, genre_id: genre.id)
        end
        #byebug
        @musician.save
        redirect_to musician_path(@musician)
    end 

    def follow
        @musician = Musician.find(params[:id])
        # if @musician.followers.include?(Relationship.find_by(follower_id: session[:id]))
        #     flash[:errors]
        #     redirect_to musician_path(@musician)
        # else
        Relationship.create(follower_id: session[:id], followed_id: @musician.id )
        redirect_to musician_path(@musician)
    end 

    def unfollow
        @musician = Musician.find(params[:id])
        @current_user = Musician.find_by(id: session[:id])
        #byebug
        @follow = Relationship.find_by(follower_id: @current_user.id, followed_id: @musician.id)
        @follow.destroy
        redirect_to musician_path(@musician)
    end

    def authenticated?
        if session[:id] != nil
            @musician = Musician.find(session[:id])
        else
            redirect_to '/login'
        end
    end

    # def edit_authentication
    #     @musician = Musician.find(session[:id])
    #     redirect_to "/musicians/#{@musician.id}/edit"
    #     # if session[:id] != @musician.id
    #     #     redirect_to "/musicians/#{@musician.id}/edit"
    #     # end
    # end


    private 

    def mus_params
        params.require(:musician).permit(:name, :location, :instrument, :bio, :years_experience, :username, :password, :img_url)
    end 
end
