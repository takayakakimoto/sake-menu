class SakesController < ApplicationController
  before_action :require_user_logged_in
  
  def show
    @sake = Sake.find(params[:id])
    @want_users = @sake.want_users
  end
  
  def new
   
    require 'open-uri'
    
    
    @keyword = params[:keyword]
    api_key =ENV['SAKENOTE_API_TOKEN'] 
    if @keyword.present?
      uri = URI.encode("https://www.sakenote.com/api/v1/sakes?token=#{api_key}&sake_name=#{@keyword}")
      res = open(uri)
      json_string = res.read
      results = JSON.parse(json_string, { symbolize_names: true })[:sakes]
      
      @sakes = []

      results.each do |result|
        #binding.pry
       sake = Sake.find_or_initialize_by(identify_code: result[:sake_identify_code])
       sake.identify_code = result[:sake_identify_code]
       sake.name = result[:sake_name]
       sake.furigana = result[:sake_furigana]
       sake.maker_name = result[:maker_name]
       sake.maker_address = result[:maker_address]
       sake.maker_url = result[:maker_url]
       @sakes.push(sake)
      end
      
    end
  end
end

