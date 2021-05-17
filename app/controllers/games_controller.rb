require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = ('A'..'Z').to_a.sample(10)
  end

  def score
    @letters = params[:letters].split
    @guess = (params[:guess] || "").upcase
    @included = included?(@guess, @letters)
    @word = word?(@guess)
  end

  private

  def word?(guess)
    response = URI.open("https://wagon-dictionary.herokuapp.com/#{guess}")
    json = JSON.parse(response.read)
    json['found']
  end

  def included?(guess, letters)
    guess.chars.all? { |char| guess.count(char) <= letters.count(char) }
  end
end
