QBCore = exports['qb-core']:GetCoreObject()

Config = {}

Config.Enable = {}
Config.Timer = {}
Config.Locale = 'en'

-- Sets waypoint on map to most recent call and attachs you to the call. 
Config.RespondsKey = "E"

-- Enable if you only want to send alerts to onDuty officers
Config.OnDutyOnly = true

Config.PhoneModel = 'prop_npc_phone_02'

-- sets report chance to 100%
Config.DebugChance = true

-- Explosion Alert Types (Gas Pumps by default)
-- Ex.  Config.ExplosionTypes = {1, 2, 3, 4, 5}
Config.ExplosionTypes = {9}

-- Enable default alerts
Config.Enable.Speeding = true
Config.Enable.Shooting = true
Config.Enable.Autotheft = true
Config.Enable.Melee = true
Config.Enable.PlayerDowned = true

-- Enable alerts when cops break the law, also prints to console.
Config.Debug = true

-- Changes the min and max offset for the radius
Config.MinOffset = 1
Config.MaxOffset = 120

-- Locations for the Hunting Zones and No Dispatch Zones( Label: Name of Blip // Radius: Radius of the Alert and Blip)
Config.Locations = {
    ["hunting"] = {
        [1] = {label = "Hunting Zone", radius = 250.0, coords = vector3(-1339.05, -3044.38, 13.94)},
    },
    ["NoDispatch"] = {
        [1] = {label = "Ammunation 1", coords = vector3(13.53, -1097.92, 29.8), length = 14.0, width = 5.0, heading = 70, minZ = 28.8, maxZ = 32.8},
        [2] = {label = "Ammunation 2", coords = vector3(821.96, -2163.09, 29.62), length = 14.0, width = 5.0, heading = 270, minZ = 28.62, maxZ = 32.62},
    },
}

Config.AuthorizedJobs = {
    LEO = { -- this is for job checks which should only return true for police officers
        Jobs = {['police'] = true, ['fib'] = true, ['sheriff'] = true},
        Types = {['police'] = true, ['leo'] = true},
        Check = function(PlyData)
            PlyData = PlyData or QBCore.Functions.GetPlayerData()
            if not PlyData or (PlyData and (not PlyData.job or not PlyData.job.type))  then return false end
            local job, jobtype = PlyData.job.name, PlyData.job.type
            if Config.AuthorizedJobs.LEO.Jobs[job] or Config.AuthorizedJobs.LEO.Types[jobtype] then return true end
        end
    },
    EMS = { -- this if for job checks which should only return true for ems workers
        Jobs = {['ambulance'] = true, ['fire'] = true},
        Types = {['ambulance'] = true, ['fire'] = true, ['ems'] = true},
        Check = function(PlyData)
            PlyData = PlyData or QBCore.Functions.GetPlayerData()
            if not PlyData or (PlyData and (not PlyData.job or not PlyData.job.type))  then return false end
            local job, jobtype = PlyData.job.name, PlyData.job.type
            if Config.AuthorizedJobs.EMS.Jobs[job] or Config.AuthorizedJobs.EMS.Types[jobtype] then return true end
        end
    },
    FirstResponder = { -- do not touch, this is a combined job checking function for emergency services (police and ems)
        Check = function(PlyData)
            PlyData = PlyData or QBCore.Functions.GetPlayerData()
            if not PlyData or (PlyData and (not PlyData.job or not PlyData.job.type))  then return false end
            local job, jobtype = PlyData.job.name, PlyData.job.type
            if Config.AuthorizedJobs.LEO.Check(PlyData, jobtype, job) or Config.AuthorizedJobs.EMS.Check(PlyData, jobtype, job) then return true end            
        end
    }
}

for k, v in pairs(Config.Enable) do
    print(k, v, json.encode(v))
    if Config.Enable[k] then
        Config[k] = {}
        Config.Timer[k] = 0 -- Default to 0 seconds
        Config[k].Success = 30 -- Default to 30 seconds
        Config[k].Fail = 2 -- Default to 2 seconds
    end
end

-- If you want to set specific timers, do it here
if Config.Shooting then
    Config.Shooting.Success = 10 -- 10 seconds
    Config.Shooting.Fail = 0 -- 0 seconds
end

if Config.PlayerDowned then
    Config.PlayerDowned.Success = 5 -- 5 seconds 
    Config.Shooting.Fail = 0 -- 0 seconds
end

Config.WeaponBlacklist = {
    'WEAPON_GRENADE',
    'WEAPON_BZGAS',
    'WEAPON_MOLOTOV',
    'WEAPON_STICKYBOMB',
    'WEAPON_PROXMINE',
    'WEAPON_SNOWBALL',
    'WEAPON_PIPEBOMB',
    'WEAPON_BALL',
    'WEAPON_SMOKEGRENADE',
    'WEAPON_FLARE',
    'WEAPON_PETROLCAN',
    'WEAPON_FIREEXTINGUISHER',
    'WEAPON_HAZARDCAN',
    'WEAPON_RAYCARBINE',
    'WEAPON_STUNGUN'
}

Config.Colours = {
    ['0'] = "金屬黑",
    ['1'] = "金屬石墨黑",
    ['2'] = "金屬黑鋼色",
    ['3'] = "金屬深銀色",
    ['4'] = "金屬銀色",
    ['5'] = "金屬藍銀色",
    ['6'] = "金屬鋼灰色",
    ['7'] = "金屬影子銀",
    ['8'] = "金屬石頭銀",
    ['9'] = "金屬午夜銀",
    ['10'] = "金屬槍砲金屬色",
    ['11'] = "金屬煤灰灰色",
    ['12'] = "霧面黑色",
    ['13'] = "霧面灰色",
    ['14'] = "霧面淺灰色",
    ['15'] = "實用黑色",
    ['16'] = "實用黑色聚合物",
    ['17'] = "實用深銀色",
    ['18'] = "實用銀色",
    ['19'] = "實用槍砲金屬色",
    ['20'] = "實用影子銀",
    ['21'] = "磨損的黑色",
    ['22'] = "磨損的石墨",
    ['23'] = "磨損的銀灰色",
    ['24'] = "磨損的銀色",
    ['25'] = "磨損的藍銀色",
    ['26'] = "磨損的影子銀",
    ['27'] = "金屬紅色",
    ['28'] = "金屬都靈紅",
    ['29'] = "金屬公式紅",
    ['30'] = "金屬火焰紅",
    ['31'] = "金屬優雅紅",
    ['32'] = "金屬石榴紅",
    ['33'] = "金屬沙漠紅",
    ['34'] = "金屬卡本內紅",
    ['35'] = "金屬糖果紅",
    ['36'] = "金屬日出橙",
    ['37'] = "金屬經典金",
    ['38'] = "金屬橙色",
    ['39'] = "霧面紅色",
    ['40'] = "霧面深紅色",
    ['41'] = "霧面橙色",
    ['42'] = "霧面黃色",
    ['43'] = "實用紅色",
    ['44'] = "實用亮紅色",
    ['45'] = "實用石榴紅",
    ['46'] = "磨損的紅色",
    ['47'] = "磨損的金紅色",
    ['48'] = "磨損的深紅色",
    ['49'] = "金屬深綠色",
    ['50'] = "金屬賽車綠",
    ['51'] = "金屬海綠色",
    ['52'] = "金屬橄欖綠",
    ['53'] = "金屬綠色",
    ['54'] = "金屬汽油藍綠色",
    ['55'] = "霧面萊姆綠",
    ['56'] = "實用深綠色",
    ['57'] = "實用綠色",
    ['58'] = "磨損的深綠色",
    ['59'] = "磨損的綠色",
    ['60'] = "磨損的海洗",
    ['61'] = "金屬午夜藍",
    ['62'] = "金屬深藍色",
    ['63'] = "金屬薩克森藍",
    ['64'] = "金屬藍色",
    ['65'] = "金屬航海藍",
    ['66'] = "金屬港灣藍",
    ['67'] = "金屬鑽石藍",
    ['68'] = "金屬衝浪藍",
    ['69'] = "金屬海軍藍",
    ['70'] = "金屬亮藍色",
    ['71'] = "金屬紫藍色",
    ['72'] = "金屬斯皮納克藍",
    ['73'] = "金屬超藍色",
    ['74'] = "金屬亮藍色",
    ['75'] = "實用深藍色",
    ['76'] = "實用午夜藍",
    ['77'] = "實用藍色",
    ['78'] = "實用海泡藍",
    ['79'] = "實用閃電藍",
    ['80'] = "實用茂伊藍色聚合物",
    ['81'] = "實用亮藍色",
    ['82'] = "霧面深藍色",
    ['83'] = "霧面藍色",
    ['84'] = "霧面午夜藍",
    ['85'] = "磨損的深藍色",
    ['86'] = "磨損的藍色",
    ['87'] = "磨損的淺藍色",
    ['88'] = "金屬出租車黃",
    ['89'] = "金屬比賽黃",
    ['90'] = "金屬青銅色",
    ['91'] = "金屬黃鳥",
    ['92'] = "金屬萊姆",
    ['93'] = "金屬香檳色",
    ['94'] = "金屬普韋布羅米色",
    ['95'] = "金屬深象牙色",
    ['96'] = "金屬巧克力棕色",
    ['97'] = "金屬金棕色",
    ['98'] = "金屬淺棕色",
    ['99'] = "金屬稻草米色",
    ['100'] = "金屬苔蘚棕色",
    ['101'] = "金屬比斯通棕色",
    ['102'] = "金屬山毛櫸",
    ['103'] = "金屬深山毛櫸",
    ['104'] = "金屬巧克力橙色",
    ['105'] = "金屬海灘沙色",
    ['106'] = "金屬曬黑沙",
    ['107'] = "金屬奶油色",
    ['108'] = "實用棕色",
    ['109'] = "實用中等棕色",
    ['110'] = "實用淺棕色",
    ['111'] = "金屬白色",
    ['112'] = "金屬霜白色",
    ['113'] = "磨損的蜜色米色",
    ['114'] = "磨損的棕色",
    ['115'] = "磨損的深棕色",
    ['116'] = "磨損的稻草米色",
    ['117'] = "刷鋼",
    ['118'] = "刷黑鋼",
    ['119'] = "刷鋁",
    ['120'] = "鉻",
    ['121'] = "磨損的灰白色",
    ['122'] = "實用灰白色",
    ['123'] = "磨損的橙色",
    ['124'] = "磨損的淺橙色",
    ['125'] = "金屬保安綠",
    ['126'] = "磨損的出租車黃色",
    ['127'] = "警車藍",
    ['128'] = "霧面綠色",
    ['129'] = "霧面棕色",
    ['130'] = "磨損的橙色",
    ['131'] = "霧面白色",
    ['132'] = "磨損的白色",
    ['133'] = "磨損的橄欖軍綠",
    ['134'] = "純白色",
    ['135'] = "亮粉紅色",
    ['136'] = "鮭魚粉紅色",
    ['137'] = "金屬朱紅粉紅色",
    ['138'] = "橙色",
    ['139'] = "綠色",
    ['140'] = "藍色",
    ['141'] = "金屬黑藍色",
    ['142'] = "金屬黑紫色",
    ['143'] = "金屬黑紅色",
    ['144'] = "深獵人綠色",
    ['145'] = "金屬紫色",
    ['146'] = "金屬深藍色",
    ['147'] = "黑色",
    ['148'] = "霧面紫色",
    ['149'] = "霧面深紫色",
    ['150'] = "金屬熔岩紅",
    ['151'] = "霧面森林綠",
    ['152'] = "霧面橄欖綠",
    ['153'] = "霧面沙漠棕",
    ['154'] = "霧面沙漠棕褐",
    ['155'] = "霧面葉綠",
    ['156'] = "默認合金色",
    ['157'] = "伊普西龍藍",
    ['158'] = "純金",
    ['159'] = "刷砂金",
    ['160'] = "MP100"
}
