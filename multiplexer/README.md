# Мультиплексор 
Мультиплексор – это комбинационное логическое устройство, которое имеет $2^n$ информационных входов, n адресных входов и один выход Y, которое подключает к выходу сигнал с одного из информационных входов, номер которого соответствует двоичному коду на адресных входах.

Рассмотрим схему мультиплексора 2 в 1:  

<div align="center">
  <img src="https://github.com/user-attachments/assets/96d2285c-3c7f-41f3-80f1-490afbe3c64e" width="350" alt="Мультиплексор 2 в 1">
</div>  

Она имеет 2 информационных входа, то есть $2^1$, 1 адресный вход SEL и один выход OUT. На адресный вход SEL приходит информация о том, какой из информационных входов IN0 или IN1 был выбран. При SEL = 0 на выход передаётся сигнал с IN0, при SEL = 1 данные передаются со входа IN1. Таким образом мультиплексор работает в соответствии со следующей таблицей истинности:  

<div align="center">

| SEL | IN0 | IN1 | OUT |
| :---: | :---: | :---: | :---: |
| **0** |  0  |  X  | **0** |
| **0** |  1  |  X  | **1** |
| **1** |  X  |  0  | **0** |
| **1** |  X  |  1  | **1** |
</div>  

На основе данной таблицы истинности можно составить логическое выражение и, опираясь на него, составить схему из вентилей  

$$ OUT = (\overline{SEL} \cdot IN0) + (SEL \cdot IN1) $$
  
<div align="center">
  <img width="652" height="252" alt="MUX_2_1_ventili" src="https://github.com/user-attachments/assets/467ea3a3-94b2-405f-ad1c-7fecf822689a" />
</div>
  
А теперь, опираясь не вышеизложенную теорию, опишем данную схему на System Verilog. Есть несколько различных способов, которые позволят это сделать.  

### Описание схемы на вентилях

Наиболее примитивный (и реже используемый) способ реализации схемы мультиплексора – структурное её описание на вентилях. Выглядит оно следующим образом:  

```systemverilog
module multiplexer_2_1_ventili (
    input  logic IN0,
    input  logic IN1,
    input  logic SEL,

    output logic OUT
);

    assign OUT = (IN1 & SEL) | (IN0 & ~SEL);

endmodule
```
  
### Описание мультиплексора через if-else

Следующие два способа описания наиболее часто применимы. Поведенчески описывая мультиплексор при помощи if-else мы буквально говорим: "Если SEL = 1, отправляем данные со входа, на выход IN1"  

```systemverilog
if (SEL) OUT = IN1;
```
  
<div align="center">
  <img width="259" height="259" alt="MUX_2_1_IN0" src="https://github.com/user-attachments/assets/ec41ff26-533d-42cb-aae5-cf6c722610bb" />
</div>
  
"Если же SEL = 0, отправляем данные со входа, на выход IN0"  

```systemverilog
else     OUT = IN0;
```
  
<div align="center">
  <img width="259" height="259" alt="MUX_2_1_IN1" src="https://github.com/user-attachments/assets/8660b45d-6b91-489c-b5ce-4cb16bbc465e" />
</div>
  
```systemverilog
module multiplexer_2_1_if_else (
    input  logic IN0,
    input  logic IN1,
    input  logic SEL,

    output logic OUT
);

    always_comb begin
        if (SEL) OUT = IN1;
        else     OUT = IN0;
    end

endmodule
```
  
### Описание мультиплексора через case

Следующий способ описания данного комбинационного блока чем-то похож на предыдущий. Описывая case мы по сути так же говорим: "Если SEL = 0, на выход передаём вход IN0, если же SEL = 1, на выход передаём IN1"  

```systemverilog
module multiplexer_2_1_case (
    input  logic IN0,
    input  logic IN1,
    input  logic SEL,

    output logic OUT
);

    always_comb begin
        case(SEL)
        0: OUT = IN0;
        1: OUT = IN1;
        endcase
    end

endmodule
```
  
### Описание мультиплексора через тернарный оператор

Один из наиболее часто используемых способов описания мультиплексора. Он чем-то напоминает конструкцию if-else описанную в одну строчку  

```systemverilog
условие ? выражение_если_истина : выражение_если_ложь;
```
  
Здесь рассуждаем аналогично, анализируя сигнал SEL. Если SEL = 1 передаём на выход вход IN1, если SEL = 0 передаём на выход вход IN0:  

```systemverilog
module multiplexer_2_1_ternary_operator (
    input  logic IN0,
    input  logic IN1,
    input  logic SEL,

    output logic OUT
);

    assign OUT = SEL ? IN1 : IN0;

endmodule
```
  
