OPTIONS (SKIP=1)
LOAD DATA
INFILE "DATA_DEUDACLIENTE.txt"
TRUNCATE PRESERVE BLANKS
INTO TABLE TMP_H_DEUDAS_CLIENTES
fields terminated by '	'
ENCLOSED BY '"'  
trailing nullcols
(
periodo, 
Tip_Reg, 
Cod_Sbs_Cli, 
Cod_Empresa, 
Tip_Credito, 
Cod_Cuenta, 
Condicion, 
Saldo, 
Clasificacion, 
SitCre, 
Tarj, 
SldVig
)
