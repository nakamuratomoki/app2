class ApplicationController < ActionController::Base
 
 before_action :configure_permitted_parameters, if: :devise_controller?
 before_action :correct_user, only: [:edit, :update]
  
  def after_sign_in_path_for(resource)
    user_path(current_user) # ログイン後に遷移するpathを設定
  end

  def after_sign_out_path_for(resource)
    root_path # ログアウト後に遷移するpathを設定
  end


 protected
 def configure_permitted_parameters
   devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email])
   devise_parameter_sanitizer.permit(:sign_in, keys: [:name])
   devise_parameter_sanitizer.permit(:account_update, keys: [:name])
 end
 private
  def correct_user
    user = User.find(params[:id])
    if current_user != user
      redirect_to root_path
    end
  end
end
