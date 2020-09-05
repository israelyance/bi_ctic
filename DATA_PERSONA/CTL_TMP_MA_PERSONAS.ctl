LOAD DATA
INFILE "DATA_PERSONA.txt"
TRUNCATE PRESERVE BLANKS
INTO TABLE TMP_MA_PERSONAS
fields terminated by '|'
trailing nullcols
(
NumDoc,
DigVer,
GrpVot,
Ubigeo,
ApPaterno,
ApMaterno,
Nombres,
FecNac,
Sexo
)
