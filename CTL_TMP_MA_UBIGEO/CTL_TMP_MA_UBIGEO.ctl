OPTIONS (SKIP=1)
LOAD DATA
INFILE "DATA_UBIGEO.txt"
TRUNCATE PRESERVE BLANKS
INTO TABLE TMP_MA_UBIGEO
fields terminated by '	'
trailing nullcols
(
Ubigeo,
Departamento,
Provincia,
Distrito,
Codigo,
distrito_det,
FlgZona,
CENTROSNEGOCIO,
FLGPROVCENTROSNEGOCIO,
distrito_agg,
FlgCiudad
)