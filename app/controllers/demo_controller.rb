class DemoController < ApplicationController
  before_action :authenticate_user!
end
