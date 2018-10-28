import guerreros.*

object minimoNoImponible{
	method valor() {return 5}
}

class Comerciante {
	var tipo
	
	constructor (tipoDeComerciante){
		tipo = tipoDeComerciante
	}
	method recategorizacion() { tipo = tipo.recategorizacion()}
	
	method comision(valor) {return tipo.comision(valor) }
}

object registrado {
	method comision(valor){
		return valor*0.21
	}
	
	method recategorizacion(){
		return impuestoGanancias
	}
}

object independiente{
	var porcentajeComision
	
	method comision(valor){ return valor*porcentajeComision}
	
	method nuevaComision (nuevaComision) { porcentajeComision = nuevaComision}
	
	method recategorizacion(){
		if(porcentajeComision*2 >= 0.21) {return registrado}
		else {porcentajeComision = porcentajeComision*2
			return self
		}
	}
}

object impuestoGanancias{
	method comision (valor){
		if(minimoNoImponible.valor() >= valor) {return 0}
		else {return (valor-minimoNoImponible.valor())*0.35}
	}
	method recategorizacion(){
		return self
	}
}
