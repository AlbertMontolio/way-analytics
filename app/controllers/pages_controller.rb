require 'open-uri'

class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
  	url = "http://localhost:3000/api/v1/profiles?user_email=albert.montolio@waygroup.de&user_token=ntcCWUai6z4Awvi_NsRQ"

  	html_file = open(url).read
  	json_response = JSON.parse(html_file)
  	my_skills = json_response[0]["own_company_skills"]

  	puts html_file

  	

  end
end
