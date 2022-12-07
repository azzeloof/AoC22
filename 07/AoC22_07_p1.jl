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

function analyze(fs, sum)
    size = 0
    if isa(fs, Dir)
        for entry in fs.contents
            (subSize, sum) = analyze(entry, sum)
            size = size + subSize
        end
        if size < 100000
            sum = sum + size
        end
    else
        size = fs.size
    end
    (size, sum)
end

open("input.txt") do file
    input = String[]
    for ln in eachline(file)
        push!(input,ln)
    end
    fs = build(input[2:end])
    (~, sum) = analyze(fs, 0)
    println(sum)
end

