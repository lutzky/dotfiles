#!/bin/sh
# Bemenu wrapper
# Generated with Matugen

BEMENU_OPTS="--tb '{{colors.surface.default.hex}}' \
--tf '{{colors.primary.default.hex}}' \
--fb '{{colors.surface.default.hex}}' \
--ff '{{colors.on_surface.default.hex}}' \
--nb '{{colors.surface.default.hex}}' \
--nf '{{colors.on_surface.default.hex}}' \
--hb '{{colors.primary.default.hex}}' \
--hf '{{colors.on_primary.default.hex}}' \
--sb '{{colors.surface.default.hex}}' \
--sf '{{colors.primary.default.hex}}' \
--scb '{{colors.surface.default.hex}}' \
--scf '{{colors.secondary.default.hex}}' \
-l 20 -b -i" exec /usr/bin/bemenu "$@"
