class Api::BaseController < ApplicationController
  before_action :current_user

  private

  def authenticate_and_return_current_user
    authenticate_or_request_with_http_token do |token, _options|
      User.find_by(authentication_token: token)
    end
  end

  def current_user
    authenticate_and_return_current_user
  end
end