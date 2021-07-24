function template 
    switch $argv[1]
        case -m
            cat ~/templates/main.cpp | cat > $argv[2]
        case -st
            cat ~/cp/templates/segment_tree.cpp | cat > $argv[2]
        case -ft
            cat ~/cp/templates/fenwick_tree.cpp | cat > $argv[2]
        case '*'
            echo Please specify a valid flag.
    end
end
