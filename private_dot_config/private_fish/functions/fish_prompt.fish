function fish_prompt --description Hydro
    # Use jj prompt in jj repos, otherwise use Hydro's git prompt
    set --local vcs_info ""
    if jj_prompt_is_repo
        set vcs_info (fish_jj_prompt)
    else
        set vcs_info $_hydro_color_git$_hydro_git$hydro_color_normal
    end

    echo -e "$_hydro_color_start$hydro_symbol_start$hydro_color_normal$_hydro_color_pwd$_hydro_pwd$hydro_color_normal $vcs_info $_hydro_color_duration$_hydro_cmd_duration$hydro_color_normal$_hydro_status$hydro_color_normal "
end
