local log = require('log')
local json = require('json')
local product_service = require('services.product_service')

local p = {}
p.product_list = function(req)
    if req.method == 'POST' then
        local p_t = req:json()
        local ok, p = product_service:create(p_t['name'], p_t['vendor_code'])
        return {
            status = 201,
            headers = { ['content-type'] = 'application/json; charset=utf8' },
            body = json.encode(p)
        }
    elseif req.method == 'GET' then
        local ok, plist = product_service:get_all()
        return {
            status = 200,
            headers = { ['content-type'] = 'application/json; charset=utf8' },
            body = json.encode(plist)
        }
    else
        return {
            status = 405,
            headers = { ['content-type'] = 'text/plain; charset=utf8' },
            body = "Not supported"
        }
    end
end

p.handle_product = function(req)
    if req.method == 'GET' then

        local ok, p = product_service:get(tonumber(req:stash('id')))
        if ok then
            return {
                status = 200,
                headers = { ['content-type'] = 'application/json; charset=utf8' },
                body = json.encode(p)
            }
        else
            return {
                status = 404
            }
        end
    elseif req.method == 'PUT' then
        return p.edit_product(req)
    elseif req.method == 'DELETE' then
        return p.delete_product(req)
    end
end

p.delete_product = function(req)
    local ok, p = product_service:delete(tonumber(req:stash('id')))
    if ok then
        return { status = 204 }
    else
        return { status = 404 }
    end
end

p.edit_product = function(req)
    local ok, p = product_service:edit(tonumber(req:stash('id')), req:json())
    if ok then
        return {
            status = 200,
            headers = { ['content-type'] = 'application/json; charset=utf8' },
            body = json.encode(p)
        }
    else
        return {
            status = 404
        }
    end
end

return p
