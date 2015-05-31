
local mysql_hostname = 'fi.apex.gs' 
local mysql_username = 'billhackweb' 
local mysql_password = '_g4B5djAvCeggAkuG41ejIC46t27ZUc5K8Xy63zkV4wB5hlBwQGPHgQogzBqR' 
local mysql_database = 'billhackweb_aclrp' 
local mysql_port = 3306 


require('mysqloo')

local shouldmysql = false

local db = mysqloo.connect(mysql_hostname, mysql_username, mysql_password, mysql_database, mysql_port)
GhettoDB = db
function db:onConnected()
    MsgN('ACLRP MySQL: Connected! ')
    shouldmysql = true
end

function db:onConnectionFailed(err)
    MsgN('ACLRP MySQL: Connection Failed, please check your settings: ' .. err)
end

db:connect()

PROVIDER.Fallback = 'mysql'


function PROVIDER:GetData(ply, callback)
    if not shouldmysql then return  end
    
    local qs = [[
    SELECT *
    FROM `ACLRP_DATA`
    WHERE uniqueid = '%s'
    ]]
    qs = string.format(qs, ply:UniqueID())
    local q = db:query(qs)
     
    function q:onSuccess(data)
        if #data > 0 then
            local row = data[1]
         
            local info = util.JSONToTable(row or '{}')
 
            callback(info)
        else
            callback({})
        end
    end
     
    function q:onError(err, sql)
        if db:status() ~= mysqloo.DATABASE_CONNECTED then
            db:connect()
            db:wait()
        if db:status() ~= mysqloo.DATABASE_CONNECTED then
            ErrorNoHalt("Re-connection to database server failed.")
            callback({})
            return
            end
        end
        MsgN('ghettogarb MySQL: Query Failed: ' .. err .. ' (' .. sql .. ')')
        q:start()
    end
     
    q:start()
end
--[[


--]]