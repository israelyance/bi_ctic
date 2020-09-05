create table TMP_DATA_CLIENTE(
    periodo varchar2(50),
    tip_reg varchar2(50),
    cod_sbs_cli varchar2(50),
    fec_reporte varchar2(50),
    tip_doc_tri varchar2(50),
    ruc   varchar2(50),
    tip_doc_ide  varchar2(50),
    doc_identidad  varchar2(50),
    tip_persona  varchar2(50),
    tip_empresa  varchar2(50),
    can_empresa varchar2(50),
    deu_calif0 varchar2(50),
    deu_calif1 varchar2(50),
    deu_calif2 varchar2(50),
    deu_calif3 varchar2(50),
    deu_calif4 varchar2(50),
    raz_soc_o_ap varchar2(50),
    ape_materna varchar2(50),
    ape_casada varchar2(50),
    nombre1 varchar2(50),
    nombre2 varchar2(50)
);

--delete from TMP_DATA_CLIENTE where periodo = 'periodo' ;

select * from (select * from TMP_DATA_CLIENTE)
where rownum <=100;


-- drop table HA_CLIENTES

create table HA_CLIENTES(
HCL_PER_COD_SBS             varchar2(50),
HCL_PERIODO                 varchar2(6), 
HCL_COD_SBS_CLIENTE         varchar2(10),
HCL_FECHA_REPORTE           date,
HCL_TIPO_DOC_EMPRESA        char(1),
HCL_RUC                     varchar2(15),
HCL_COD_TIPO_DOC_PERSONA    char(1),
HCL_DOCUMENTO_PERSONA       varchar2(12),
HCL_TIPO_PERSONA            char(1),
HCL_TIPO_EMPRESA            char(1),
HCL_NUM_EMPRESAS_REPORTADO  smallint,
HCL_DEUDA_CALIF_NORMAL      number,
HCL_DEUDA_CALIF_CPP         number,
HCL_DEUDA_CALIF_DEFICIENTE  number,
HCL_DEUDA_CALIF_DUDOSO      number,
HCL_DEUDA_CALIF_PERDIDA     number
);

select count(*) from HA_CLIENTES;

--select  *  from (
select * from HA_CLIENTES
where rownum <=10 ;


select *  from HA_CLIENTES;


insert into  HA_CLIENTES (HCL_PER_COD_SBS,HCL_PERIODO,HCL_COD_SBS_CLIENTE,HCL_FECHA_REPORTE,HCL_TIPO_DOC_EMPRESA,HCL_RUC,HCL_COD_TIPO_DOC_PERSONA,HCL_DOCUMENTO_PERSONA,
                          HCL_TIPO_PERSONA,HCL_TIPO_EMPRESA,HCL_NUM_EMPRESAS_REPORTADO,HCL_DEUDA_CALIF_NORMAL,HCL_DEUDA_CALIF_CPP,HCL_DEUDA_CALIF_DEFICIENTE,
						  HCL_DEUDA_CALIF_DUDOSO,HCL_DEUDA_CALIF_PERDIDA)
select 
       periodo  ||'-'||  Cod_Sbs_Cli PER_COD_SBS
     , periodo
	 , Cod_Sbs_Cli
     , to_char( substr(Fec_Reporte,7,2) ||'/'||substr(Fec_Reporte,5,2) ||'/'||substr(Fec_Reporte,1,4)) FECHA_REPORTE	
	 , nvl(cast(Tip_Doc_Tri as char(1)) , ' ') Tip_Doc_Tri
	 , nvl(RUC,' ') RUC
	 , nvl(Tip_Doc_Ide,' ') Tip_Doc_Ide
	 , nvl(Doc_Identidad,' ') Doc_Identidad
 	 , nvl(Tip_Persona,' ')Tip_Persona
	 , nvl(Tip_Empresa,' ') Tip_Empresa
	 , cast(Can_Empresa as int) Can_Empresa
	 , CAST(REPLACE(Deu_Calif0,'.',',') AS NUMBER )Deu_Calif0
	 , CAST(REPLACE(Deu_Calif1,'.',',') AS NUMBER )Deu_Calif1
	 , CAST(REPLACE(Deu_Calif2,'.',',') AS NUMBER )Deu_Calif2
	 , CAST(REPLACE(Deu_Calif3,'.',',') AS NUMBER )Deu_Calif3
	 , CAST(REPLACE(Deu_Calif4,'.',',') AS NUMBER )Deu_Calif4
from  TMP_DATA_CLIENTE ;

select  CURRENT_TIMESTAMP from dual;

 -- truncate table PRO_CLIENTES

select *  from ( select  * from HA_CLIENTES) 
where rownum <= 2 ;


select count(*) from (
select 
row_number() over(partition by HCL_PER_COD_SBS order by HCL_PER_COD_SBS) orden,
HCL_PER_COD_SBS
 from HA_CLIENTES 
) t  where t.orden>1
;



select distinct FECHA_REPORTE from HA_CLIENTES;



SELECT COUNT (*) FROM TMP_DATA_CLIENTE;


SELECT COUNT(*) FROM TMP_DATA_CLIENTE;