class ApplicationController < ActionController::Base
  include Clearance::Controller
  before_action :require_login, only: [:new, :create]
  protect_from_forgery with: :exception
end
