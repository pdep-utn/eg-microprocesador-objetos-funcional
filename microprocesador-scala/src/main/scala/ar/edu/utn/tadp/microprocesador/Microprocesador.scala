package ar.edu.utn.tadp.microprocesador

class Microprocesador {
  var a: Int = 0
  var b: Int = 0
  var pc: Int = 0

  def guardar(valor: Int) {
    a = valor
  }

  def avanzar() { pc += 1 }

  def sumar() { guardar(a+b) }
  def restar() { guardar(a-b) }
  def multiplicar() { guardar(a*b) }
  def dividir() { guardar(a/b) }

  def swap() {
    val _a = a
    a = b
    b = _a
  }
}

//case class Microprocesador(memoriaDeDatos: List[Short] = (1 to 1024).map(i => 0:Short), a: Short = 0, b: Short = 0, pc: Int = 0) {
//  def pc_+=(inc: Int) = copy(pc = pc + inc)
//
//  def guardar(valor: Int) = copy(
//    a = ((valor & 0xFF00) >> 4).toShort,
//    b = (valor & 0x00FF).toShort
//  )
//}