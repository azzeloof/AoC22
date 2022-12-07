mutable struct Dir
    name
    parent
    contents
end

mutable struct File
    name
    parent
    size
end

function isNumber(a)
    try 
        parse(Int, a)
        true
    catch
        false
    end
end

function build(lines)
    root = Dir("/", nothing, [])
    wd = root
    for line in lines
        if line[1:4] == "\$ cd"
            if line[6] == '.'
                wd = wd.parent
            else
                name = line[6:end]
                new = Dir(name, wd, [])
                wd.contents = push!(wd.contents, new)
                wd = wd.contents[end]
            end
        elseif isNumber(line[1])
            parsed = split(line)
            f = File(parsed[2], wd, parse(Int, parsed[1]))
            wd.contents = push!(wd.contents, f)
        end
    end
    root
end

function analyze(fs, dirs)
    size = 0
    if isa(fs, Dir)
        for entry in fs.contents
            (subSize, dirs) = analyze(entry, dirs)
            size = size + subSize
        end
        if size >= 572957
            dirs = push!(dirs, (fs.name, size))
        end
    else
        size = fs.size
    end
    (size, dirs)
end

open("input.txt") do file
    input = String[]
    for ln in eachline(file)
        push!(input,ln)
    end
    fs = build(input[2:end])
    (~, dirs) = analyze(fs, [])
    
    minSize = 99999999999999
    finalDir = nothing
    for dir in dirs
        wd = dir[1]
        size = dir[2]
        if size < minSize
            finalDir = wd
            minSize = size
        end
    end
    println((finalDir, minSize))
end

