--
-- Author: Arkady
-- Date: 13.03.17
--

local log = require('log')

local http_server = require('http.server')

local httpd

local function set_up()

    httpd:route({ path = '/products' }, require('controllers.product').product_list)
    httpd:route({ path = '/products/:id' }, require('controllers.product').handle_product)
    --    httpd:route({ path = '/menu/nodes' }, require('controllers.menu').node)
    --    httpd:route({ path = '/menu/items/:id' }, require('controllers.menu').item)
    --    httpd:route({ path = '/menu/items' }, require('controllers.menu').item)
end

local HttpD = {}

HttpD.start = function()
    httpd = http_server.new('0.0.0.0', tonumber(8181))
    set_up()
    httpd:start()
end

HttpD.stop = function()
    httpd:stop()
end

return HttpD