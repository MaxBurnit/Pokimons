class UserException inherits Exception { }

class Entrenador{
	var property pokemons = []
	method capturarPokemon(pokemon){
		pokemons.add(pokemon)
	}
}

class Pokemon{
	var property ataques = []
	var property estado = saludable
	var property tipo = "Normal"
	var property attack = 10
	var property defense = 10
	var property speed = 5
	var property hp = 10
	method aprenderAtaque(ataque){
		if(ataques.size() == 4){
			ataques.remove(ataques.anyOne())
		}
		ataques.add(ataque)
	}
	method atacar(ataque, pokemon){
		estado.atacar(self, ataque, pokemon)
	}
}

class Ataque{
	method efecto(pokemon)
	method danio(atacante)
}

object veneno{
	
	method  efecto(pokemon){
		pokemon.estado(envenenado)
	}
	method danio(atacante){
		return 0
	}
}

object atacTrueno {
	method efecto(pokemon){
		if([1,2].anyOne() == 1){
			const paralizado5 = new Paralizado()
			paralizado5.grado(5)
			pokemon.estado(paralizado5)
		}
	}
	method danio(atacante){
		return atacante.speed()
	}
}

object placaje{
	method efecto(pokemon){
		pokemon.estado(pokemon.estado())
	}
	
	method danio(atacante){
		return atacante.attack()
	}
}

object saludable{
	method atacar(atacante, ataque, pokemon){
		pokemon.defensa(pokemon.salud() - (ataque.danio() - 0.1 * pokemon.defensa()))
		ataque.efecto(pokemon)
		}
}

object envenenado{
	method atacar(atacante, ataque, pokemon){
		pokemon.defensa(pokemon.salud() - (ataque.danio() - 0.1 * pokemon.defensa()))
		ataque.efecto(pokemon)
		atacante.salud(pokemon.salud() * 0.9)
	}
}

class Paralizado{
	var property grado
	method atacar(atacante, ataque, pokemon){
		if(grado > 0){
			grado--
			throw new UserException("El pokemon esta paralizado, no puede atacar")
		}
		atacante.estado(saludable)
		saludable.atacar(atacante, ataque, pokemon)
	}
}

class Combate{
	var property entrenador1
	var property entrenador2
	var pokemon1 = entrenador1.pokemons().first()
	var pokemon2 = entrenador2.pokemons().first()
	method proximaRonda(){
		pokemon1.atacar((pokemon1.ataques().anyOne()), pokemon2)
		pokemon2.atacar((pokemon2.ataques().anyOne()), pokemon1)
		if(pokemon1.hp() <= 0){
			pokemon1 = entrenador1.pokemons().anyOne()
		} else if(pokemon2.hp() <= 0){
			pokemon2 = pokemon1
			pokemon1 = entrenador2.pokemons().anyOne()
		}
	}
}

