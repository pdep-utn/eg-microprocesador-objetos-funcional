class Microprocesador {
	var a = 0
	var b = 0
	var pc = 0

	method sumar() { a = a + b }
	
	method restar() { a = a - b }
	
	method multiplicar() { a = a * b }
	
	method dividir() { a = a / b }
	
	method swap() {
		const _a = a 
		a = b
		b = _a
	}
	
	method guardar(registro) { a = registro }
	
	method sumarPC(bytes) { pc += bytes }
	
	method a() = a
	method b() = b
	method pc() = pc
}