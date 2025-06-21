class Personaje {
  const fuerza
  const inteligencia
  var rol
  const localidad

  method cambiarDeRol(unRol) {
    rol = unRol
  }

  method potencialOfensivo() {
    return fuerza * 10 + rol.extra()
  }

  method esInteligente()

  method esGroso() {
    return self.esInteligente() or rol.esGroso(self)
  }
}

class Humano inherits Personaje {
  
  override method esInteligente() {
    return inteligencia > 50
  }

  override method potencialOfensivo() {

  }
}

class Orco inherits Personaje {
  override method potencialOfensivo() {
    return 
      if (rol.toString() == brujo.toString()) {
        super() * 1.1
      }
  }

  override method esInteligente() {
    return false
  }

}

class Guerrero {
  method tieneMascota() {
      return false
    }

  method extra() {
      return 100
    }

  method esGroso(unPersonaje) {
    return unPersonaje.fuerza > 50
  }
}

class Cazador {
  const mascota 

 method extra() {
    return mascota.potencialOfensivo()
  }

  method esGroso(unPersonaje){
    return mascota.esLongeva()
  }
}

class Mascota {
  const fuerza
  var edad
  const tieneGarras

  method cumplirAnios() {
    edad += 1
  }

  method potencialOfensivo() {
    return if (tieneGarras) fuerza * 2  else fuerza
  }

  method esLongeva(){
    return edad > 10
  }
}

class NoMascota {

  method potencialOfensivo() {
    return 0
  }

  method esLongeva() {
    return false
  }
}

object brujo {

 method extra() {
    return 0
  }

  method esGroso(unPersonaje) {
    return true
  }
}

class Localidad {
  var ejercito
  method poderDefensivo() {
    return ejercito.poderOfensivo()
  }

  method serOcupada(unEjercito) 
}

class Ciudad inherits Localidad{
  override method poderDefensivo() {
    return super() + 300
  }

  override method serOcupada(unEjercito) {
    ejercito = unEjercito
  }
}

class Aldea inherits Localidad{
  const maxPoblacion
  method initialize() {
    if (maxPoblacion < 10) {
      self.error("la población debe ser mayor a 10")
    }
  }

  override method serOcupada(unEjercito) {
    if (maxPoblacion < unEjercito.tamanio()) {
      ejercito = unEjercito.losMasFuertes()
    } else {
      ejercito = unEjercito
    }
  }
}

class Ejercito {
  const personajes = []

  method poderOfensivo() {
    return personajes.sum{p => p.poderOfensivo()}
  }

  method agregarPersonaje(unPersonaje) {
    personajes.add(unPersonaje)
  }

  method sacarPersonje(unPersonaje) {
    if (personajes.contains(unPersonaje)) {
      personajes.remove(unPersonaje)
    }
  }

  method invadir(unaLocalidad) {
    if (self.puedeInvadir(unaLocalidad)) {
      unaLocalidad.serOcupada(self)
    }
  }

  method puedeInvadir(unaLocalidad){
    return self.poderOfensivo() > unaLocalidad.poderDefensivo()
  }

  method tamanio() {
    return personajes.size()
  }
}