package ar.edu.utn.tadp.microprocesador

import org.junit.Assert._
import org.junit.Test
import ar.edu.utn.tadp.instrucciones._
import org.junit.Before
import org.junit.runner.RunWith

class MicroprocesadorTest {

  var micro: Microprocesador = _

  // ****************************************************************
  // ** SET-UP & TEAR-DOWN
  // ****************************************************************

  @Before
  def before = micro = new Microprocesador

  // ****************************************************************
  // ** ASSERTS
  // ****************************************************************

  def assertRegistros(expectedA: Short, expectedB: Short) = {
    assertEquals(expectedA, micro.a)
    assertEquals(expectedB, micro.b)
  }

  def assertProgramCounter(expectedPc: Int) = assertEquals(expectedPc, micro.pc)

  // ****************************************************************
  // ** TESTS
  // ****************************************************************

  @Test
  def `NOP: No hace nada` = {
    ejecutar(micro,
      nop
    )

    assertRegistros(0, 0)
    assertProgramCounter(1)
  }

  @Test
  def `LODV: guarda en el registro A` = {
    ejecutar(micro,
      lodV(5)
    )

    assertRegistros(5, 0)
    assertProgramCounter(2)
  }

  @Test
  def `SWAP: invierte los registros` = {
    ejecutar(micro,
      lodV(5),
      swap,
      lodV(2)
    )

    assertRegistros(2, 5)
    assertProgramCounter(5)
  }

  @Test
  def `ADD: suma los registros` = {
    ejecutar(micro,
      lodV(5),
      swap,
      lodV(2),
      add
    )

    assertRegistros(7, 5)
    assertProgramCounter(6)
  }

  @Test(expected = classOf[ArithmeticException])
  def `DIV: por 0 explota` = {
    ejecutar(micro,
      lodV(5),
      div,
      lodV(2)
    )
  }

  @Test
  def `HALT: detiene la ejecución` = {
    ejecutar(micro,
      lodV(5),
      halt,
      lodV(2)
    )

    assertRegistros(5, 0)
    assertProgramCounter(3)
  }

  @Test
  def `IFNZ: que cumple ejecuta instrucciones` = {
    ejecutar(micro,
      lodV(5),
      ifnz(
        swap,
        lodV(2)
      ),
      nop
    )

    assertRegistros(2, 5)
    assertProgramCounter(7)
  }

  @Test
  def `IFNZ: que NO cumple NO ejecuta instrucciones` = {
    ejecutar(micro,
      lodV(5),
      swap,
      ifnz(
        swap,
        lodV(2)
      ),
      nop
    )
    assertRegistros(0, 5)
    assertProgramCounter(5)
  }

  @Test
  def `IFNZ: que cumple y ejecuta HALT corta la ejecución` = {
    ejecutar(micro,
      lodV(5),
      ifnz(
        swap,
        halt,
        lodV(2)
      ),
      lodV(3)
    )
    assertRegistros(0, 5)
    assertProgramCounter(5)
  }
}