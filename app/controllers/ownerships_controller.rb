class OwnershipsController < ApplicationController
  def create
    @sake = Sake.find_or_initialize_by(name: params[:sake_name])
    
    require 'open-uri'
  
    api_key =ENV['SAKENOTE_API_TOKEN'] 
    unless @sake.persisted?
      uri = URI.encode("https://www.sakenote.com/api/v1/sakes?token=#{api_key}&sake_name=#{params[:sake_name]}")
      res = open(uri)
      json_string = res.read
      results = JSON.parse(json_string, { symbolize_names: true })[:sakes]
      
      results.each do |result|
       @sake.identify_code = result[:sake_identify_code]
       @sake.name = result[:sake_name]
       @sake.furigana = result[:sake_furigana]
       @sake.maker_name = result[:maker_name]
       @sake.maker_address = result[:maker_address]
       @sake.maker_url = result[:maker_url]
       @sake.save
      end
    end
    
    if params[:type] == 'Want'
      current_user.want(@sake)
      flash[:success] = '商品を Wantしました'
    end
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @sake = Sake.find(params[:sake_id])
    
    if params[:type] == 'Want'
      current_user.unwant(@sake)
      flash[:success] = '商品の Want を解除しました'
    end
    
    
    redirect_back(fallback_location: root_path)
  end
end
