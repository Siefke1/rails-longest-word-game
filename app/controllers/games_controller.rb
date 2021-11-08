# require "json"
require "open-uri"

class GamesController < ApplicationController

  def new
    alphabet = ('a'..'z').to_a
    @letters = alphabet.sample(10)
  end

  def score
    starting_time =  Time.new
    @word = params[:score]
    @letters = params["letters"].split(" ")
    @check_word_exist = check_word(params[:score])
    @length = check_length(params[:score])
    @included = included?(@word, @letters)
  end

  private

  def check_word(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    api_call = URI.open(url).read
    html_doc = JSON.parse(api_call)
    html_doc["found"]
  end

  def check_length(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    api_call = URI.open(url).read
    html_doc = JSON.parse(api_call)
    html_doc["length"]
  end

  def included?(word, letters)
    word.chars.all? { |letter| word.count(letter) <= letters.count(letter) }
  end
end
