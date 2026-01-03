if type -q direnv
    direnv hook fish | source
else
    # 2. If NOT installed, check for .envrc files in the current dir
    # This function runs every time you change directories
    function __check_direnv_missing --on-variable PWD
        if test -f .envrc
            set_color yellow
            echo "⚠️ Found .envrc, but 'direnv' is not installed, so not loading"
            set_color normal
        end
    end
end
