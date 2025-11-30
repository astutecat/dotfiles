function source_if_exists -a file
    if test -e $file
        eval $file
    end
end
