select id_tempo,
id_categ_econ,
id_grupo,
id_elemento,
id_item,
id_fonte,
id_modalidade_aplic,
id_unidade_orc,
id_favorecido,
id_empenho,
id_tipo_documento,
ano_origem,
cd_evento,
tp_operacao,
cd_documento,
nr_ordem,
dt_documento,
ano_particao,
vr_nao_processado,
vr_processado,
vr_pago
from ft_restos_pagar
where ano_particao = 2025

