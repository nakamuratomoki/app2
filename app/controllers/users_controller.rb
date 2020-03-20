class UsersController < ApplicationController
	before_action :authenticate_user!
    before_action :correct_user, only: [:edit, :update]
	def show
    @user = User.find(params[:id])
    @book = Book.new
    @books = @user.books.page(params[:page]).reverse_order  # ここを記述
    end
    def edit
        @book = Book.new
        @user = User.find(params[:id])
   if @user.id != current_user.id
    redirect_to user_path(current_user.id)
   end
    end
    def update
    @user = User.find(params[:id])
    if @user.update(user_params)
    	flash[:notice] = "successfully."
       redirect_to user_path(@user.id)
    else 
        flash[:notice] = "error"
       render :edit   
    end
    end
    def index
    	 @book = Book.new
         @users = User.page(params[:page]).reverse_order
    end	
private 
def user_params
    params.require(:user).permit(:name, :introduction,:profile_image)
end
def correct_user
    @user = User.find(params[:id])
    redirect_to(user_url(current_user)) unless @user == current_user
  end
end
