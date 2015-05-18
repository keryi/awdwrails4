class SayController < ApplicationController
  def hello
    @time = Time.now
  end

  def bye
  end
end
