function fish_theme_dump_colorful
    fish_config theme dump | while read -at line
        if [ (count $line) -eq 1 ]
            echo "$line (NOP)"
            continue
        end

        echo -n (set_color $line[2..])$line[1](set_color normal)
        # Echo the whole line again:
        # * Show the parameters
        # * Show the name of the color, in case it was shown in black
        echo ' '$line
    end
end
