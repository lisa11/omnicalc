class CalculationsController < ApplicationController

  def word_count
    @text = params[:user_text]
    @special_word = params[:user_word]

    # ================================================================================
    # Your code goes below.
    # The text the user input is in the string @text.
    # The special word the user input is in the string @special_word.
    # ================================================================================

    @character_count_with_spaces = @text.length

    @character_count_without_spaces = @text.gsub(" ", "").length

    @word_count = @text.split.count

    count = 0
    @text.split.each do |word|
      if word.downcase == @special_word.downcase
        count += 1
      end
    end

    @occurrences = count

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("word_count.html.erb")
  end

  def loan_payment
    @apr = params[:annual_percentage_rate].to_f
    @years = params[:number_of_years].to_i
    @principal = params[:principal_value].to_f

    # ================================================================================
    # Your code goes below.
    # The annual percentage rate the user input is in the decimal @apr.
    # The number of years the user input is in the integer @years.
    # The principal value the user input is in the decimal @principal.
    # ================================================================================

    rate_per_period = @apr/100/12
    number_of_periods = @years*12
    top = @principal*rate_per_period
    bottom = 1-((1+rate_per_period)**(-number_of_periods))
    monthly_payment = top/bottom

    @monthly_payment = monthly_payment

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("loan_payment.html.erb")
  end

  def time_between
    @starting = Chronic.parse(params[:starting_time])
    @ending = Chronic.parse(params[:ending_time])

    # ================================================================================
    # Your code goes below.
    # The start time is in the Time @starting.
    # The end time is in the Time @ending.
    # Note: Ruby stores Times in terms of seconds since Jan 1, 1970.
    #   So if you subtract one time from another, you will get an integer
    #   number of seconds as a result.
    # ================================================================================
    seconds = @ending-@starting
    minutes = seconds/60
    hours = minutes/60
    days = hours/12
    weeks = days/7
    years = weeks/48
    @seconds = @ending-@starting
    @minutes = @seconds/60
    @hours = @minutes/60
    @days = @hours/24
    @weeks = @days/7
    @years = @days/365.25

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("time_between.html.erb")
  end

  def descriptive_statistics
    @numbers = params[:list_of_numbers].gsub(',', '').split.map(&:to_f)

    # ================================================================================
    # Your code goes below.
    # The numbers the user input are in the array @numbers.
    # ================================================================================

    @sorted_numbers = @numbers.sort

    @count = @numbers.count

    @minimum = @sorted_numbers[0]

    @maximum = @sorted_numbers[-1]

    @range = @maximum-@minimum

    median_position1 = @count/2.to_i
    median1 = @sorted_numbers[median_position1]

    median_position2 = ((@count-1)/2.to_i)

    if @count.odd?
      median = median1
    else
      median2 = @sorted_numbers[median_position2]
      median = (median1+median2)/2
    end

    @median = median

    @sum = @numbers.sum

    @mean = @sum/@count

    sum_of_var = 0

    @numbers.each do |num|
      sum_of_var += (num-@mean)**2
    end

    @variance = sum_of_var/(@count)

    @standard_deviation = Math.sqrt(@variance)

    mode_count = Hash.new
    mode = 0.0

    @numbers.each do |num|
      if mode_count[num] != nil
        occurrences = mode_count[num]+1
        mode_count[num] = occurrences
      else
        mode_count[num] = 1
      end

      if mode_count[num] > mode
        mode = mode_count[num].to_f
      end
    end

    @mode = mode

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("descriptive_statistics.html.erb")
  end
end
