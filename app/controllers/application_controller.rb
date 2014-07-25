class ApplicationController < ActionController::Base
  after_action :drop_csrf_cookie_for_angular,
               :if => :protect_against_forgery?
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def login_required
    if current_user.blank?
      redirect_to root_path
    end
  end

  private

  def drop_csrf_cookie_for_angular
    cookies['XSRF-TOKEN'] = form_authenticity_token
  end

  def verified_request?
    super || form_authenticity_token == request.headers['X-XSRF-TOKEN']
  end
end
