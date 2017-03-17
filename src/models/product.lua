local avro = require('avro_schema')
local log = require('log')

local Product = {}

Product.datetime_format = '%Y-%m-%d %H:%M:%S'

local schema = {
    user = {
        type = "record",
        name = "product",
        fields = {
            { name = "id", type = "long" }, -- 1
            { name = "name", type = "string" }, -- 2
            { name = "vendor_code", type = "string" }, -- 3
            { name = "created_at", type = "string" }, -- 4
            { name = "is_deleted", type = "boolean" }
        }
    }
}

Product.update_schema = schema.update_schema

local ok_u, product = avro.create(schema.user)
if ok_u then
    local ok_cp, compiled_product = avro.compile(product)
    if ok_cp then
        Product.model = compiled_product
    else
        log.error('Product schema compilation failed')
        return compiled_product
    end
else
    log.error("User schema creation failed")
    return product
end


return Product