
----------------------------------------------------------------------------------------------------------------------------

--- QUERY DIM CLIENTE
drop table DIM_CLIENTE;

create table DIM_CLIENTE as
select a.HCL_PER_COD_SBS PER_COD_SBS ,
cast(a.HCL_PERIODO as char(6))            PERIODO,
a.HCL_COD_SBS_CLIENTE    COD_SBS_CLIENTE ,
case 
when HCL_TIPO_PERSONA=1  then 'Persona Natural'
when HCL_TIPO_PERSONA=2  then 'Persona Juridica'
when HCL_TIPO_PERSONA=3  then 'Persona Mancomunadas'
when HCL_TIPO_PERSONA=4  then 'Patrimonios fideicometidos y vehiculos de proposito especial' 
else 'Otros' end TIPO_PERSONA,
a.HCL_NUM_EMPRESAS_REPORTADO NUM_EMPR_REPORTADO,
case
 when a.hcl_deuda_calif_normal > a.HCL_DEUDA_CALIF_CPP    and a.hcl_deuda_calif_normal>a.HCL_DEUDA_CALIF_DEFICIENTE and a.hcl_deuda_calif_normal>a.HCL_DEUDA_CALIF_DUDOSO and a.hcl_deuda_calif_normal>a.HCL_DEUDA_CALIF_PERDIDA then 'Normal'
 when a.HCL_DEUDA_CALIF_CPP    > a.hcl_deuda_calif_normal and a.HCL_DEUDA_CALIF_CPP > a.HCL_DEUDA_CALIF_DEFICIENTE  and a.HCL_DEUDA_CALIF_CPP>a.HCL_DEUDA_CALIF_DUDOSO   and  a.HCL_DEUDA_CALIF_CPP >  a.HCL_DEUDA_CALIF_PERDIDA then 'CPP'
 when a.HCL_DEUDA_CALIF_DEFICIENTE > a.hcl_deuda_calif_normal and a.HCL_DEUDA_CALIF_DEFICIENTE>a.HCL_DEUDA_CALIF_CPP and a.HCL_DEUDA_CALIF_DEFICIENTE>a.HCL_DEUDA_CALIF_DUDOSO and a.HCL_DEUDA_CALIF_DEFICIENTE>a.HCL_DEUDA_CALIF_PERDIDA then 'Deficiente'
 when a.HCL_DEUDA_CALIF_DUDOSO>a.hcl_deuda_calif_normal and a.HCL_DEUDA_CALIF_DUDOSO>a.HCL_DEUDA_CALIF_CPP and a.HCL_DEUDA_CALIF_DUDOSO>a.HCL_DEUDA_CALIF_DEFICIENTE and  a.HCL_DEUDA_CALIF_DUDOSO>a.HCL_DEUDA_CALIF_PERDIDA  then   'Dudoso'
 when a.HCL_DEUDA_CALIF_PERDIDA >a.hcl_deuda_calif_normal and a.HCL_DEUDA_CALIF_PERDIDA>a.HCL_DEUDA_CALIF_CPP and a.HCL_DEUDA_CALIF_PERDIDA>a.HCL_DEUDA_CALIF_DEFICIENTE and a.HCL_DEUDA_CALIF_PERDIDA> a.HCL_DEUDA_CALIF_DUDOSO then 'Pérdida'
 else 'Normal'end Clasificacion,

b.MPE_GRPVOT  GRUPO_VOTACION,
b.MPE_UBIGEO  UBIGEO,
b.MPE_FECNAC  FECNAC, 
case when MPE_SEXO=1 then 'Masculino' else 'Femenimo' end SEXO,
TRUNC((  TO_NUMBER(a.HCL_PERIODO||'01') -  TO_NUMBER(TO_CHAR(MPE_FECNAC,'YYYYMMDD') ) ) / 10000) AS Edad_Periodo
from H_CLIENTES a left join MA_PERSONAS b on a.HCL_DOCUMENTO_PERSONA=b.MPE_NUMDOC ;

select * from DIM_CLIENTE;

----------------------------------------------------------------------------------------------------------------------------

