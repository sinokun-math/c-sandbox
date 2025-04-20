# Root Makefile

# Directories
CLI_DIR := cli
EXPERIMENT_DIR := experiments
COMPOSED_DIR := composed

# Output directory
BIN := bin

# Targets for CLI apps
CLI_SUBDIRS := $(wildcard $(CLI_DIR)/*)
CLI_TARGETS := $(notdir $(CLI_SUBDIRS))
CLI_BIN_DIR := $(BIN)/cli

# Targets for composed apps
COMPOSED_SUBDIRS := $(wildcard $(COMPOSED_DIR)/*)
COMPOSED_TARGETS := $(notdir $(COMPOSED_SUBDIRS))
COMPOSED_BIN_DIR := $(BIN)/composed

# Target for experiments
EXPERIMENT_TARGETS := $(wildcard $(EXPERIMENT_DIR)/*.c)
EXPERIMENT_BIN_DIR := $(BIN)/experiments

# Default target: build everything
.PHONY: all
all: $(CLI_TARGETS) experiments composed

# Pattern rule: build CLI apps by delegating to their Makefiles
$(CLI_TARGETS):
	@$(MAKE) -C $(CLI_DIR)/$@ $@

# Build all experiments (each .c file becomes an executable)
.PHONY: experiments
experiments:
	@mkdir -p ${EXPERIMENT_BIN_DIR}
	@for file in $(wildcard $(EXPERIMENT_DIR)/*.c); do \
  		name=$$(basename $$file .c); \
  		echo "Compiling $$file -> ${EXPERIMENT_BIN_DIR}/$$name"; \
		gcc -o ${EXPERIMENT_BIN_DIR}/$${name} $${file}; \
	done

# Build all composed apps (each has its own Makefile)
.PHONY: composed
composed:
	@mkdir -p bin/composed
	@for dir in $(COMPOSED_SUBDIRS); do \
		echo "Building composed app: $$name"; \
		$(MAKE) -C $$dir; \
	done

# Cliean all builds
.PHONY: clean
clean:
	@echo "Cleaning all builds..."
	@rm -rf bin
	@for dir in $(CLI_SUBDIRS) $(COMPOSED_SUBDIRS); do \
		echo "Cleaning $$dir"; \
		$(MAKE) -C $$dir clean; \
	done








