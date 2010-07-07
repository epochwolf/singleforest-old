class HomeController < ApplicationController
  def index
  end

  def debug
    @debug = params
  end
end
