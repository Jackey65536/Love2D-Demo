local cx = 0
function drop()
    cx = cx + 1
    print(cx)
end
repeat drop() until cx == 10