class SessionsController < ApplicationController

    def create
        user = User.find_by(username: params[:username])
        if user
          session[:user_id] = user.id
          render json: user, status: :ok
        else
          render json: { error: "Invalid username or password" }, status: :unauthorized
        end
      end
    
      def destroy
        session.delete(:user_id)
        head :no_content
      end

      def index
        if session[:user_id]
          # user is already logged in
          user = User.find_by(id: session[:user_id])
          render json: user
        else
          # user is not logged in
          render json: { error: "User is not logged in" }, status: :unauthorized
        end
      end
end
