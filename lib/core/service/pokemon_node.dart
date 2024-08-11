import 'package:graphql_flutter/graphql_flutter.dart';

class PokemonNode {
  PokemonNode();

  getListPokemons(String limitations) {
    return gql("""
     {
    pokemons(first:$limitations){
      id
      name
      attacks{
        fast{
          damage
        }
      }
      classification
      types
      resistant
      image
    }
  }
""");
  }

  gePokemon(String id) {
    return gql("""
     {
    pokemon(id:"$id"){
      id
    number
    name
    weight {
      minimum
      maximum
    }
    height {
      minimum
      maximum
    }
    classification
    types
    resistant
    attacks {
      fast {
        name
        type
        damage
      }
      special {
        name
        type
        damage
      }
    }
    weaknesses
    fleeRate
    maxCP
    evolutions {
     name
     image
    }
    evolutionRequirements {
      amount
      name
    }
    maxHP
    image
    }
  }
""");
  }
}
