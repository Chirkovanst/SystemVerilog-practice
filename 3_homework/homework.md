# Практическое задание

### 1 задание

Давайте сейчас вспомним чуть-чуть математики)  
Помните момент когда, вычитание было равносильно сложению? То есть, `A - B` это то же самое, что `A + (-B)`? На System Verilog можно примерно также, только выглядеть это будет следующим образом:

$$A - B = A + (\sim B + 1)$$

Если при обычном сложении для получения отрицательного числа нам необходимо домножить его на -1, то сейчас с этой целью можно сделать число отрицательным, перейдя в дополнительный код. Если рассматривать на примере, вычтем 5 из 8. Для начала инвертируем биты 5 в двоичном виде:

$$B = 0101_2 \implies \sim B = 1010_2$$

Затем прибавляем 1:

<p align="center">
  <img width="421" height="106" alt="image" src="https://github.com/user-attachments/assets/3544f175-15c6-415e-8e76-c62019a242f2" />
</p>

Далее складываем A с полученным дополнительным кодом числа B:

<p align="center">
  <img width="457" height="100" alt="image" src="https://github.com/user-attachments/assets/530c1af9-0b49-48dd-a080-0d2636f2eb6e" />
</p>

>[!NOTE]
>  Задание:
>  Опишите на System Verilog модуль, который вычитает или складывает два операнда в зависимости от сигнала sub, используя описанный нами ранее модуль восьмибитного сумматора 

Шапка модуля:

```systemverilog
module adder_subtactor(
    input  logic [3:0] A, B,
    input  logic       sub,

    output logic [3:0] S,
    output logic       Cout
);
```

<details>
  <summary> Первая маленькая подсказка </summary>
  Для выполнения данного задания Вам нужно инстанцировать модуль full_adder_4bit и грамотно подключить и преобразовать его сигналы
</details>

<details>
  <summary> Вторая маленькая подсказка </summary>  
  
```systemverilog
full_adder_4bit inst (
    .A    (),
    .B    (),
    .Cin  (),
    .S    (),
    .Cout ()
);
```

</details>

<details>
  <summary> Третья маленькая подсказка </summary>  
  
```systemverilog
full_adder_4bit inst (
    .A    (),
    .B    (проверяем сигнал sub, и в зависимости от него выдаём инвертированный или неинвертированный сигнал B),
    .Cin  (проверяем сигнал sub, и в зависимости от него выдаём 1 или 0),
    .S    (),
    .Cout ()
);
```

</details>

> Как думаете, с какой целью можно использовать сумматор как для сложения, так и для вычитания?

### 2 задание

Помните мы на семинаре описали схему двухбитного умножителя? Теперь Вам нужно описать четырёхбитный умножитель, используя 4 модуля двухбитного умножителя)  

Шапка модуля:

```systemverilog
module multiplier_4x4 (
    input  logic [3:0] A, B,
    output logic [7:0] P
);

endmodule
```

&ensp;

<div align="center">
  <img width="666" height="223" alt="image" src="https://github.com/user-attachments/assets/5a29e3b7-1079-47b6-a2d4-6588ee6ba0ca" />
</div>

&ensp;

Вам нужно дополнить описание и получить в итоге вот такую вот схему:

&ensp;

<div align="center">
  <img width="1537" height="521" alt="image" src="https://github.com/user-attachments/assets/83890a64-4bde-4bf5-a803-bd9bd40466d3" />
</div>

>[!NOTE]
>  Задание:
>  Заполните входы и выходы модулей inst_P1, inst_P2, inst_P3 и inst_SUM2, inst_SUM3

&ensp;

instP0 отвечает вот за это произведение:

<div align="center">
  <img width="670" height="196" alt="image" src="https://github.com/user-attachments/assets/dfb15a72-1864-4146-827a-e2926838883e" />
</div>

Тут нам в качестве операндов нужно передать два бита числа A[1:0] $A_{0} A_{1}$ и два бита числа B[1:0] $B_{0} B_{1}$ и результат принять в качестве произведения P0

```systemverilog
 multiplier_2x2 inst_P0 (
        .A (A[1:0]),
        .B (B[1:0]),
        .P (P0)
    );
```

Далее сдвигаем получившееся произведения. Подгоняем их под те сдвиги, которые мы имеем при умножении в столбик.

```systemverilog
assign shift_P0 = {4'b0000, P0};
```

P0 дополняем четырьмя битами, потому что в последствии мы отправим это число на сложение в четырёхбитный сумматор. Тогда в случае с inst_P1, inst_P2, inst_P3, нам стоит действовать аналогично при заполнении входов и выходов инстанцированных блоков двухбитного умножителя:

&ensp;

<div align="center">
  <img width="670" height="196" alt="image" src="https://github.com/user-attachments/assets/47ba5e3b-78f2-4a88-91e3-ec9b67017a48" />
</div>

&ensp;

```systemverilog
multiplier_2x2 inst_P1 (
        .A(),
        .B(),
        .P()
    );
```