--DIM SUBPRODUCTO
drop table DIM_SUBPRODUCTO;

CREATE TABLE DIM_SUBPRODUCTO (
COD_SUBPRODUCTO char(2) ,
COD_PRODUCTO char(5) ,
DESC_COD_SUBPRODUCTO VARCHAR2(50)
)

INSERT INTO DIM_SUBPRODUCTO VALUES (	1	,	100	,	 'Prestamo Pequeña Empresa	 ');
INSERT INTO DIM_SUBPRODUCTO VALUES (	2	,	200	,	 'Prestamo MicroEmpresa');
INSERT INTO DIM_SUBPRODUCTO VALUES (	3	,	300	,	 'Hipotecario Normal');
INSERT INTO DIM_SUBPRODUCTO VALUES (	4	,	300	,	 'Hipotecario MiVivienda');
INSERT INTO DIM_SUBPRODUCTO VALUES (	5	,	400	,	 'Prestamo Efectivo');
INSERT INTO DIM_SUBPRODUCTO VALUES (	6	,	400	,	 'Prestamo Vehicular');
INSERT INTO DIM_SUBPRODUCTO VALUES (	7	,	500	,	 'Saldo Tartjeta de Credito');
INSERT INTO DIM_SUBPRODUCTO VALUES (	8	,	500	,	 'Linea de Tarjeta de Credito');
INSERT INTO DIM_SUBPRODUCTO VALUES (	9	,	600	,	 'Otras Cuentas Contables');


select * from DIM_SUBPRODUCTO;

commit;
----------------------------------------------------------------------------------------------------------------------------

-- DIM PRODUCTO
drop table DIM_PRODUCTO;

CREATE TABLE DIM_PRODUCTO
(
COD_PRODUCTOSBS char(5),
DESC_PRODUCTOSBS VARCHAR2(50)
);

INSERT INTO DIM_PRODUCTO VALUES (	100	,	 'Prestamo Pequeña Empresa');
INSERT INTO DIM_PRODUCTO VALUES (	200	,	 'Prestamo MicroEmpresa');
INSERT INTO DIM_PRODUCTO VALUES (	300	,	 'Prestamo Hipotecario');
INSERT INTO DIM_PRODUCTO VALUES (	400	,	 'Prestamo de Consumo');
INSERT INTO DIM_PRODUCTO VALUES (	500	,	 'Tarjeta de Credito');
INSERT INTO DIM_PRODUCTO VALUES (	600	,	 'Otras Cuentas contables');
COMMIT;


select * from DIM_PRODUCTO;


---------------------------------------------------------------------------------------------------------------
--  FACT SALDO
DROP TABLE FACT_SALDO;

CREATE TABLE FACT_SALDO
(
PERIODO_CODSBS VARCHAR2(50),
PERIODO CHAR(6),
COD_SBS_CLIENTE varchar2(10),
COD_ENTIDAD number,
DIA_ATRASO INT,
MONTO_DEUDA NUMBER(16,2),
COD_SUBPRODUCTO CHAR(2),
FEC_ACTUALIZACION_TABLA DATE
);


