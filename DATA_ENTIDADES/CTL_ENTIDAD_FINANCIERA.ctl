OPTIONS (SKIP=1)
LOAD DATA
INFILE "DATA_ENTIDADESFINANCIERAS.txt"
TRUNCATE PRESERVE BLANKS
INTO TABLE TMP_ENTIDAD_FINANCIERA
fields terminated by '	'
trailing nullcols
(
codempre,
banco,
bnk,
tipo,
TipoCompetencia,
TipoCompetencia2
)