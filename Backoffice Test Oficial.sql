with 

start as (
    SELECT distinct
    user_id,
    cast(data_horario_do_status as date) as purchase_date,
    data_horario_do_status as start_time
    from status
    where status = 'pending_kyc'
),

finish as (
    SELECT distinct
    user_id,
    data_horario_do_status as end_time
    from status
    where status = 'approved'
),

final as (
    select distinct
        c.cnpj,
        st.purchase_date,
        CONVERT(varchar, DATEDIFF(n, st.start_time, f.end_time)/60) + ':' + replace(RIGHT('0' + CONVERT(varchar, (DATEDIFF(n, st.start_time, f.end_time)%60)), 2),'-','0') as time_it_took,
        DATEDIFF(minute, st.start_time, f.end_time) as time_in_min
    from clientes c
    left join status s on s.user_id = c.user_id
    left join start st on st.user_id = c.user_id
    left join finish f on f.user_id = c.user_id
)

select distinct
    cnpj,
    purchase_date,
    time_it_took,
    time_in_min
from final

;

with 

start as (
    SELECT distinct
    user_id,
    cast(data_horario_do_status as date) as purchase_date,
    data_horario_do_status as start_time
    from status
    where status = 'pending_kyc'
),

finish as (
    SELECT distinct
    user_id,
    data_horario_do_status as end_time
    from status
    where status = 'approved'
),

final as (
    select distinct
        DATEDIFF(minute, st.start_time, f.end_time) as raw_dif_time
    from clientes c
    left join status s on s.user_id = c.user_id
    left join start st on st.user_id = c.user_id
    left join finish f on f.user_id = c.user_id
),

contas as (
select distinct
avg(raw_dif_time) as avg_approval_minute,
min(raw_dif_time) as min_approval_minute,
max(raw_dif_time) as max_approval_minute
from final
)

select distinct
(CONVERT(varchar, (avg_approval_minute/60)) + ':' + RIGHT('0' + CONVERT(varchar, (avg_approval_minute%60)), 2)) as avg_approval_time,
avg_approval_minute,
(CONVERT(varchar, (min_approval_minute/60)) + ':' + RIGHT('0' + CONVERT(varchar, (min_approval_minute%60)), 2)) as min_approval_time,
min_approval_minute,
(CONVERT(varchar, (max_approval_minute/60)) + ':' + RIGHT('0' + CONVERT(varchar, (max_approval_minute%60)), 2)) as max_approval_time,
max_approval_minute
from contas

;

with 

pending as (
    SELECT distinct
    user_id,
    data_horario_do_status as check_pending
    from status
    where status = 'pending_purchase'
),

start as (
    SELECT distinct
    user_id,
    data_horario_do_status as check_purchase,
    data_horario_do_status as start_time
    from status
    where status = 'pending_kyc'
),

finish as (
    SELECT distinct
    user_id,
    data_horario_do_status as check_approved,
    data_horario_do_status as end_time
    from status
    where status = 'approved'
),

final as (
    select distinct
        c.user_id,
        c.cnpj,
        c.nome_do_cliente,
        check_pending,
        check_purchase,
        check_approved,
        CONVERT(varchar, DATEDIFF(n, st.start_time, f.end_time)/60) + ':' + replace(RIGHT('0' + CONVERT(varchar, (DATEDIFF(n, st.start_time, f.end_time)%60)), 2),'-','0') as time_it_took,
        DATEDIFF(minute, st.start_time, f.end_time) as time_in_min
    from clientes c
    left join status s on s.user_id = c.user_id
    left join start st on st.user_id = c.user_id
    left join finish f on f.user_id = c.user_id
    left join pending p on p.user_id = c.user_id
)

select distinct
    user_id,
    cnpj,
    nome_do_cliente,
    --check_pending,
    check_purchase,
    check_approved,
    time_it_took,
    time_in_min
from final
where time_in_min < 0

;

select distinct
*
from clientes c 
left join status s on s.user_id = c.user_id
where c.user_id in ('845038','908341','908341','986307')

;

with 

start as (
    SELECT distinct
    user_id,
    cast(data_horario_do_status as date) as purchase_date,
    data_horario_do_status as start_time,
    row_number() over (partition by user_id order by data_horario_do_status desc) as rowno
    from status
    where status = 'pending_kyc'
),

finish as (
    SELECT distinct
    user_id,
    data_horario_do_status as end_time,
    row_number() over (partition by user_id order by data_horario_do_status desc) as rowno
    from status
    where status = 'approved'
),

final as (
    select distinct
        c.cnpj,
        st.purchase_date,
        CONVERT(varchar, DATEDIFF(n, st.start_time, f.end_time)/60) + ':' + replace(RIGHT('0' + CONVERT(varchar, (DATEDIFF(n, st.start_time, f.end_time)%60)), 2),'-','0') as time_it_took,
        DATEDIFF(minute, st.start_time, f.end_time) as time_in_min
    from clientes c
    left join status s on s.user_id = c.user_id
    left join start st on st.user_id = c.user_id and st.rowno = 1
    left join finish f on f.user_id = c.user_id and f.rowno = 1
)

select distinct
    cnpj,
    purchase_date,
    time_it_took,
    time_in_min
from final

;

with 

start as (
    SELECT distinct
    user_id,
    cast(data_horario_do_status as date) as purchase_date,
    data_horario_do_status as start_time,
    row_number() over (partition by user_id order by data_horario_do_status desc) as rowno
    from status
    where status = 'pending_kyc'
),

finish as (
    SELECT distinct
    user_id,
    data_horario_do_status as end_time,
    row_number() over (partition by user_id order by data_horario_do_status desc) as rowno
    from status
    where status = 'approved'
),

final as (
    select distinct
        DATEDIFF(minute, st.start_time, f.end_time) as raw_dif_time
    from clientes c
    left join status s on s.user_id = c.user_id
    left join start st on st.user_id = c.user_id and st.rowno = 1
    left join finish f on f.user_id = c.user_id and f.rowno = 1
),

contas as (
select distinct
avg(raw_dif_time) as avg_approval_minute,
min(raw_dif_time) as min_approval_minute,
max(raw_dif_time) as max_approval_minute
from final
)

select distinct
(CONVERT(varchar, (avg_approval_minute/60)) + ':' + RIGHT('0' + CONVERT(varchar, (avg_approval_minute%60)), 2)) as avg_approval_time,
avg_approval_minute,
(CONVERT(varchar, (min_approval_minute/60)) + ':' + RIGHT('0' + CONVERT(varchar, (min_approval_minute%60)), 2)) as min_approval_time,
min_approval_minute,
(CONVERT(varchar, (max_approval_minute/60)) + ':' + RIGHT('0' + CONVERT(varchar, (max_approval_minute%60)), 2)) as max_approval_time,
max_approval_minute
from contas