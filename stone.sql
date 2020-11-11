drop database stone;
create database stone;
use stone;

create table stone_vendas (
stone_id      bigint(20) unsigned,
loja          int unsigned,
hora          datetime,
tipo          char(15),
bandeira      char(20),
meio_capitura char(20),
valor_bruto   decimal(15,2),
valor_liquido decimal(15,5),
cartao        char(20),
serial_number char(8),
status        char(10),
status_data   datetime,
stone_code    int unsigned,
primary key (stone_id));



LOAD DATA LOCAL INFILE 'StoneMatrizVendas20191105ate20201105.csv'
 INTO TABLE stone_vendas
 FIELDS TERMINATED BY ';' enclosed by '"'
 LINES TERMINATED BY '\n'
 IGNORE 1 LINES
(@var_hora, tipo, bandeira, meio_capitura, stone_id, @var_valor_bruto, @var_valor_liquido,cartao,serial_number,status,@status_data,stone_code)
set hora= STR_TO_DATE(@var_hora,'%d/%m/%Y %H:%i:%s'),
    status_data=STR_TO_DATE(@status_data,'%d/%m/%Y %H:%i:%s'),
    valor_bruto = replace(@var_valor_bruto, ',', '.'),
    valor_liquido = replace(@var_valor_liquido, ',', '.'),
    loja=1;
show warnings;

select * from stone_vendas limit 10;

select STR_TO_DATE('17/04/2020 16:59:44', '%d/%m/%Y %H:%i:%s');

drop table if exists stone_pagamentos;
create table stone_pagamentos (
stone_id      bigint(20) unsigned,
stone_code int unsigned,
documento char(18),
nome_fantasia varchar(250),
categoria char(20),
hora_venda datetime,
data_vencimento date,
tipo char(10),
parcela int(2) unsigned,
parcelas int(2) unsigned,
bandeira char(20),
cartao        char(20),
valor_bruto   decimal(15,6),
valor_liquido decimal(15,6),
desconto_antecipacao decimal(15,6),
desconto_mdr decimal(15,6),
status char(10),
status_data   datetime);

LOAD DATA LOCAL INFILE 'StoneMatrizPagamentos20191105ate20201105.csv'
 INTO TABLE stone_pagamentos
 FIELDS TERMINATED BY ';' enclosed by '"'
 LINES TERMINATED BY '\n'
 IGNORE 1 LINES
(stone_code,documento,nome_fantasia,categoria,
@var_hora_venda,@var_data_vencimento,tipo,parcela,parcelas,bandeira,stone_id,cartao,
@var_valor_bruto,@var_valor_liquido,@var_desconto_antecipacao,@var_desconto_mdr,
status,@var_status_data)
set hora_venda= STR_TO_DATE(@var_hora_venda,'%d/%m/%Y %H:%i:%s'),
    data_vencimento = STR_TO_DATE(@var_data_vencimento,'%d/%m/%Y'),
    status_data=STR_TO_DATE(@var_status_data,'%d/%m/%Y %H:%i:%s'),
    valor_bruto = replace(@var_valor_bruto, ',', '.'),
    valor_liquido = replace(@var_valor_liquido, ',', '.'),
    desconto_antecipacao = replace(@var_desconto_antecipacao, ',', '.'),
    desconto_mdr = replace(@var_desconto_mdr, ',', '.');

show warnings;
select * from stone_pagamentos limit 10;

