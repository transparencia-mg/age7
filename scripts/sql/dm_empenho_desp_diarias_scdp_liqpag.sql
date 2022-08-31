select id_empenho,
ano_exercicio,
nr_empenho,
dt_empenho,
unidade_executora,
tipo_empenho,
vr_empenho,
cd_uni_prog_gasto,
uni_prog_gasto
from dm_empenho_desp
where id_empenho in (select id_empenho from ft_diarias_scdp_liqpag)

