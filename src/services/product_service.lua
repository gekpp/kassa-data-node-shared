--
-- Created by IntelliJ IDEA.
-- User: a.romanov
-- Date: 06/03/2017
-- Time: 11:42 PM
-- To change this template use File | Settings | File Templates.
--
local log = require('log')
local json = require('json')
local product_model = require('models.product').model
local product_model_update = require('models.product').update_schema

return {
    -- get Avro product
    get = function(self, id)
        if not id then
            return false, 'Id is requred'
        end
        return product_model.unflatten(box.space.product.index.primary:select(id)[1])
    end,

    --get all
    get_all = function(self)
        return true,box.space.product.index.primary:select()
    end,

    -- returns Avro model
    create = function(self, name, vendor_code)
        return product_model.unflatten(box.space.product:auto_increment({ name, vendor_code, os.date('%Y-%m-%d %H:%M:%S'), false }))
    end,


    -- product serialized Agro model
    update_product = function(self, product)
        local ok, xfl_record = product_model.xflatten(product, product_model_update)
        return product_model.unflatten(box.space.product:update(product.id, xfl_record))
    end,

    -- edit product
    edit = function(self, id, product_table)
        local ok, p = self:get(id)
        if not ok then return ok end

        for k, v in pairs(product_table) do
            p[k] = v
        end
        local ok, xfl_record = product_model.xflatten(p, product_model_update)
        return product_model.unflatten(box.space.product:update(p.id, xfl_record))
    end,

    -- soft delete
    delete = function(self, id)
        local ok, product = self:get(id)
        if not ok then return ok end

        product.is_deleted = true
        local ok, xfl_record = product_model.xflatten(product, product_model_update)
        return product_model.unflatten(box.space.product:update(product.id, xfl_record))
    end
}

