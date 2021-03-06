$stdout.sync = true
####################################################################################################
# @author       David Kirwan 
# @description  Airfish iOS Testing App
#
# @date         19-04-2013
####################################################################################################
##### Require statements
require 'rubygems'
require 'sinatra/base'
require 'logger'
require 'date'

class Airfish < Sinatra::Base

  ##### Variables
  enable :static, :sessions, :logging
  set :environment, :production
  set :root, File.dirname(__FILE__)
  set :public_folder, Proc.new {File.join(root, '/public')}
  set :views, Proc.new {File.join(root, '/views')}
    
  # Create the logger instance
  set :log, Logger.new(STDOUT)
  set :level, Logger::DEBUG
  #set :level, Logger::INFO
  #set :level, Logger::WARN
  
  # Options hash
  set :options, {:log => settings.log, :level => settings.level}
  
  # Date
  today = DateTime.now
  theDate = today.year.to_s() + "-" + "%02d" % today.month.to_s() + "-" + "%02d" % today.day.to_s()
  set :date, theDate
  
  
  
#########################################################################################################  

  get '/' do
    erb :index
  end

  get '/leds.cgi' do
    val = params[:led]
    unless val.nil?
      if val.to_i == 0 then puts "Forward"; end
      if val.to_i == 1 then puts "Stop"; end
      if val.to_i == 3 then puts "Left"; end
      if val.to_i == 2 then puts "Right"; end
      if val.to_i == 4 then puts "Pitch Up"; end
      if val.to_i == 5 then puts "Pitch Down"; end
    end
    "Success! #{val}"
  end

  get '/status.xml' do
   return "<response><pot0>15.5</pot0></response>" 
  end

end 
