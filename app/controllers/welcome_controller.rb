class WelcomeController < ApplicationController

  def index
    @events = Event.current
  end

end