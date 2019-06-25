
#-----------------------|DOCUMENTATION|-----------------------#
# @descr: Makefile for project construction.
# @example:
#	
#		$ make list-environment
#   OR
#       $ make  run-environment
#
#   OR
#       $ make list-personalize
#   OR
#       $ make  run-personalize
#
#   OR
#       $ make help
#   OR
#       $ make version
#-------------------------------------------------------------#

# DEFAULT VARIABLES - Structural
RUN_DIVINE_CREATION  ?= ./start-divine-creation.sh

SETTINGS_ENV_FILE    ?= ./settings-environment.json
SETTINGS_CUSTOM_FILE ?= ./settings-personalize.json


# Environment
list-environment:
	@bash $(RUN_DIVINE_CREATION) --setting-file='$(SETTINGS_ENV_FILE)' --list;

run-environment:
	@bash $(RUN_DIVINE_CREATION) --setting-file='$(SETTINGS_ENV_FILE)' --run;

# Personalize
list-personalize:
	@bash $(RUN_DIVINE_CREATION) --setting-file='$(SETTINGS_CUSTOM_FILE)' --list;

run-personalize:
	@bash $(RUN_DIVINE_CREATION) --setting-file='$(SETTINGS_CUSTOM_FILE)' --run;

# Informative
version:
	@bash $(RUN_DIVINE_CREATION) --version;

help:
	@bash $(RUN_DIVINE_CREATION) --help;
