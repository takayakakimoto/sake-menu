class OwnershipsController < ApplicationController
  def create
    require 'open-uri'
    
    @sake = @results.find_or_initialize_by(name: params[sake[:sake_name]])
    
    unless @sake.persisted?
      
      api_key =ENV['SAKENOTE_API_TOKEN'] 
      uri = URI.encode("https://www.sakenote.com/api/v1/sakes?token=#{api_key}&sake_name=#{@keyword}")
      res = open(uri)
      json_string = res.read
      @results = JSON.parse(json_string, { symbolize_names: true })[:sakes]
      
      @sake = Sake.new
    
   
      
    end
  end

  def destroy
  end
end
