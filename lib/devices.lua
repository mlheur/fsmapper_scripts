local mgr = {}

function mgr.add_mappings(model,mapper_device)
    for input_name,event_map in pairs(mapper_device.map) do
        for action_name,model_map in pairs(event_map) do
            if model_map[model] == nil then return end
            mapper.print(
                "Adding device event map,"..
                " device:["..mapper_device.name.."]"..
                " model:["..model.."]"..
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

return mgr