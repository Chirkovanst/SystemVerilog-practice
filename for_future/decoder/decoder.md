### Дешифратор

Дешифратор, это противоположный элемент к шифратору.

Дешифратор – это цифровая комбинационная схема, которая принимает на входе n-битный двоичный код и активирует ровно один из своих $2^n$ выходов, чей номер соответствует поданному числу.

Входной двоичный код указывает на конкретный выходной канал. Если на входе меняется комбинация битов, схема переключает активный сигнал на соответствующий выход, а все остальные выходы переводит в пассивное состояние.

То есть, у нас есть 16 свитчей, мы с этих свитчей задаём двоичный код, например 11, устанавливаем в активное положение нулевой и первый свитч, загорается третья лампочка. Для того, чтобы описать данную схему при помощи вентилей, нам нужно описать каждый выход при помощи логических выражений. По сути, мы просто "умножаем" между собой элементы при помощи операции "AND" и инвертируем входы, в зависимости от того, какая цифра (0 или 1) стоит в том или ином разряде. Исходя из этой логики получаем следующие выражения:

&ensp;

$$
\begin{aligned}
Y_0 &= \overline{A_3} \cdot \overline{A_2} \cdot \overline{A_1} \cdot \overline{A_0} && 0000 \ (0) \\
Y_1 &= \overline{A_3} \cdot \overline{A_2} \cdot \overline{A_1} \cdot A_0 && 0001 \ (1) \\
Y_2 &= \overline{A_3} \cdot \overline{A_2} \cdot A_1 \cdot \overline{A_0} && 0010 \ (2) \\
Y_3 &= \overline{A_3} \cdot \overline{A_2} \cdot A_1 \cdot A_0 && 0011 \ (3) \\
Y_4 &= \overline{A_3} \cdot A_2 \cdot \overline{A_1} \cdot \overline{A_0} && 0100 \ (4) \\
Y_5 &= \overline{A_3} \cdot A_2 \cdot \overline{A_1} \cdot A_0 && 0101 \ (5) \\
Y_6 &= \overline{A_3} \cdot A_2 \cdot A_1 \cdot \overline{A_0} && 0110 \ (6) \\
Y_7 &= \overline{A_3} \cdot A_2 \cdot A_1 \cdot A_0 && 0111 \ (7) \\
Y_8 &= A_3 \cdot \overline{A_2} \cdot \overline{A_1} \cdot \overline{A_0} && 1000 \ (8) \\
Y_9 &= A_3 \cdot \overline{A_2} \cdot \overline{A_1} \cdot A_0 && 1001 \ (9) \\
Y_{10} &= A_3 \cdot \overline{A_2} \cdot A_1 \cdot \overline{A_0} && 1010 \ (10) \\
Y_{11} &= A_3 \cdot \overline{A_2} \cdot A_1 \cdot A_0 && 1011 \ (11) \\
Y_{12} &= A_3 \cdot A_2 \cdot \overline{A_1} \cdot \overline{A_0} && 1100 \ (12) \\
Y_{13} &= A_3 \cdot A_2 \cdot \overline{A_1} \cdot A_0 && 1101 \ (13) \\
Y_{14} &= A_3 \cdot A_2 \cdot A_1 \cdot \overline{A_0} && 1110 \ (14) \\
Y_{15} &= A_3 \cdot A_2 \cdot A_1 \cdot A_0 && 1111 \ (15)
\end{aligned}
$$

&ensp;

На System Verilog дешифратор  на вентилях можно описать следующим образом:

```systemverilog
module decoder(
    input  logic [3:0]  A,
    output logic [15:0] Y
);

    assign Y[0]  = ~A[3] & ~A[2] & ~A[1] & ~A[0];
    assign Y[1]  = ~A[3] & ~A[2] & ~A[1] & A[0];
    assign Y[2]  = ~A[3] & ~A[2] &  A[1] & ~A[0];
    assign Y[3]  = ~A[3] & ~A[2] &  A[1] & A[0];

    assign Y[4]  = ~A[3] &  A[2] & ~A[1] & ~A[0];
    assign Y[5]  = ~A[3] &  A[2] & ~A[1] & A[0];
    assign Y[6]  = ~A[3] &  A[2] &  A[1] & ~A[0];
    assign Y[7]  = ~A[3] &  A[2] &  A[1] & A[0];

    assign Y[8]  =  A[3] & ~A[2] & ~A[1] & ~A[0];
    assign Y[9]  =  A[3] & ~A[2] & ~A[1] & A[0];
    assign Y[10] =  A[3] & ~A[2] &  A[1] & ~A[0];
    assign Y[11] =  A[3] & ~A[2] &  A[1] & A[0];

    assign Y[12] =  A[3] &  A[2] & ~A[1] & ~A[0];
    assign Y[13] =  A[3] &  A[2] & ~A[1] & A[0];
    assign Y[14] =  A[3] &  A[2] &  A[1] & ~A[0];
    assign Y[15] =  A[3] &  A[2] &  A[1] & A[0];

endmodule
```

>[!NOTE]
>  Задание:
>  Опишите дешифратор поведенчески, используя case

Шапка модуля для выполнения задания:

```systemverilog
module decoder_task(
    input  logic [3:0]  A,
    output logic [15:0] Y
);

endmodule
```