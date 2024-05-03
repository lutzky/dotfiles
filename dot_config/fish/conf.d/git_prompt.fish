set -g __fish_git_prompt_show_informative_status 1
set -g __fish_git_prompt_showcolorhints 1

# Avoid wide characters
set -g __fish_git_prompt_char_cleanstate   '✓' # Default: ✔ 
set -g __fish_git_prompt_char_dirtystate   '🞢' # Default: ✚ 
set -g __fish_git_prompt_char_invalidstate '✕' # Default: ✖
set -g __fish_git_prompt_char_stashstate   '⚑' # Default: ⚑
set -g __fish_git_prompt_char_stagedstate  '●' # Default: ●
