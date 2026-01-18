function nvm_default_check
    if type -q npm
        # npm is somehow in the path, nvm might not be in use
        return
    end

    if not type -q nvm
        # nvm isn't installed, no point checking
        return
    end

    set -l versions $nvm_data/*

    if count $versions >/dev/null && ! set -q nvm_default_version
        echo "WARNING: nvm list reports versions installed, but no default is set. Recommendation:"
        echo "  set -U nvm_default_version" (path basename $versions[1])
    end
end
