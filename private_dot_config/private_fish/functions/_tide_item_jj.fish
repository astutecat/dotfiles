function _tide_item_jj
    if command -sq jj; and jj root --quiet &>/dev/null
        set vcs_info (jj log --ignore-working-copy --no-graph --color always -r @ -T '
            separate(
                " ",
                change_id.shortest(),
                commit_id.shortest(),
                bookmarks.join(", "),
                coalesce(
                    surround(
                        "\"",
                        "\"",
                        if(
                            description.first_line().substr(0, 24).starts_with(description.first_line()),
                            description.first_line().substr(0, 24),
                            description.first_line().substr(0, 23) ++ "…"
                        )
                    ),
                    "(no description set)"
                ),
                if(conflict, "(conflict)"),
                if(empty, "(empty)"),
                if(divergent, "(divergent)"),
                if(hidden, "(hidden)"),
            )
    ')
        _tide_print_item jj $tide_jj_icon $vcs_info
    end
end
