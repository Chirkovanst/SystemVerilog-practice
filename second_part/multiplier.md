# Умножитель

Помню в младшей школе, за сложением и вычитанием, следовало умножение и деление. Почему бы и нам не последовать этому примеру)

В данном случае, так же как и с сумматором, вспомним обычное умножение в столбик. Перемножим, например, 23 и 44. По алгоритму умножения в столбик, изначально перемножаем 3 на 4. Получаем 12, 2 остаётся в разряде единиц, 1 переходит в разряд десятков:

&ensp;

<div align="center">
  <img width="213" height="207" alt="image" src="https://github.com/user-attachments/assets/82b10340-910c-48d1-8a24-93ccaf551228" />
</div>  

&ensp;

Теперь умножим двойку на 4 и не забудем про единицу, которая перешла в разряд десятков:

<div align="center">
  <img width="199" height="218" alt="image" src="https://github.com/user-attachments/assets/bd03fc89-50ec-46a2-a687-c5f08992aff7" />
</div> 

Аналогично умножим число 23 на 4, которая стоит в разряде десятков:

&ensp;

<div align="center">
  <img width="230" height="269" alt="image" src="https://github.com/user-attachments/assets/d8627e25-e0dc-4886-9233-b9cff6f224f0" />
</div>

&ensp;

<div align="center">
  <img width="222" height="272" alt="image" src="https://github.com/user-attachments/assets/b69f2370-db16-4da8-b63f-b03fc5e3af41" />
</div>

&ensp;

Ну и, конечно, сложим числа, получившиеся в результате умножения:

&ensp;

<div align="center">
  <img width="266" height="361" alt="image" src="https://github.com/user-attachments/assets/29e35b67-8230-4d93-ba9c-ef0cf64b6781" />
</div>

&ensp;

А если бы мы также умножали два двоичных числа в двоичной системе счисления? Перемножили бы, например 11 (3) и 10 (2):

&ensp;

<div align="center">
  <img width="196" height="181" alt="image" src="https://github.com/user-attachments/assets/47b73af4-e870-42e3-891c-133405241a11" />
</div>

&ensp;

<div align="center">
  <img width="231" height="234" alt="image" src="https://github.com/user-attachments/assets/17285c2e-e88d-4b85-926a-3842438881dd" />
</div>

&ensp;

<div align="center">
  <img width="232" height="268" alt="image" src="https://github.com/user-attachments/assets/ea32915c-e128-463c-b59c-10dadd55457f" />
</div>

Можно заметить, что умножение в двоичной системе счисления, можно заменить логическим вентилем "И", а при сложении чисел мы используем обычный полусумматор, который мы рассматривали ранее. Опишем данную схему на System Verilog, Нам необходимо перемножить два двухбитных числа: 

&ensp;

<div align="center">
  <img width="285" height="135" alt="image" src="https://github.com/user-attachments/assets/8afbba1e-0a45-4e44-b3b1-2ccfc84084af" />
</div>

&ensp;

Тогда шапка модуля будет следующей:

```systemverilog
module multiplier_2x2 (
    input  logic [1:0] A, B,

    output logic [3:0] P
);
```

Формируем неполные произведения:

&ensp;

<div align="center">
  <img width="593" height="281" alt="image" src="https://github.com/user-attachments/assets/b1f3a9ff-4a1c-4ad9-9a27-02cf73c6fc22" />
</div>

&ensp;

```systemverilog
logic A0B0;
logic A1B0;

logic A0B1;
logic A1B1;

logic carry;

assign A0B0 = A[0] & B[0];
assign A1B0 = A[1] & B[0];

assign A0B1 = A[0] & B[1];
assign A1B1 = A[1] & B[1];
```

Далее формируем сумму. Разряд единиц просто сносим, остальные разряды складываем:

&ensp;

<div align="center">
  <img width="655" height="317" alt="image" src="https://github.com/user-attachments/assets/c9d530df-e5bd-49c5-aa1d-efe5b03f436e" />
</div>

&ensp;

```systemverilog
assign P[0] = A0B0;

Half_Adder inst_P1(
    .A(A0B1),
    .B(A1B0),
    .S(P[1]),
    .C(carry)
);

Half_Adder inst_P2_P3(
    .A(A1B1),
    .B(carry),
    .S(P[2]),
    .C(P[3])
);
```

Для сложения неполных произведений, с целью формирования конечного ответа, можно использовать, написанный нами ранее неполный сумматор. В результате получаем:

```systemverilog
module multiplier_2x2 (
    input  logic [1:0] A, B,

    output logic [3:0] P
);

logic A0B0;
logic A1B0;

logic A0B1;
logic A1B1;

logic carry;

assign A0B0 = A[0] & B[0];
assign A1B0 = A[1] & B[0];

assign A0B1 = A[0] & B[1];
assign A1B1 = A[1] & B[1];

assign P[0] = A0B0;

Half_Adder inst_P1(
    .A(A0B1),
    .B(A1B0),
    .S(P[1]),
    .C(carry)
);

Half_Adder inst_P2_P3(
    .A(A1B1),
    .B(carry),
    .S(P[2]),
    .C(P[3])
);

endmodule
```

Стоит отметить, что неполный сумматор мы можем использовать только в том случае, когда происходит сложение первого и второго разряда. Если бы мы реализовывали трех битный сумматор, то при сложении второго и третьего разрядов нужно было бы использовать полный сумматор.

>[!NOTE]
>  Задание:
>  Опишите на System Verilog трёхбитный умножитель

Шапка модуля:

```systemverilog
module multiplier_3x3(
    input  logic [2:0] A, B,
    output logic [5:0] P
);

endmodule
```

&ensp;

<div align="center">
  <img width="577" height="237" alt="image" src="https://github.com/user-attachments/assets/002420ea-a401-4e59-9639-341ad0d5cfec" />
</div>

