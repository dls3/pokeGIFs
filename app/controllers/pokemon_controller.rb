class PokemonController < ApplicationController

  def index

    res = Typhoeus.get("http://pokeapi.co/api/v2/pokemon", followlocation: true)
    body = JSON.parse(res.body)
    render json:
      body["results"].map do |pokemon|
        {
          "url": pokemon["url"],
          "name": pokemon["name"]
        }
       end

  end

  def show

    ENV["GIPHY_KEY"]
    key = ENV["GIPHY_KEY"]


    headers = {
      Authorization: "Token token=\"#{ENV['GIPHY_KEY']}\""
    }

    res = Typhoeus.get("http://pokeapi.co/api/v2/pokemon/#{params[:id]}", followlocation: true)
    body = JSON.parse(res.body)

    res_gif = Typhoeus.get("https://api.giphy.com/v1/gifs/search?api_key=#{ENV["GIPHY_KEY"]}&q=#{params[:id]}&rating=g", followlocation: true)
    body_gif = JSON.parse(res_gif.body)

    render json:
       { gif_url: body_gif["data"][0]["embed_url"],
        "id":body["id"],
        "name":body["name"],
        "types":
         body["types"].map do |type_hash|
           type_hash["type"]["name"]
         end
      }
  end

end
