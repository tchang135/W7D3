class UsersController < ApplicationController
    def index 
        @users = User.all 
        render :index
    end

    def create 
        @user = User.new(user_params)
        if @user.save 
            login(@user)
            redirect_to user_url(@user)
        else 
            flash.now[:errors] = @user.errors.full_messages
            render :new
        end
    end
    # params[:user][:username], params[:user][:password]
    def new
        @user = User.new 
        render :new
    end

    def edit
        
    end

    def show

    end

    def update 

    end

    def destroy 

    end


    def user_params 
        params.require(:user).permit(:username, :password)
    end
end

