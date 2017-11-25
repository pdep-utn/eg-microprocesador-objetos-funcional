## Enunciado

Un fabricante quiere simular el comportamiento de su próximo microprocesador para poder ejecutar una serie de programas. Nos informa que el microprocesador tiene:
- Dos registros A y B numéricos
- Un program counter (PC) que apunta a la que indica la dirección de la próxima instrucción a ejecutar y se incrementa cada vez que el microprocesador ejecuta una instrucción según la cantidad de bytes que ocupa.

#### Instrucciones básicas

|Instrucción | Bytes | Descripción|
|------------|-------|------------|
|NOP | 1 | No operación, el programa sigue en la próxima instrucción|
|ADD | 1 | Suma los valores de los dos registros y guarda el resultado en A| 
|SUB | 1 | Resta el valor del registro A al valor del registro B y guarda el resultado en A| 
|MUL | 1 | Multiplica los valores de los dos registros y guarda el resultado en A| 
|DIV | 1 | Divide los valores de los dos registros y guarda el resultado en A| 
|SWAP| 1 | Intercambia los valores de los registros| 
|LODV _val_ | 2 | Carga en el registro A el valor _val_| 
|HALT | 1 | Detiene la ejecución del programa| 


#### Instrucciones avanzadas

|Instrucción | Bytes | Descripción|
|------------|-------|------------|
|IFNZ _instrs_ | 1 | Ejecuta el conjunto _instrs_ de instrucciones si el valor del registro A es distinto de cero|
|WHNZ _instrs_ | 1 | Ejecuta el conjunto _instrs_ de instrucciones mientras el valor del registro A sea distinto de cero|
