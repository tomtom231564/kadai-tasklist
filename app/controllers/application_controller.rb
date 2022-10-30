class ApplicationController < ActionController::Base
  include SessionsHelper  #課題作成に当たり追記
  include Pagy::Backend
  
   private

  def require_user_logged_in
    unless logged_in?
      redirect_to login_url
    end
  end
  
end
