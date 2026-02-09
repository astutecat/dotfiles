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

abbr -a --command jj aba abandon
abbr -a --command jj abs absorb
abbr -a --command jj b bookmark
abbr -a --command jj desc describe
abbr -a --command jj r redo
abbr -a --command jj u undo
abbr -a --command jj g git
abbr -a --command={jj,git,hg} st status

function last_history_item
    echo $history[1]
end
abbr -a !! --position anywhere --function last_history_item
