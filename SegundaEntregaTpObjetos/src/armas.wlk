import guerreros.*

object fuerzaOscura {
	var property valor = 5
	
	method eclipse() { self.valor(self.valor()*2) }
}

class ArmaBasica inherits Peso{	
//	var pesoTotal
//	
//	var dias
	
	constructor(peso,nuevaFecha)=super(peso,nuevaFecha)
	
	method valor(guerrero){ return 3 }
	
	method precio(guerrero){return self.pesoTotal(guerrero)*5}
	
	method esEspejo(){ return false} //@ Un asquete
}

class CollarDivino inherits Peso{ // como hacer con el tema constructor
	var perlas 
	
	constructor (nuevaPerlas,peso,dias) = super (peso,dias){
		perlas = nuevaPerlas
	}
	
	override method pesoTotal(guerrero) {return super(guerrero) + perlas*0.5  }
	
	method perlas (cantidadDePerlas){ perlas = cantidadDePerlas }
	
	method precio(guerrero){return perlas*2}
	
	method valor(guerrero){ return perlas }
	
	method esEspejo(){ return false} //@ Un asquete
}


class Mascara inherits Peso{
	var indiceOscuridad
	
	var property minimo = 3
	
	constructor(nuevoIndiceOscuridad,peso,dias)= super(peso,dias){
		if(nuevoIndiceOscuridad<=1 && nuevoIndiceOscuridad>=0){indiceOscuridad = nuevoIndiceOscuridad}
		else {self.error("el indice de oscuridad debe estar entre 0 y 1")}
	}
	
	override method pesoTotal(guerrero){ return super(guerrero) + self.valorPeso(guerrero) }
	
	method cambiarMinimo(nuevoMinimo) {minimo=nuevoMinimo}
	
	method valorPeso(guerrero){return 0.max(self.valor(guerrero)-3) }
	
	method valor(guerrero){return minimo.max((fuerzaOscura.valor()/2)*indiceOscuridad) } //minimo.max((fuerzaOscura.valor()/2)*indiceOscuridad)
	
	method precio(guerrero){ return 10*indiceOscuridad }
	
	method esEspejo(){ return false} //@ Un asquete
}


class Armadura inherits Peso{
	var valorBase
	
	var refuerzo //cota ó bendicion ó hechizo
	
	constructor(nuevoValorBase,nuevoRefuerzo,peso,dias)=super(peso,dias){
		valorBase= nuevoValorBase
		self.refuerzo(nuevoRefuerzo)
	}
	override method pesoTotal(guerrero){ return super(guerrero) + refuerzo.peso(guerrero)}
	
	method refuerzo(nuevoRef){ refuerzo = nuevoRef }
	
	method precio(guerrero){return refuerzo.precio(valorBase,guerrero)}
	
	method valor(guerrero){ return valorBase + refuerzo.poder(guerrero) }
	
	method esEspejo(){ return false } //@ Un asquete
}

object espejo{
	method valor(guerrero){ return guerrero.valorMejorArtefacto() }
	
	method peso(guerrero) {return 0} // no dice cuanto es
	
	method precio(guerrero) {return 90}
	
	method pesoTotal(guerrero) {return 0}
	
	method esEspejo(){ return true } //@ Un asquete
}

object bendicion{
	method poder(guerrero){ return guerrero.nivelHechiceria() }
	
	method peso(guerrero) {return 0}
	
	method precio(valorBase,guerrero){return valorBase} 
}//@debe haber forma de que te diga quien usa la armadura sin poner rolando

object hechizo{
	method poder(guerrero){ return guerrero.poderHechizoPreferido() }
	
	method peso(guerrero) {
		if (self.poder(guerrero).even()){return 2 }
		else {return 1}
	}
	
	method precio(valorBase,guerrero){return valorBase + self.poder(guerrero)}
}//@lo mismo de bendicion

class CotaDeMalla {
	var unidadLucha
	
	constructor(nuevaUnidad){
		unidadLucha= nuevaUnidad
	}
	method peso(guerrero) {return 1}
	
	method poder(guerrero){ return unidadLucha }
	
	method precio(valorBase,guerrero){return unidadLucha/2}
}

object nada{
	method poder(guerrero){ return 0 }
	
	method peso(guerrero) {return 0}
	
	method precio(valorBase,guerrero){return 2}
	
	method valor(guerrero){ return 0 }
	}

class Peso { // un ojeto o una clase?
	var diasDesdeCompra
	
	var peso
	
	constructor(nuevoPeso,dias){
		diasDesdeCompra = new Date() - dias
		peso = nuevoPeso
	}
	
	method pesoTotal(guerrero){ return peso - self.factorDeCorreccion() }
	
	method factorDeCorreccion(){ return 1.min(diasDesdeCompra/100) }
	}
///////////