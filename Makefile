GITHUB_DIR = github/

.PHONY: all
all:
	mkdir $(GITHUB_DIR)

.PHONY: clean
clean:
	rm -rf $(GITHUB_DIR)
