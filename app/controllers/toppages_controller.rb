class ToppagesController < ApplicationController
  def index
    @sakes = Sake.order('updated_at DESC')
  end
end
