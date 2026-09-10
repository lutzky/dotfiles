#!/bin/sh
# Bemenu wrapper
# Generated with Matugen

BEMENU_OPTS="--tb '{{colors.on_primary_fixed.default.hex}}' \
--tf '{{colors.primary_fixed.default.hex}}' \
--fb '{{colors.on_primary_fixed.default.hex}}' \
--ff '{{colors.primary_fixed.default.hex}}' \
--nb '{{colors.on_primary_fixed.default.hex}}' \
--nf '{{colors.primary_fixed.default.hex}}' \
--ab '{{colors.on_primary_fixed.default.hex}}' \
--af '{{colors.primary_fixed.default.hex}}' \
--hb '{{colors.primary.default.hex}}' \
--hf '{{colors.on_primary.default.hex}}' \
--sb '{{colors.surface.default.hex}}' \
--sf '{{colors.primary.default.hex}}' \
--scb '{{colors.surface.default.hex}}' \
--scf '{{colors.secondary.default.hex}}' \
-l 20 -b -i" exec /usr/bin/bemenu "$@"
