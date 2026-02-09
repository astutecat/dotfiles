abbr -a gc git commit
abbr -a gca git commit -a
abbr -a gcam git commit -a -m
abbr -a gco git checkout
abbr -a gpft git push --follow-tags
abbr -a gp git push
abbr -a ga git add
abbr -a gpf git fpush
abbr -a gsw git switch
abbr -a j just
abbr -a .j just -g
abbr -a .just just -g
abbr -a e eza

abbr -a lg lazygit
abbr -a lj lazyjj

abbr -a adr adrs

abbr -a la eza -a
abbr -a lal eza -al
abbr -a ll eza -l
abbr -a lt eza -al --sort=modified

abbr -a zj zellij

abbr -a qm qman


abbr -a jst        'jj status'
abbr -a jsh        'jj show'
abbr -a jshs       'jj show --summary'
abbr -a jl         'jj log'
abbr -a jb         'jj bookmark'
abbr -a jbc        'jj bookmark create'
abbr -a jbd        'jj bookmark delete'
abbr -a jbm        'jj bookmark move'
abbr -a jbm@       'jj bookmark move --to @'
abbr -a jcl        'jj git clone --colocate'
abbr -a jclo       'jj git clone --colocate --remote upstream'
abbr -a jd         'jj desc'
abbr -a jdm        'jj desc -m'
abbr -a jdf        'jj diff'
abbr -a jdg        'jj diff --git'
abbr -a je         'jj edit'
abbr -a jfa        'jj git fetch --all-remotes'
abbr -a jf         'jj git fetch'
abbr -a jp         'jj git push'
abbr -a jpa        'jj git push --all'
abbr -a jpb        'jj git push --bookmark'
abbr -a jpc        'jj git push --change'
abbr -a jpd        'jj git push --deleted'
abbr -a jn         'jj new'
abbr -a jna        'jj new -A'
abbr -a jnb        'jj new -B'
abbr -a jnn        'jj new --no-edit'
abbr -a jnna       'jj new --no-edit -A'
abbr -a jnnb       'jj new --no-edit -B'
abbr -a jsq        'jj squash'
abbr -a jgr        'jj git remote'
abbr -a jgra       'jj git remote add'
abbr -a jgrl       'jj git remote list'
abbr -a jrb        'jj rebase'
abbr -a jrbr       'jj rebase -r'
abbr -a jrbs       'jj rebase -s'
abbr -a ja         'jj abandon'

function last_history_item
    echo $history[1]
end
abbr -a !! --position anywhere --function last_history_item
