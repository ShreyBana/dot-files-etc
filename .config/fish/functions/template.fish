function template 
    switch $argv[1]
        case -m
            set FILE_PATH ~/templates/main.cpp
        case -st
            set FILE_PATH ~/templates/segment_tree.cpp
        case -ft
            set FILE_PATH ~/templates/fenwick_tree.cpp
        case '*'
            echo Please specify a valid flag.
    end
    for arg in $argv[2..-1]
        cat < $FILE_PATH | cat > $arg
    end
end
