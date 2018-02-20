class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  #before any action we need authentication from current user(need to be log in )
  before_action :authenticate_user!
  # before_action :set_time_zone, if: :user_signed_in?
 def index
  @meetings = Meeting.all
end

 private

 # def set_time_zone
 #    Time.zone = current_user.time_zone
 # end
end
