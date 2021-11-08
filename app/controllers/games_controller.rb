# require "json"
require "open-uri"

class GamesController < ApplicationController

  def new
    alphabet = ('a'..'z').to_a
    @letters = alphabet.sample(10)
  end

  def score
    starting_time =  Time.new
    check = check_word(params[:score])
    length = check_length(params[:score])
    letters = check_letters(params[:score])
    raise
    if letters == false
      @message = "Sorry but #{params["score"]} cant be build out of #{params["letters"].split(" ")}"
    elsif check == false
      @message = "Sorry, #{params["score"]} doesn't seem to be an english word"
    else
      @message = "Congratulations!"
    end

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

  def check_letters(word)
    # url = "https://wagon-dictionary.herokuapp.com/#{word}"
    # api_call = URI.open(url).read
    # html_doc = JSON.parse(api_call)
    params["letters"].split(" ").include?word.split("")
  end
end
