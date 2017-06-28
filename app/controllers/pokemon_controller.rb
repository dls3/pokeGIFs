class PokemonController < ApplicationController

  def index

  end


  def show

    res = Typhoeus.get("http://pokeapi.co/api/v2/pokemon/#{params[:id]}", followlocation: true)
    body = JSON.parse(res.body)
    # body["name"] # should be "pikachu"

    render json: #body["name"]
      {
          "id":body["id"],
          "name":body["name"],
          "types":body["types"][0]["type"]["name"]
      }
  end

end


# {
#   "id":25,
#   "name":"pikachu",
#   "types":["electric"]
# }
