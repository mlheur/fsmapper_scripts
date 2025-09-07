local mgr = {}

function mgr.add_mappings(model,mapper_device)
    if model == nil then return end
    mapper.print("Trying to load mappings for model=["..model.."] device=["..mapper_device.name.."]")
    for input_name,event_map in pairs(mapper_device.map) do
        mapper.print("Found input name=["..input_name.."]")
        for action_name,model_map in pairs(event_map) do
            mapper.print("Found action name=["..action_name.."]")
            if model_map[model] ~= nil then
                mapper.print(
                    "Adding device event map,"..
                    " input:["..input_name.."]"..
                    " action:["..action_name.."]"
                )
                mapper.add_secondary_mappings({{
                    event  = mapper_device.device.events[input_name][action_name],
                    action = model_map[model]
                }})
            end
        end
    end
end

function mgr.reset_device(profile,mapper_device)
    if mapper_device.device ~= nil then
        mapper_device.device:close()
    end
    for key,value in pairs(mapper_device.profiles) do
        if profile == key then
            mapper.print("Found custom profile ["..profile.."] for mapper device name=["..mapper_device.name.."]")
            mapper_device.device = mapper.device(mapper_device.profiles[profile])
            return
        end
    end
    -- else
    mapper.print("Using the default profile for mapper device name=["..mapper_device.name.."]")
    mapper_device.device = mapper.device(mapper_device.profiles[0])
end

return mgr