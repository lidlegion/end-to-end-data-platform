{{ config(materialized='table') }}

with source_data as (
    -- Traemos los datos tal cual vienen del origen (minúsculas)
    select * from {{ source('raw_data', 'tbl_ventas_raw') }}
),

renamed as (
    -- Aquí "mapeamos" a los nombres estándar de nuestra arquitectura Sura
    select
        cast(id_venta as INT64) as venta_id,
        upper(trim(nombre_cliente)) as cliente_nombre,
        cast(fecha_venta as DATE) as fecha_venta,
        cast(monto as FLOAT64) as monto_total,
        upper(tipo_seguro) as producto_nombre, -- Mapeamos tipo_seguro a producto_nombre
        upper(sucursal) as sucursal_nombre
    from source_data
)

select * from renamed