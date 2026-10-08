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

### Описание мультиплексора через индексацию по вектору 

В данном случае нам так же, как и ранее даются 2 информационных входа, один управляющий, а также предоставляется выход, информацию с выбранного входа на который мы отправляем:

```systemverilog
module multiplexer_2_1_vector (
    input  logic IN0,
    input  logic IN1,
    input  logic SEL,

    output logic OUT
);
```

Только вот теперь, помимо данной нам заранее информации, мы создаём вектор, каждому биту которого присваиваем вход:

```systemverilog
    logic [1:0] IN;     // Создали вектор

    assign IN[0] = IN0; // Нулевому биту вектора присвоили вход IN0
    assign IN[1] = IN1; // Первому биту вектора присвоили вход IN1
```

Подготовив все организационные моменты, совершаем операцию мультиплексирования:

```systemverilog
    assign OUT = IN[SEL];
```

В результате получаем следующий модуль:

```systemverilog
module multiplexer_2_1_vector (
    input  logic IN0,
    input  logic IN1,
    input  logic SEL,

    output logic OUT
);
    logic [1:0] IN;     // Создали вектор

    assign IN[0] = IN0; // Нулевому биту вектора присвоили вход IN0
    assign IN[1] = IN1; // Первому биту вектора присвоили вход IN1

    assign OUT = IN[SEL];

endmodule
```