&ensp;

<div align="center">
  <img width="670" height="196" alt="image" src="https://github.com/user-attachments/assets/4df5e613-e5f7-4a74-be7d-befa786e9b76" />
</div>

&ensp;

```systemverilog
multiplier_2x2 inst_P2 (
        .A(),
        .B(),
        .P()
    );
```

&ensp;

<div align="center">
  <img width="670" height="196" alt="image" src="https://github.com/user-attachments/assets/9ae459f8-d987-4e89-a5e5-9e6722bf8dea" />
</div>

&ensp;

```systemverilog
multiplier_2x2 inst_P3 (
        .A(),
        .B(),
        .P()
    );
```

А теперь все эти произведения суммируем:

<div align="center">
  <img width="670" height="196" alt="image" src="https://github.com/user-attachments/assets/20125a7d-5cbc-4da7-9e76-b5cfba177b37" />
</div>

```systemverilog
full_adder_8bit inst_SUM1 (
        .A    (shift_P0),
        .B    (shift_P1),
        .Cin  (1'b0),
        .Cout (carry1),
        .S    (SUM_1)
    );
```

<div align="center">
  <img width="670" height="196" alt="image" src="https://github.com/user-attachments/assets/a05c058e-8a80-48d6-b566-521e3702c59f" />
</div>

```systemverilog
full_adder_8bit inst_SUM2 (
        .A    (),
        .B    (),
        .Cin  (),
        .Cout (),
        .S    ()
    );
```

<div align="center">
  <img width="670" height="196" alt="image" src="https://github.com/user-attachments/assets/e76bfd3a-6c18-4ea4-925f-05c1d6cbf6ad" />
</div>

```systemverilog
full_adder_8bit inst_SUM3 (
        .A    (),
        .B    (),
        .Cin  (),
        .Cout (),
        .S    ()
    );
```


### 3 задание

Вот на семинаре мы старались, описали достаточно много комбинационных блоков, а что дальше? Зачем это всё?  
Сегодня на семинаре мы по крупицами собирали сердце любого современного процессора – АЛУ.

АЛУ – это часть процессора, которая выполняет математические и логические действия над данными.

>[!NOTE]
>  Задание:
>  Мы описали целых три арифметических блока, на которых можно складывать, вычитать и умножать. Ваша задача реализовать упрощённое четырёхбитное АЛУ. Операции АЛУ кодируются следующим образом:
>
> 00 - сложение  
> 01 - вычитание  
> 10 - умножение  

Тогда шапка модуля такого АЛУ:

```systemverilog
module alu(
    input  logic [3:0] A, B,
    input  logic [1:0] opcode, // Помните у нас был сигнал SEL в мультиплексоре?)

    output logic [7:0] result,
);
```

Так как АЛУ у нас четырёхбитный, сумматор мы возьмём также четырёхбитный:

```systemverilog
module full_adder_4bit (
    input  logic [3:0] A, B,
    input  logic       Cin,

    output logic       Cout,
    output logic [3:0] S
);

logic [4:0] carry;

assign carry[0] = Cin;
assign Cout     = carry[4];

full_adder inst[3:0] (
    .A    (A),
    .B    (B),
    .Cin  (carry[3:0]),
    .S    (S),
    .Cout (carry[4:1])
);

endmodule
```

Теперь нам нужно инстанцировать в модуль нашего АЛУ, описанные ранее блоки:

```systemverilog
module alu(
    input  logic [3:0] A, B,
    input  logic [1:0] opcode, // Помните у нас был сигнал SEL в мультиплексоре?)

    output logic [7:0] result
);

    import alu_opcodes_pkg::*; // Импортируем параметры, которые содержат коды операций АЛУ

    // ALU_ADD = 2'b00; 
    // ALU_SUB = 2'b01;
    // ALU_MUL = 2'b10;

    // Инстанцируем описанные нами ранее модули

    logic [3:0] add_sub_result;
    logic       add_sub_Cout; 

    logic [7:0] mul_result;

    adder_subtactor inst_ADD_SUB (
        .A    (A),
        .B    (B),
        .sub  (/* Какой тут должен быть сигнал? Все ли его биты нам нужны?*/),
        .S    (add_sub_result),
        .Cout (add_sub_Cout)
    );

    multiplier_4x4 inst_MUL (
        .A    (A),
        .B    (B),
        .P    (mul_result)
    );
    
endmodule
```

### Все ли биты сигнала opcode нужно передавать в модуль adder_subtactor?

Мы обусловились кодировать сигналы следующим образом:


| opcode | Операция | sub |
| :---:  | :---     | :-: |
| `00`   | ADD      | 0   |
| `01`   | SUB      | 1   |
| `10`   | MUL      | —   |


Соответственно в модуле adder_subtactor, если sub равен 1, то вычитаем, если же этот сигнал 0 – складываем. Обратите внимание, что opcode сигналов SUB и ADD отличаются всего на один младший бит. Этим Вам и стоит оперировать при выполнении задания) 
