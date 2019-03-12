class SakesController < ApplicationController
  #before_action :require_user_logged_in
  
  def new
    @sakes = []
    
    require 'open-uri'
    
    
    @keyword = params[:keyword]
    api_key =ENV['SAKENOTE_API_TOKEN'] 
    if @keyword.present?
      uri = URI.encode("https://www.sakenote.com/api/v1/sakes?token=#{api_key}&sake_name=#{@keyword}")
      res = open(uri)
      json_string = res.read
      @results = JSON.parse(json_string, { symbolize_names: true })[:sakes]
    end
  end
    
    
 
  
private
  
end

