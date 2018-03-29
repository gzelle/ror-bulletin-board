class ApplicationController < ActionController::Base
  include Clearance::Controller
  before_action :require_login, only: [:create, :new]
  protect_from_forgery with: :exception
end
