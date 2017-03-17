--
-- Author: ivan
-- Date: 01.02.17
--

local Manager = {}

Manager.reload = function()
    package.loaded['migrations.20170306-initdb'] = nil
    require('migrations.20170306-initdb')
end

return Manager



