# SPDX-License-Identifier: GPL-2.0-only
#
# Copyright (C) 2012-2015 OpenWrt.org
# Copyright (C) 2016 LEDE Project

# Substituted by SDK, do not remove
# REVISION:=x
# SOURCE_DATE_EPOCH:=x
# BASE_FILES_VERSION:=x
# KERNEL_VERSION:=x
# LIBC_VERSION:=x

PKG_CONFIG_DEPENDS += \
	CONFIG_VERSION_HOME_URL \
	CONFIG_VERSION_BUG_URL \
	CONFIG_VERSION_NUMBER \
	CONFIG_VERSION_CODE \
	CONFIG_VERSION_REPO \
	CONFIG_VERSION_DIST \
	CONFIG_VERSION_MANUFACTURER \
	CONFIG_VERSION_MANUFACTURER_URL \
	CONFIG_VERSION_PRODUCT \
	CONFIG_VERSION_SUPPORT_URL \
	CONFIG_VERSION_FIRMWARE_URL \
	CONFIG_VERSION_HWREV \

sanitize = $(call tolower,$(subst _,-,$(subst $(space),-,$(1))))

VERSION_NUMBER:=$(call qstrip,$(CONFIG_VERSION_NUMBER))
VERSION_NUMBER:=$(if $(VERSION_NUMBER),$(VERSION_NUMBER),工作室)

VERSION_CODE:=$(call qstrip,$(CONFIG_VERSION_CODE))
VERSION_CODE:=$(if $(VERSION_CODE),$(VERSION_CODE),$(REVISION))

VERSION_REPO:=$(call qstrip,$(CONFIG_VERSION_REPO))
VERSION_REPO:=$(if $(VERSION_REPO),$(VERSION_REPO),https://downloads.immortalwrt.org/snapshots)

VERSION_DIST:=$(call qstrip,$(CONFIG_VERSION_DIST))
VERSION_DIST:=$(if $(VERSION_DIST),$(VERSION_DIST),HWO)
VERSION_DIST_SANITIZED:=$(call sanitize,$(VERSION_DIST))

VERSION_MANUFACTURER:=$(call qstrip,$(CONFIG_VERSION_MANUFACTURER))
VERSION_MANUFACTURER:=$(if $(VERSION_MANUFACTURER),$(VERSION_MANUFACTURER),HWO)

VERSION_MANUFACTURER_URL:=$(call qstrip,$(CONFIG_VERSION_MANUFACTURER_URL))
VERSION_MANUFACTURER_URL:=$(if $(VERSION_MANUFACTURER_URL),$(VERSION_MANUFACTURER_URL),https://immortalwrt.org/)

VERSION_BUG_URL:=$(call qstrip,$(CONFIG_VERSION_BUG_URL))
VERSION_BUG_URL:=$(if $(VERSION_BUG_URL),$(VERSION_BUG_URL),https://github.com/immortalwrt/immortalwrt/issues)

VERSION_HOME_URL:=$(call qstrip,$(CONFIG_VERSION_HOME_URL))
VERSION_HOME_URL:=$(if $(VERSION_HOME_URL),$(VERSION_HOME_URL),https://immortalwrt.org/)

VERSION_SUPPORT_URL:=$(call qstrip,$(CONFIG_VERSION_SUPPORT_URL))
VERSION_SUPPORT_URL:=$(if $(VERSION_SUPPORT_URL),$(VERSION_SUPPORT_URL),https://github.com/immortalwrt/immortalwrt/discussions)

VERSION_FIRMWARE_URL:=$(call qstrip,$(CONFIG_VERSION_FIRMWARE_URL))
VERSION_FIRMWARE_URL:=$(if $(VERSION_FIRMWARE_URL),$(VERSION_FIRMWARE_URL),https://downloads.immortalwrt.org/)

VERSION_PRODUCT:=$(call qstrip,$(CONFIG_VERSION_PRODUCT))
VERSION_PRODUCT:=$(if $(VERSION_PRODUCT),$(VERSION_PRODUCT),Generic)

VERSION_HWREV:=$(call qstrip,$(CONFIG_VERSION_HWREV))
VERSION_HWREV:=$(if $(VERSION_HWREV),$(VERSION_HWREV),v0)

define taint2sym
$(CONFIG_$(firstword $(subst :, ,$(subst +,,$(subst -,,$(1))))))
endef

define taint2name
$(lastword $(subst :, ,$(1)))
endef

VERSION_TAINT_SPECS := \
	-ALL_KMODS:no-all \
	-IPV6:no-ipv6 \
	+USE_GLIBC:glibc \
	+USE_MKLIBS:mklibs \
	+BUSYBOX_CUSTOM:busybox \
	+OVERRIDE_PKGS:override \

VERSION_TAINTS := $(strip $(foreach taint,$(VERSION_TAINT_SPECS), \
	$(if $(findstring +,$(taint)), \
		$(if $(call taint2sym,$(taint)),$(call taint2name,$(taint))), \
		$(if $(call taint2sym,$(taint)),,$(call taint2name,$(taint))) \
	)))

PKG_CONFIG_DEPENDS += $(foreach taint,$(VERSION_TAINT_SPECS),$(call taint2sym,$(taint)))

# escape commas, backslashes, squotes, and ampersands for sed
define sed_escape
$(subst &,\&,$(subst $(comma),\$(comma),$(subst ','\'',$(subst \,\\,$(1)))))
endef
#'

VERSION_SED_SCRIPT:=$(SED) 's,%U,$(call sed_escape,$(VERSION_REPO)),g' \
	-e 's,%V,$(call sed_escape,$(VERSION_NUMBER)),g' \
	-e 's,%v,\L$(call sed_escape,$(subst $(space),_,$(VERSION_NUMBER))),g' \
	-e 's,%C,$(call sed_escape,$(VERSION_CODE)),g' \
	-e 's,%c,\L$(call sed_escape,$(subst $(space),_,$(VERSION_CODE))),g' \
	-e 's,%D,$(call sed_escape,$(VERSION_DIST)),g' \
	-e 's,%d,\L$(call sed_escape,$(subst $(space),_,$(VERSION_DIST))),g' \
	-e 's,%R,$(call sed_escape,$(REVISION)),g' \
	-e 's,%T,$(call sed_escape,$(BOARD)),g' \
	-e 's,%S,$(call sed_escape,$(BOARD)/$(SUBTARGET)),g' \
	-e 's,%A,$(call sed_escape,$(ARCH_PACKAGES)),g' \
	-e 's,%t,$(call sed_escape,$(VERSION_TAINTS)),g' \
	-e 's,%M,$(call sed_escape,$(VERSION_MANUFACTURER)),g' \
	-e 's,%m,$(call sed_escape,$(VERSION_MANUFACTURER_URL)),g' \
	-e 's,%b,$(call sed_escape,$(VERSION_BUG_URL)),g' \
	-e 's,%u,$(call sed_escape,$(VERSION_HOME_URL)),g' \
	-e 's,%s,$(call sed_escape,$(VERSION_SUPPORT_URL)),g' \
	-e 's,%f,$(call sed_escape,$(VERSION_FIRMWARE_URL)),g' \
	-e 's,%P,$(call sed_escape,$(VERSION_PRODUCT)),g' \
	-e 's,%h,$(call sed_escape,$(VERSION_HWREV)),g' \
	-e 's,%B,$(call sed_escape,$(SOURCE_DATE_EPOCH)),g'
