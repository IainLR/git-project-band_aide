class SessionsController < ApplicationController

    def new
        @musician = Musician.new
        
    end
 
    def create
    
        @musician = Musician.find_by(username: params[:musician][:username])
        if @musician && @musician.authenticate(params[:musician][:password])
            session[:id] = @musician.id
            redirect_to '/musicians'
        else 
            flash[:error] = "incorrect username or password"
            redirect_to '/login'
        end
        #byebug
    end

    def destroy
        session.clear
        redirect_to '/login'
    end

    # def follow(musician)
    #     Relationship.create(follower_id: session[:id], followed_id: musician.id )
    #     #Relationship.create(follower_id: session[:id], followed_id: Musician.all[3].id)
    # end 

end