INSERT INTO FACT_SALDO (PERIODO_CODSBS,PERIODO,COD_SBS_CLIENTE,COD_ENTIDAD,
DIA_ATRASO,MONTO_DEUDA,COD_SUBPRODUCTO,FEC_ACTUALIZACION_TABLA)
SELECT
HDC_PERIODO||'-'||HDC_COD_SBS_CLIENTE  PERIODO_COD_SBS,
HDC_PERIODO PERIODO,
HDC_COD_SBS_CLIENTE COD_SBS_CLIENTE,
cast(HDC_CODENTIDAD as number)  COD_ENTIDAD,
HDC_CONDICION DIAS_ATRASO,
HDC_SALDO  MONTO_DEUDA,
CASE WHEN SUBSTR(HDC_COD_CUENTA, 4, 1) IN ('1','3', '4', '5', '6' ) AND  SUBSTR(HDC_COD_CUENTA, 1, 2) = '14'  AND  HDC_TIP_CREDITO = '09'     THEN '1' --'PRESTAMO PEQUEÑA EMPRESA' 
     WHEN SUBSTR(HDC_COD_CUENTA, 4, 1) IN ('1','3', '4', '5', '6' ) AND  SUBSTR(HDC_COD_CUENTA, 1, 2) = '14'  AND  HDC_TIP_CREDITO = '10'     THEN '2' --'PRESTAMO MICRO EMPRESA'  
     WHEN SUBSTR(HDC_COD_CUENTA, 4, 1) IN ('1','3', '4', '5', '6' ) AND   SUBSTR(HDC_COD_CUENTA, 1, 2) = '14' AND HDC_TIP_CREDITO = '13'   AND SUBSTR(HDC_COD_CUENTA, 7, 2) NOT IN ( '23', '24', '25')   THEN '3' --'HIPOTECARIO NORMAL'
     WHEN SUBSTR(HDC_COD_CUENTA, 4, 1) IN ('1','3', '4', '5', '6' ) AND  SUBSTR(HDC_COD_CUENTA, 1, 2) = '14'  AND  HDC_TIP_CREDITO = '13'   AND SUBSTR(HDC_COD_CUENTA, 7, 2) IN ( '23', '24', '25')        THEN '4' --'HIPOTECARIO MIVIVIENDA'      
     WHEN SUBSTR(HDC_COD_CUENTA, 4, 1) IN ('1','3', '4', '5', '6' ) AND  SUBSTR(HDC_COD_CUENTA, 1, 2) = '14'  AND  HDC_TIP_CREDITO IN ( '11', '12')   AND SUBSTR(HDC_COD_CUENTA, 7, 2) = '06' AND SUBSTR(HDC_COD_CUENTA, 7, 4) NOT IN '0602'           THEN '5' --'PRESTAMO EFECTIVO'
     WHEN SUBSTR(HDC_COD_CUENTA, 4, 1) IN ('1','3', '4', '5', '6' ) AND   SUBSTR(HDC_COD_CUENTA, 1, 2) = '14' AND HDC_TIP_CREDITO IN ( '11', '12') AND SUBSTR(HDC_COD_CUENTA, 7, 2) = '06' AND SUBSTR(HDC_COD_CUENTA, 7, 4)  IN '0602'  THEN '6' --'PRESTAMO VEHICULAR'      
     WHEN SUBSTR(HDC_COD_CUENTA, 4, 1) IN ('1','3', '4', '5', '6' ) AND  SUBSTR(HDC_COD_CUENTA, 1, 2) = '14'  AND   HDC_TIP_CREDITO IN ( '11', '12')  AND SUBSTR(HDC_COD_CUENTA, 7, 2) = '02'    THEN '7' --'SALDO TARJETA CREDITO'           
     WHEN SUBSTR(HDC_COD_CUENTA, 1, 2) = '81' AND HDC_TIP_CREDITO IN ( '11', '12')   AND SUBSTR(HDC_COD_CUENTA, 4, 3) = '923'         THEN '8' --'LINEA TARJETA CREDITO'
     ELSE '9' --'OTRAS CUENTAS CONTABLES'
     END COD_SUBPRODUCTO,
TRUNC(SYSDATE) 
FROM H_DEUDAS_CLIENTES;

SELECT * FROM FACT_SALDO;

---------------------------------------------------------------------------------------------------------------

-- DIM_TIEMPO

CREATE TABLE DIM_TIEMPO
(
PERIODO CHAR(6),
AÑO     NUMBER,
MES     CHAR(2),
NOM_MES VARCHAR2(20)
)

INSERT INTO DIM_TIEMPO(PERIODO,AÑO,MES,NOM_MES)
SELECT DISTINCT HDC_PERIODO, substr(HDC_PERIODO,1,4) año, substr(HDC_PERIODO,5,2) mes ,
       case 
           when substr(HDC_PERIODO,5,2)= 01 then 'Enero'
           when substr(HDC_PERIODO,5,2)= 02 then 'Febrero'
           when substr(HDC_PERIODO,5,2)= 03 then 'Marzo'
           when substr(HDC_PERIODO,5,2)= 04 then 'Abril'
           when substr(HDC_PERIODO,5,2)= 05 then 'Mayo'
           when substr(HDC_PERIODO,5,2)= 06 then 'Junio'
           when substr(HDC_PERIODO,5,2)= 07 then 'Julio'
           when substr(HDC_PERIODO,5,2)= 08 then 'Agosto'
           when substr(HDC_PERIODO,5,2)= 09 then 'Septiembre'
           when substr(HDC_PERIODO,5,2)= 10 then 'Octubre'
           when substr(HDC_PERIODO,5,2)= 11 then 'Noviembre'
           when substr(HDC_PERIODO,5,2)= 12 then 'Diciembre'
           end NOM_MES
