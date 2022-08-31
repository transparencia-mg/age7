# Validações Conjuntos AGE7

Validação realizada em: **{{ frictionless.Resource("logs/validate/failed_reports.json")['formated_date'] }}**

{% if frictionless.Resource("logs/validate/failed_reports.json")['valid'] == True  %}
Todos os recursos válidos: **Sim**
{% else  %}
Todos os recursos válidos: **Não**
{{ "## Recursos com erros" }}
{{ "```yaml report" }}
{{ "descriptor: logs/validate/failed_reports.json" }}
{{ "```" }}
{% endif %}