module Microprocesador where

data Micro = Micro {
  a :: Int,
  b :: Int,
  pc :: Int,
  stop :: Bool
} deriving (Show, Eq)

micro = Micro 0 0 0 False

movePC micro = micro{ pc = pc micro + 1 }

isZeroA = (==0) . a


-- INSTRUCCIONES
type Instruccion = Micro -> Micro
type Programa = [Instruccion]

nop :: Instruccion
nop = id

add :: Instruccion
add (Micro a b pc stop) = Micro (a+b) b pc stop

sub :: Instruccion
sub (Micro a b pc stop) = Micro (a-b) b pc stop

mul :: Instruccion
mul (Micro a b pc stop) = Micro (a*b) b pc stop

divv :: Instruccion          -- Fuckin Lazy Evaluation
divv micro@(Micro a b pc stop) = (Micro $! (div a b)) b pc stop

swap :: Instruccion
swap (Micro a b pc stop) = Micro b a pc stop

halt :: Instruccion
halt micro = micro{stop = True}

lodV :: Int -> Instruccion
lodV valor micro = movePC $ micro{a = valor}

ifnz :: Programa -> Instruccion
ifnz instrucciones micro
  |isZeroA micro = micro
  |otherwise = ejecutar micro instrucciones


-- EJECUCIÓN
ejecutar :: Micro -> Programa -> Micro
ejecutar micro instrucciones =
  foldl ejecutarInstruccion micro instrucciones

ejecutarInstruccion :: Micro -> Instruccion -> Micro
ejecutarInstruccion micro instruccion
  |stop micro = micro
  |otherwise = movePC . instruccion $ micro
