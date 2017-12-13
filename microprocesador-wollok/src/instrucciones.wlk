class Instruccion {
	const bytes = 1
	
	constructor() { }
	constructor(_bytes) { bytes = _bytes }
	
	method ejecutar(micro) {
		micro.sumarPC(bytes)
		self.doEjecutar(micro)
	}
	
	method doEjecutar(micro)
}

object nop inherits Instruccion {
	override method doEjecutar(micro) { /* No hace nada */ }
}

object add inherits Instruccion {
	override method doEjecutar(micro) { micro.sumar() }
}

object sub inherits Instruccion {
	override method doEjecutar(micro) { micro.restar() }
}

object mul inherits Instruccion {
	override method doEjecutar(micro) { micro.multiplicar() }
}

object div inherits Instruccion {
	override method doEjecutar(micro) { micro.dividir() }
}

object swap inherits Instruccion {
	override method doEjecutar(micro) { micro.swap() }
}

object halt inherits Instruccion {
	override method doEjecutar(micro) { throw new HaltException() }
}

class Lodv inherits Instruccion {
	const valor
	
	constructor(_valor) = super(2) { valor = _valor }
	
	override method doEjecutar(micro) { micro.guardar(valor) }
}

class Ifnz inherits Instruccion {
	const instrucciones
	
	constructor(_instrucciones...) = super(1) { instrucciones = _instrucciones }
	
	override method doEjecutar(micro) {
		if(micro.a() != 0) 
			instrucciones.forEach{i => i.ejecutar(micro)}
	}
}



class Programa {
	const instrucciones
	
	constructor(_instrucciones) { instrucciones = _instrucciones }
	
	method ejecutar(micro) {
		try {
			instrucciones.forEach{i => i.ejecutar(micro)}
		} catch e : HaltException {
			/* HALT es una forma correcta de terminar un programa */
			// ESTO ES UN CASO SUPER EXCEPCIONAL
		}
	}
}

class HaltException inherits Exception { }