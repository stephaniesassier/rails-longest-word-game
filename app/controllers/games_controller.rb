require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = ('A'..'Z').to_a.sample(10)
  end

  def score
    console
    @word = params[:word].downcase
    @letters = params[:letters].downcase.chars

    if @word.chars.all? { |letter| @word.count(letter) <= @letters.count(letter) }
      url = "https://wagon-dictionary.herokuapp.com/#{@word}"
      user_serialized = open(url).read
      @api_result = JSON.parse(user_serialized)
      if @api_result["found"] == true
        @result = "Great Job !"
      else
        @result = "Sorry but #{@word} does not seem to be a valid English word ..."
      end
    else
      @result = "Sorry, play again"
    end
  end
end
