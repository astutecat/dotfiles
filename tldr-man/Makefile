VPATH = $(wildcard tldr/pages/*)
SOURCE_PATHS = $(wildcard tldr/pages/*/*.md)
SOURCE_FILES = $(notdir $(SOURCE_PATHS))
OUTPUT_DIR = man1
MAN_FILES = $(SOURCE_FILES:.md=.1)
MAN_PATHS = $(addprefix $(OUTPUT_DIR)/,$(MAN_FILES))

.PHONY: tldr-man
tldr-man: update-tldr $(OUTPUT_DIR) $(MAN_PATHS)

$(OUTPUT_DIR):
	mkdir -p $(OUTPUT_DIR)

$(OUTPUT_DIR)/%.1: %.md
	@sed 's/^> //; s/^`/	`/' $< > $<.tmp
	@pandoc --standalone -f markdown -t man -o $@ $<.tmp
	@rm $<.tmp

tldr:
	git clone https://github.com/tldr-pages/tldr.git
	@echo "Generating makefiles..."
	@$(MAKE)

.PHONY: update-tldr, clean
update-tldr: tldr
	@cd tldr; git pull

clean:
	rm $(OUTPUT_DIR)/*.1
