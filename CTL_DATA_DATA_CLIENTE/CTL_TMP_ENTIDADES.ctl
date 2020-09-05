OPTIONS (SKIP=1)
LOAD DATA
INFILE "DATA_CLIENTE.txt"
TRUNCATE PRESERVE BLANKS
INTO TABLE TMP_DATA_CLIENTE
fields terminated by '|'
trailing nullcols
(
    periodo,
    tip_reg,
    cod_sbs_cli,
    fec_reporte,
    tip_doc_tri,
    ruc,
    tip_doc_ide,
    doc_identidad,
    tip_persona,
    tip_empresa,
    can_empresa,
    deu_calif0,
    deu_calif1,
    deu_calif2,
    deu_calif3,
    deu_calif4,
    raz_soc_o_ap,
    ape_materna,
    ape_casada,
    nombre1,
    nombre2

)
