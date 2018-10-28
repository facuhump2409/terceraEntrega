import guerreros.*

class NPC inherits Guerrero {
	var nivel 
	
	constructor(nuevoHechizoPreferido,baseLucha,nuevosArtefactos,carga,nuevoNivel)=super(nuevoHechizoPreferido,baseLucha,nuevosArtefactos,carga){
		nivel = nuevoNivel
	}
	
	method valorBaseLucha(){return valorBaseLucha * nivel.multiplicador() }
}

class Nivel {
	var property multiplicador
	
	constructor (nuevoMultiplicador){
		multiplicador = nuevoMultiplicador
	}
}