FROM H_DEUDAS_CLIENTES
UNION 
SELECT  DISTINCT HCL_PERIODO ,substr(HCL_PERIODO,1,4) año, substr(HCL_PERIODO,5,2),
case 
           when substr(HCL_PERIODO,5,2)= 01 then 'Enero'
           when substr(HCL_PERIODO,5,2)= 02 then 'Febrero'
           when substr(HCL_PERIODO,5,2)= 03 then 'Marzo'
           when substr(HCL_PERIODO,5,2)= 04 then 'Abril'
           when substr(HCL_PERIODO,5,2)= 05 then 'Mayo'
           when substr(HCL_PERIODO,5,2)= 06 then 'Junio'
           when substr(HCL_PERIODO,5,2)= 07 then 'Julio'
           when substr(HCL_PERIODO,5,2)= 08 then 'Agosto'
           when substr(HCL_PERIODO,5,2)= 09 then 'Septiembre'
           when substr(HCL_PERIODO,5,2)= 10 then 'Octubre'
           when substr(HCL_PERIODO,5,2)= 11 then 'Noviembre'
           when substr(HCL_PERIODO,5,2)= 12 then 'Diciembre'
        end NOM_MES
FROM H_CLIENTES;


SELECT  * FROM DIM_TIEMPO;



---------------------------------------------------------------------------------------------------------------
--- QUERY DE PRUEBA

SELECT * FROM FACT_SALDO;
SELECT * FROM DIM_SUBPRODUCTO;

SELECT B.COD_SUBPRODUCTO,B.DESC_COD_SUBPRODUCTO,SUM(A.MONTO_DEUDA) TOTAL_MONTO 
FROM FACT_SALDO A LEFT JOIN DIM_SUBPRODUCTO B ON A.COD_SUBPRODUCTO = B.COD_SUBPRODUCTO
GROUP BY B.COD_SUBPRODUCTO,B.DESC_COD_SUBPRODUCTO ;
---------------------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------------------

-- DIM ENTIDAD_FINANCIERA


SELECT * FROM MA_ENTIDAD_FINANCIERA;


CREATE TABLE DIM_ENTIDAD_FINANCIERA(
COD_ENTIDAD NUMBER,
BANCO VARCHAR2(100),
BANCO_CORTO  VARCHAR2(100),
TIP_ENTIDAD VARCHAR2(50)
);

INSERT INTO DIM_ENTIDAD_FINANCIERA (COD_ENTIDAD,BANCO,BANCO_CORTO,TIP_ENTIDAD)
SELECT TO_NUMBER(MEF_CODENTIDAD),  MEF_BANCO, MEF_BANCO_CORTO,MEF_TIP_ENTIDAD
FROM MA_ENTIDAD_FINANCIERA;

SELECT * FROM DIM_ENTIDAD_FINANCIERA;

---------------------------------------------------------------------------------------------------------------


-- DIM UBIGEO

CREATE TABLE DIM_UBIGEO(
COD_UBIGEO CHAR(6),
DEPARTAMENTO VARCHAR2(50),
PROVINCIA VARCHAR2(50),
DISTRITO  VARCHAR2(50)
);


INSERT INTO DIM_UBIGEO (COD_UBIGEO,DEPARTAMENTO,PROVINCIA,DISTRITO)
SELECT MUB_UBIGEO, MUB_DEPARTAMENTO, MUB_PROVINCIA, MUB_DISTRITO FROM MA_UBIGEO;


SELECT * FROM DIM_UBIGEO


