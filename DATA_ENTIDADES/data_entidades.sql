

CREATE TABLE  TMP_ENTIDAD_FINANCIERA(
codempre VARCHAR(50),
banco VARCHAR2(100),
bnk VARCHAR2(50),
tipo VARCHAR2(50),
TipoCompetencia VARCHAR2(50),
TipoCompetencia2 VARCHAR2(50)
);

select count(*) from TMP_ENTIDAD_FINANCIERA

CREATE TABLE  MA_ENTIDAD_FINANCIERA(
MEF_CODENTIDAD CHAR(5),
MEF_BANCO VARCHAR2(100),
MEF_BANCO_CORTO VARCHAR2(40),
MEF_TIP_ENTIDAD VARCHAR2(50),
MEF_TIPO_COMPETENCIA VARCHAR2(40),
MEF_TIPO_COMPETENCIA_2 VARCHAR2(40)
);

select * from MA_ENTIDAD_FINANCIERA

INSERT INTO MA_ENTIDAD_FINANCIERA 
SELECT codempre,banco,bnk,tipo,TipoCompetencia,TipoCompetencia2
FROM TMP_ENTIDAD_FINANCIERA;

SELECT * FROM MA_ENTIDAD_FINANCIERA;


