select DB_NOTA_CLIENTE as Cliente,
        db_cliente.db_cli_nome as Cliente_nome,
        db_cliente.DB_CLI_ESTADO as uf,
        db_cliente.DB_CLI_REGIAOCOM as Regiao,
        mtb01.TB01_DESCR as Regiao_nome,
        db_cliente.DB_CLI_RAMATIV as GrupoCliente,
        DB_TB_RAMO_ATIV.DB_TBATV_descricao as GrupoClientes_nome,
        DB_NOTA_PED_ORIG as PedidoSAP,
        DB_NOTA_PED_MERC as PedidoMerc,
        DB_NOTA_NRO as Nota,
        DB_NOTA_SERIE as Serie,
        round(sum(DB_NOTA_PROD.DB_NOTAP_VALOR),2) as ValorProd,
        round(sum(DB_NOTA_PROD.DB_NOTAP_VALOR) * 0.01,2) as comissao,
        DB_NOTA_REPRES as Repres,
        DB_TB_REPRES.DB_TBREP_NOME as Repres_nome,
        DB_NOTA_DT_EMISSAO as DataEmis,
        db_pedido_compl.DB_PEDC_USU_CRIA as Digitador
from DB_NOTA_FISCAL,
     DB_NOTA_PROD,
     DB_CLIENTE,
     DB_TB_REPRES,
     DB_PEDIDO_COMPL,
     DB_TB_RAMO_ATIV,
     mtb01
where DB_NOTA_FISCAL.DB_NOTA_NRO = DB_NOTA_PROD.DB_NOTAP_NRO
and db_nota_fiscal.DB_NOTA_SERIE = db_nota_prod.DB_NOTAP_SERIE
and DB_NOTA_DT_EMISSAO >= '2021-01-01' 
and DB_NOTA_OPERACAO = 'YBMO'
and db_cliente.DB_CLI_CODIGO = db_nota_fiscal.DB_NOTA_CLIENTE
and DB_TB_REPRES.DB_TBREP_CODIGO = DB_NOTA_FISCAL.DB_NOTA_REPRES
and DB_PEDIDO_COMPL.DB_PEDC_NRO = DB_NOTA_FISCAL.DB_NOTA_PED_MERC
and DB_TB_RAMO_ATIV.DB_TBATV_CODIGO = db_cliente.DB_CLI_RAMATIV
and mtb01.TB01_CODIGO = db_cliente.DB_CLI_REGIAOCOM
and DB_PEDIDO_COMPL.DB_PEDC_USU_CRIA in (select USUARIO from DB_USUARIO where GRUPO_USUARIO = '3')
group by DB_NOTA_CLIENTE,
        DB_NOTA_PED_ORIG,
        DB_NOTA_PED_MERC,
        DB_NOTA_NRO,
        DB_NOTA_SERIE,
        DB_NOTA_REPRES,
        DB_NOTA_DT_EMISSAO,
        db_cliente.db_cli_nome,
        db_cliente.DB_CLI_ESTADO,
        db_cliente.DB_CLI_REGIAOCOM,
        DB_TB_REPRES.DB_TBREP_NOME,
        db_pedido_compl.DB_PEDC_USU_CRIA,
        db_cliente.DB_CLI_RAMATIV,
        DB_TB_RAMO_ATIV.DB_TBATV_descricao,
        mtb01.TB01_DESCR
