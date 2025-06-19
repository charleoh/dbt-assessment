{% test valid_date_range(model, valid_from_column='valid_from', valid_to_column='valid_to') %}

    select *
    from {{ model }}
    where 
        {{ valid_to_column }} is not null 
        and {{ valid_to_column }} <= {{ valid_from_column }}

{% endtest %}