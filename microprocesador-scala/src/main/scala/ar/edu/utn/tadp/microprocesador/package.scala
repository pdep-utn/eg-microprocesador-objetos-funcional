package ar.edu.utn.tadp

import ar.edu.utn.tadp.microprocesador.Microprocesador
import scala.language.implicitConversions

class HaltException extends Exception

package object instrucciones {

  type Instruccion = Microprocesador => Unit

  def nop : Instruccion = _ => {}
  def add : Instruccion = _.sumar()
  def sub : Instruccion = _.restar()
  def mul : Instruccion = _.multiplicar()
  def div : Instruccion = _.dividir()
  def swap : Instruccion = _.swap()
  def lodV(valor : Int): Instruccion = micro => {
    micro.avanzar()
    micro.guardar(valor)
  }

  def halt : Instruccion = _ => throw new HaltException

  def ifnz(programa: Instruccion*) : Instruccion = micro => if(micro.a != 0) ejecutarInstrucciones(micro, programa)

  def ejecutarInstruccion(micro: Microprocesador, instruccion: Instruccion) = {
    micro.avanzar()
    instruccion(micro)
  }

  def ejecutarInstrucciones(micro: Microprocesador, instrucciones: Seq[Instruccion]) = {
    instrucciones.foreach(ejecutarInstruccion(micro, _))
  }

  def ejecutar(micro: Microprocesador, programa: Instruccion*) = {
    try
      ejecutarInstrucciones(micro, programa)
    catch {
      case _ : HaltException => /* HALT es una forma correcta de terminar un programa */
    }
  }
}
