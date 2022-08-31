SELECT dc.id_contratado,
	   dc.tp_documento,
CASE WHEN dc.tp_documento = 1 THEN
    CONCAT('***', SUBSTR(CONCAT(REPEAT('0', 11 - LENGTH(dc.nr_documento)), nr_documento), 4, 6), '**')
    ELSE dc.nr_documento
    END nr_documento_anonimizado,
    dc.nome_anonimizado
from dm_contratado dc

-- 11 - LENGTH(dc.nr_documento): Utilizado para definir quantos 0 a esquerda estavam faltando para completar os 11 dígitos do CPF
-- REPEAT('0', 11 - LENGTH(dc.nr_documento)): Repete '0' pela quantidade que faltante, definida na fórmula anterior
-- CONCAT(REPEAT('0', 11 - LENGTH(dc.nr_documento)), nr_documento): Acrescenta o número de '0' criados (faltantes) ao número original do CPF
-- SUBSTR(CONCAT(REPEAT('0', 11 - LENGTH(dc.nr_documento)), nr_documento), 4, 6): Do campo de CPF completo, extrai apenas os 6 números do meio ou extrai os três primeiros e os dois últimos
-- CONCAT('***', SUBSTR(CONCAT(REPEAT('0', 11 - LENGTH(dc.nr_documento)), nr_documento), 4, 6), '**'): Concatena três asteriscos no início e dois no fim do campo de CPF 'fatiado' na função acima
