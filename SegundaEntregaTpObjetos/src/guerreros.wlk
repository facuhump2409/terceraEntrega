import hechizos.*
import armas.*

class Guerrero {
	var property hechizoPreferido 
	
	var valorBaseHechizo = 3
	
	var valorBaseLucha 
	
	var artefactos
	
	var property oro = 100
	
	var cargaMaxima
	
	constructor(nuevoHechizoPreferido,baseLucha,nuevosArtefactos,carga){
		hechizoPreferido= nuevoHechizoPreferido
		
		valorBaseLucha = baseLucha
		
		artefactos = nuevosArtefactos
		
		cargaMaxima = carga
	}
	
	method pagarMonedas(costo){
		if(oro<costo){
			self.error("no tienes suficientes monedas")
		}
		oro-=costo
	}
	
	method objetivoCumplido() {oro+=10}
	
	method canjearHechizo(nuevoHechizo){
		self.pagarMonedas(0.max(nuevoHechizo.precio(self) - hechizoPreferido.precio(self)/2))
		self.hechizoPreferido(nuevoHechizo)
	}
	
	method cargaAcumulada(){
		return artefactos.sum({artefacto => artefacto.pesoTotal(self)})
	}
	
	method comprarArtefacto(nuevoArtefacto,comerciante){
		if (cargaMaxima > (self.cargaAcumulada() + nuevoArtefacto.pesoTotal(self))){
		self.pagarMonedas(nuevoArtefacto.precio(self) + comerciante.comision(nuevoArtefacto.precio(self)))
		self.agregarArtefactos([nuevoArtefacto])
		}
		else {self.error("No se puede comprar el artefacto porque se excederia de la carga maxima")}
	}
	
	method desprenderArtefacto(tirarEste){
		artefactos.remove(tirarEste)
	}
	 
	method artefactos(){return artefactos}
	
	method luchaMayorAHechizo(){ return self.valorLucha()>self.nivelHechiceria() }
	
	method valorBaseLucha(nuevoValor){ valorBaseLucha= nuevoValor }
	
	method removerTodosLosArtefactos(){ artefactos.clear() }
	
	method removerArtefacto(artefactoASacar){ artefactos.remove(artefactoASacar) }
	
	method agregarArtefactos(nuevosArtefactos){artefactos.addAll(nuevosArtefactos) }
	
	method nivelHechiceria() { return (valorBaseHechizo*hechizoPreferido.poder(self)) +fuerzaOscura.valor() }
	
	method valorLucha(){ return artefactos.sum({artefacto => artefacto.valor(self)})+valorBaseLucha }
	
	method esPoderoso(){ return hechizoPreferido.esPoderoso(self) }
	
	///////////
	method estaCargado(){ return artefactos.size()>=5 }
	
	method soloTieneEspejo(){
		return artefactos.size()==1 && artefactos.contains(espejo) //@contains no es de orden superior, esto es medio sucio
	}
	
	method valorMejorArtefacto(){ 
		if (self.soloTieneEspejo()) return 0
		else return artefactos.filter({artefacto=>!artefacto.esEspejo()}).map({artefacto=>artefacto.valor(self)}).max()
	}
	
	method poderHechizoPreferido(){
		return hechizoPreferido.poder(self)
	}
	
}





