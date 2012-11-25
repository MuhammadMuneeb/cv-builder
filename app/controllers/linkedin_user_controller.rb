require 'rubygems'
require 'linkedin'

class LinkedinUserController < ApplicationController

#  before_filter :require_individual, :only=>[:callback]

  def init_client
    # API KEYS : https://www.linkedin.com/secure/developer
    key = "zrjfxj4j6u8i"
    secret = "OFHzBKYQxSNW66wy"
    @linkedin_client = LinkedIn::Client.new(key, secret)
  end

  def auth
    init_client
    request_token = @linkedin_client.request_token(:oauth_callback => "http://#{request.host_with_port}/linkedin/import")
    session[:rtoken] = request_token.token
    session[:rsecret] = request_token.secret
#      puts "$"*100
#      puts "  request_token  : #{  request_token }"
#      puts "$"*100
#      puts "$"*100
#      puts " session[:rtoken] : #{ session[:rtoken]}"
#      puts "$"*100
#      puts "$"*100
#      puts " session[:rtoken] : #{ session[:rsecret]}"
#      puts "$"*100
    redirect_to @linkedin_client.request_token.authorize_url
  end

  def callback
     init_client
    if session[:atoken].nil?
      pin = params[:oauth_verifier]
#      puts "%"*100
#      puts "pin : #{pin}"
#      puts "%"*100
      atoken, asecret =  @linkedin_client.authorize_from_request(session[:rtoken], session[:rsecret], pin)
      session[:atoken] = atoken
      session[:asecret] = asecret
#      puts "$"*100
#      puts " session[:atoken] : #{ session[:atoken]}"
#      puts "$"*100
#      puts "^"*100
#      puts " session[:asecret] : #{ session[:asecret]}"
#      puts "^"*100

      
    else
      @linkedin_client.authorize_from_access(session[:atoken], session[:asecret])
    end

    c = @linkedin_client
    profile_0 = c.profile
#    puts "profile_1 = #{profile_0}"

#
    profile_1 = c.profile(:fields=>["first_name","last_name","date_of_birth","location","headline","industry","positions","phone_numbers","public_profile_url","picture_url","main_address"])
    puts "profile_1 = #{profile_1}"
#    puts "first_name = #{profile_1.first_name}"
#    puts "last_name = #{profile_1.last_name}"
#    puts "DOb = #{profile_1.date_of_birth}"
#    puts "location = #{profile_1.location}"
#    puts "location name = #{profile_1.location.name}"
#    puts "country_code = #{profile_1.location.country.code.name}"
#    puts "country name = #{profile_1.location.name[0]}"
#    puts "phone = #{profile_1.phone_numbers}"
#    puts "public url = #{profile_1.public_profile_url}"
#    puts "picture url = #{profile_1.picture_url}"

    LinkedinDetails.parse_linkedin(current_user, profile_1)
##    ImportDetail::Linkedin.parse_linkedin_1(current_individual, profile_1)
    profile_2 = c.profile(:fields=>["distance","summary","associations","honors","interests","industry","headline"])
#    puts "profile_2 = #{profile_2}"
##    ImportDetail::Linkedin.parse_linkedin_2(current_individual, profile_2)
    profile_3 = c.profile(:fields=>["positions","three_current_positions","three_past_positions","publications","patents"])
#    puts "profile_3 = #{profile_3}"
##    ImportDetail::Linkedin.parse_linkedin_3(current_individual, profile_3)
    profile_4 = c.profile(:fields=>["languages","skills","certifications","educations"])
#    puts "profile_4 = #{profile_4}"
#    ImportDetail::Linkedin.parse_linkedin_4(current_individual, profile_4)

    ## Set preference to linked in
    #current_individual.set_resume_preference("linkedin")
    #current_individual.set_resume_preference("cv_builder")

    redirect_to dashboard_path(:imported_from_linkedin=>"success")
  end

  def test_console
    key = "zrjfxj4j6u8i"
    secret = "OFHzBKYQxSNW66wy"
    c = LinkedIn::Client.new(key, secret)
    request_token = c.request_token(:oauth_callback => "http://localhost:3000/linkedin/import")
    rtoken = request_token.token
    rsecret = request_token.secret
    c.request_token.authorize_url
    pin = "73207"
    atoken, asecret = c.authorize_from_request(rtoken, rsecret, pin)
    atoken = "b8526f9a-2cde-4850-a451-d08a66742287"
    asecret = "1def96c8-597c-4bb5-b866-2413c90ec6d2"
    c.authorize_from_access(atoken, asecret)
    p = c.profile
    #@linkedin_connections = @linkedin_client.connections
  end

end