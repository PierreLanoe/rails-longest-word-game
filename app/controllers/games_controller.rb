require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = (0..9).map { ('a'..'z').to_a[rand(26)] }
    session[:letters] = @letters
  end

  def score
    @letters = session[:letters]
    @score = params[:score]
    array = @score.split('')
    array.each do |char|
      if @letters.include?(char)
        if test_franc?(@score)
          @scores = "Congratulations! #{@score.capitalize} is a Valid word."
        else
          @scores = "Sorry but #{@score} does not seem to be a valid english word"
        end
      else
        @scores = "Sorry but #{@score.capitalize} can't be buil with #{@letters}"
      end
    end
  end

  def test_franc?(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    user_serialized = open(url).read
    user = JSON.parse(user_serialized)
    user['found']
  end
end
