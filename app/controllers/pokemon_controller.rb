class PokemonController < ApplicationController

  def index

        res = Typhoeus.get("http://pokeapi.co/api/v2/pokemon", followlocation: true)
        body = JSON.parse(res.body)
        # body["name"] # should be "pikachu"
        render json:
          body["results"].map do |pokemon|
            {
              "url": pokemon["url"],
              "name": pokemon["name"]
            }
           end
          
  end

  def show

    res = Typhoeus.get("http://pokeapi.co/api/v2/pokemon/#{params[:id]}", followlocation: true)
    body = JSON.parse(res.body)

    render json:
      {
          "id":body["id"],
          "name":body["name"],
          "types":
           body["types"].map do |type_hash|
             type_hash["type"]["name"]
           end
      }
  end

end


# {
#   "id":25,
#   "name":"pikachu",
#   "types":["electric"]
# }
