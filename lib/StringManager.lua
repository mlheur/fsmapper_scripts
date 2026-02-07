local StringManager = {}

function StringManager.getFirstTwoWords(sInputString)
    local nFirstSpace = string.find(sInputString," ")
    if nFirstSpace == nil then return end

    local sFirstWord = string.sub(sInputString,1,nFirstSpace-1)
    local sFirstTwoWords = sInputString
    local nSecondSpace = string.find(sInputString," ",nFirstSpace+1)
    if nSecondSpace ~= nil then sFirstTwoWords = string.sub(sInputString,1,nSecondSpace-1) end

    return sFirstWord,sFirstTwoWords
end

return StringManager