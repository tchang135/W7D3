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
        @user = User.find_by(id: params[:id])
        if @user
            render :edit
        else
            flash[:errors] = @user.errors.full_messages
            redirect_to goal_url(@user)
        end
    end

    def show
        @user = User.find_by(id: params[:id])
        if @user
            render :show
        else
            flash[:errors] = @user.errors.full_messages
            redirect_to goals_url
        end 
    end

    def update 

    end

    def destroy 

    end


    def user_params 
        params.require(:user).permit(:username, :password)
    end
end

