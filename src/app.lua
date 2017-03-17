----
---- Created by IntelliJ IDEA.
---- User: a.romanov
---- Date: 01/03/2017
---- Time: 2:10 AM
---- To change this template use File | Settings | File Templates.
----
--
box.cfg{}

package.path = './?.lua;' .. package.path
local migrations = require('migrations.manager')

-- Workaround for bad loaded dependency for socket

function bootstrap()
    migrations.reload()
end

function reload()
    package.loaded['services.product_service'] = nil
    ps = require('services.product_service')
    return true
end

bootstrap()
reload()

require('web.rest_api').start()
