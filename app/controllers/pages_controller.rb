require 'open-uri'

class PagesController < ApplicationController
  include ChartsNationality
  skip_before_action :authenticate_user!, only: [:home]
  
  # 1 we are in the analytics page, and i sign in, with email and password
  # 2 once i sign in in the analytics, i make a request to the api from the way book.
  # 3 and i send email and password
  # 4 this last password we should encode it for security reasons. we don't seend the raw password
  # 5 when the rquest gets to the api way book
  # 6 way book will perform the normal devise log in using email and password
  # 7 if the login is succesfull, it should return the user token to the analytics app
  # 8 subsequent requests, will be made with email and token.

  def analytics
  	url = "http://localhost:3000/api/v1/profiles?user_email=albert.montolio@waygroup.de&user_token=yJ1i5DsvwxEFHRheXNQ1"

  	html_file = open(url).read
  	json_response = JSON.parse(html_file)

    full_names = json_response.map { |profile_hash| "#{profile_hash["first_name"]} #{profile_hash["last_name"]}" }

    # employees per division
  	divisions = json_response.map { |profile_hash| profile_hash["division"] }

    items_counts = GetItemsCountsHashService.execute(divisions)
    keys = items_counts.keys
    totals = items_counts.map { |key, value| value }

    @division_names = keys.to_json.html_safe
    @division_names = ["WAY HR", "WAY People+", "WAY Engineering", "WAY IT"].to_json.html_safe
    @num_employees_per_division = totals

    # employees per nationality way group
    items_counts = ChartsNationality.item_counts(json_response)
    @nationalities_names = ChartsNationality.way_group_data_x(items_counts)
    @num_employees_per_nationality = ChartsNationality.way_group_data_y(items_counts).sort.reverse

    # employees per nationality engineering division
    items_engineering = ChartsNationality.filter_by_division(json_response, "WAY Engineering GmbH")
    items_counts = ChartsNationality.item_counts(items_engineering)
    @nationalities_names_engineering = ChartsNationality.way_group_data_x(items_counts)
    @num_employees_per_nationality_engineering = ChartsNationality.way_group_data_y(items_counts).sort.reverse

    # employees per nationality people division
    items_people = ChartsNationality.filter_by_division(json_response, "WAY People+ GmbH")
    items_counts = ChartsNationality.item_counts(items_people)
    @nationalities_names_people = ChartsNationality.way_group_data_x(items_counts)
    @num_employees_per_nationality_people = ChartsNationality.way_group_data_y(items_counts).sort.reverse

    # company average age
    active_employees = json_response.select { |hash| hash["endway"].nil? }
    birthdays = active_employees.map { |profile_hash| Date.parse(profile_hash["birthday"]) }

    first_years_days = []
    years = (2006...Date.today.year).to_a

    years.each do |year|
      first_years_days << Date.new(year, 1, 1)
    end

    @monthly_ages_averages = []
    first_years_days.each do |first_year_day|
      ages = birthdays.map { |birthday| (first_year_day - birthday).to_f / 365.0 }
      ages_average = ages.inject(0.0) { |sum, el| sum + el } / ages.size
      @monthly_ages_averages << ages_average
    end

    @first_years_days = first_years_days.map { |first_year_day| first_year_day.strftime("%b %y") }.to_json.html_safe

    ### age of the way group
    ages = birthdays.map { |birthday| (Date.today - birthday).to_f / 365.0 }

    ages_18_30 = []
    ages_31_40 = []
    ages_41_50 = []
    ages_51_65 = []

    ages.each do |age|
      if age <= 30.0
        ages_18_30 << age
      elsif age <= 40.0 and age > 30
        ages_31_40 << age
      elsif age <= 50.0 and age > 40
        ages_41_50 << age
      elsif age <= 65.0 and age > 50
        ages_51_65 << age
      else

      end
    end
    @num_employee_per_age_group_array = [ages_18_30.count, ages_31_40.count, ages_41_50.count, ages_51_65.count]

    # num employees per country
    countries = json_response.map { |profile_hash| profile_hash["nationality"] }

    countries_counts = Hash.new 0
    countries.each do |division|
      countries_counts[division] += 1
    end

    # new employees per month
    months = (1..12).to_a
    years = (2006..Date.today.year).to_a

    years_hash =  Hash.new
    years.each do |year|
      months_hash = Hash.new
      years_hash[year] = months_hash
      months.each do |month|
        years_hash[year][month] = 0
      end
    end

    startways = json_response.map { |profile_hash| Date.parse(profile_hash["startway"]) }
    startways.each do |startway|
      year = startway.year
      month = startway.month
      years_hash[year][month] += years_hash[year][month] + 1
    end

    # convert to long array
    @incorporations = []
    arrays = years_hash.map { |key, value| value.map { |key, value| value } }
    arrays.each do |my_array|
      my_array.each do |number|
        @incorporations << number
      end
    end

    @inc_months = []
    years_hash.each do |key, value|
      year = key
      value.each do |key, test|
        @inc_months << Date.new(year, key, 1).strftime("%b %y")
      end
    end
    @inc_months = @inc_months.to_json.html_safe

    puts html_file
  end

  def home
  	
  end
end








