select id_tempo,
id_elemento,
id_item,
id_programa,
id_acao,
id_unidade_orc,
id_favorecido,
id_empenho,
id_tipo_documento,
tp_operacao,
cd_documento,
cd_evento,
dt_anomes,
ano_particao,
vr_empenhado,
vr_liquidado,
vr_pago
from ft_diarias
where ano_particao = 2008

