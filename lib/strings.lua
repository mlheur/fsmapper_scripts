local mgr = {}

function mgr.get_first_two_words(input)
    local first_space = string.find(input," ")
    if first_space == nil then return end

    local first_word = string.sub(input,1,first_space-1)
    local first_two_words = input
    local second_space = string.find(input," ",first_space+1)
    if second_space ~= nil then first_two_words = string.sub(input,1,second_space-1) end

    return first_word,first_two_words
end

return mgr