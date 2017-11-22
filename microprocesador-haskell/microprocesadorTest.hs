import Test.Hspec
import Control.Exception (evaluate)
import Microprocesador

main = hspec $ do
  describe "Un programa formado por" $ do
    it "NOP: No hace nada" $ do
      ejecutar micro [nop] `shouldBe` micro{pc = 1}

    it "LODV: guarda en el registro A" $ do
      ejecutar micro [lodV 5] `shouldBe` micro{a = 5, pc = 2}

    it "SWAP: invierte los registros" $ do
      ejecutar micro [
        lodV 5,
        swap,
        lodV 2
        ] `shouldBe` micro{a = 2, b = 5, pc = 5}

    it "ADD: suma los registros" $ do
      ejecutar micro [
        lodV 5,
        swap,
        lodV 2,
        add
        ] `shouldBe` micro{a = 7, b = 5, pc = 6}
    
    it "DIV: por 0 explota" $ do
      evaluate (ejecutar micro [
        lodV 5,
        divv,
        lodV 2
        ]) `shouldThrow` anyArithException  

    it "HALT: detiene la ejecución" $ do
      ejecutar micro [
        lodV 5,
        halt,
        lodV 2
        ] `shouldBe` micro{a = 5, pc = 3, stop = True}
    
    it "IFNZ: que cumple ejecuta instrucciones" $ do
      ejecutar micro [
        lodV 5,
        ifnz [
          swap,
          lodV 2
        ],
        nop
        ] `shouldBe` micro{a = 2, b = 5, pc = 7}
    
    it "IFNZ: que NO cumple NO ejecuta instrucciones" $ do
      ejecutar micro [
        lodV 5,
        swap,
        ifnz [
          swap,
          lodV 2
        ],
        nop
        ] `shouldBe` micro{b = 5, pc = 5}

    it "IFNZ: que cumple y ejecuta HALT corta la ejecución" $ do
      ejecutar micro [
        lodV 5,
        ifnz [
          swap,
          halt,
          lodV 2
        ],
        lodV 3
        ] `shouldBe` micro{b = 5, pc = 5, stop = True}
    
