box.once('20170306-init_product_space_3', function()
    box.schema.create_space('product', { if_not_exists = true })
    box.space.product:create_index('primary', { type = 'tree', parts = { 1, 'unsigned' }, if_not_exists = true })
end)
