include $(TOPDIR)/rules.mk
include $(INCLUDE_DIR)/version.mk

PKG_NAME:=ipq-wifi
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL=$(PROJECT_GIT)/project/firmware/qca-wireless.git
PKG_SOURCE_DATE:=2025-06-23
PKG_SOURCE_VERSION:=63bd0faafd4a261deae27bb233e10ae2f216c755
PKG_MIRROR_HASH:=dcdc847e0f6a5655df9018ead35396f4414447b140cbfd3b24dd03514e27cf0e
PKG_FLAGS:=nonshared

include $(INCLUDE_DIR)/package.mk

define Build/Compile
endef

# Use ath10k-bdencoder from https://github.com/qca/qca-swiss-army-knife.git
# to generate the board-* files here.
#
# This is intended to be used on an interim basis until device-specific
# board data for new devices is available through the upstream compilation
#
# Please send a mail with your device-specific board files upstream.
# You can find instructions and examples on the linux-wireless wiki:
# <https://wireless.wiki.kernel.org/en/users/drivers/ath10k/boardfiles>

ALLWIFIBOARDS:= \
	8devices_kiwi \
	8devices_mango \
	alfa-network_ap120c-ax \
	aliyun_ap8220 \
	arcadyan_aw1000 \
	asus_rt-ax89x \
	buffalo_wxr-5950ax12 \
	cambiumnetworks_xe34 \
	cmcc_rm2-6 \
	compex_wpq873 \
	dynalink_dl-wrx36 \
	edgecore_eap102 \
	edimax_cax1800 \
	elecom_wrc-x3000gs2 \
	glinet_gl-ax1800 \
	glinet_gl-axt1800 \
	glinet_gl-b3000 \
	ignitenet_ss-w2-ac2600 \
	iodata_wn-dax3000gr \
	linksys_homewrk \
	linksys_mr5500 \
	linksys_mr7350 \
	linksys_mr7500 \
	linksys_mx2000 \
	linksys_mx4200 \
	linksys_mx5300 \
	linksys_mx5500 \
	linksys_mx8500 \
	linksys_spnmx56 \
	linksys_whw03 \
	netgear_lbr20 \
	netgear_rax120v2 \
	netgear_sxk80 \
	netgear_wax214 \
	netgear_wax218 \
	netgear_wax610 \
	netgear_wax610y \
	netgear_wax620 \
	netgear_wax630 \
	prpl_haze \
	qihoo_360v6 \
	qnap_301w \
	redmi_ax6 \
	skspruce_wia3300-20 \
	spectrum_sax1v1k \
	tplink_deco-x80-5g \
	tplink_eap610od \
	tplink_eap620hd-v1 \
	tplink_eap623od-hd-v1 \
	tplink_eap625od-hd-v1 \
	tplink_eap660hd-v1 \
	tplink_archer-c6-v2 \
	wallys_dr40x9 \
	xiaomi_ax3600 \
	xiaomi_ax6000 \
	xiaomi_ax9000 \
	yyets_le1 \
	yuncore_ax830 \
	yuncore_ax880 \
	yuncore_fap650 \
	zbtlink_zbt-z800ax \
	zte_mf269 \
	zte_mf286ar\
	zte_mf286c \
	zte_mf287 \
	zte_mf287plus \
	zyxel_nbg7815 \
	anysafe_e1 \
	cmiot_ax18 \
	jdcloud_re-ss-01 \
	jdcloud_re-cs-02 \
	jdcloud_re-cs-03 \
	link_nn6000 \
	redmi_ax5 \
	redmi_ax5-jdcloud \
	verizon_cr1000a \
	xiaomi_ax1800 \
	zn_m2

ALLWIFIPACKAGES:=$(foreach BOARD,$(ALLWIFIBOARDS),ipq-wifi-$(BOARD))

define Package/ipq-wifi-default
  SUBMENU:=ath10k Board-Specific Overrides
  SECTION:=firmware
  CATEGORY:=Firmware
  DEPENDS:=@(TARGET_ath79||TARGET_ipq40xx||TARGET_ipq806x||TARGET_qualcommax||TARGET_qualcommbe)
  TITLE:=Custom Board
endef

define ipq-wifi-install-one-to
  $(INSTALL_DIR)  $(2)/lib/firmware/ath10k/$(3)/
  $(INSTALL_DATA) $(1) $(2)/lib/firmware/ath10k/$(3)/board-2.bin
endef

define ipq-wifi-install-ath11-one-to
  $(INSTALL_DIR)  $(2)/lib/firmware/ath11k/$(3)/
  $(INSTALL_DATA) $(1) $(2)/lib/firmware/ath11k/$(3)/board-2.bin
endef

define ipq-wifi-install-ath12-one-to
  $(INSTALL_DIR)  $(2)/lib/firmware/ath12k/$(3)/
  $(INSTALL_DATA) $(1) $(2)/lib/firmware/ath12k/$(3)/board-2.bin
endef

define ipq-wifi-install-one
  $(if $(filter $(suffix $(1)),.QCA4019 .qca4019),\
    $(call ipq-wifi-install-one-to,$(1),$(2),QCA4019/hw1.0),\
  $(if $(filter $(suffix $(1)),.QCA9888 .qca9888),\
    $(call ipq-wifi-install-one-to,$(1),$(2),QCA9888/hw2.0),\
  $(if $(filter $(suffix $(1)),.QCA9889 .qca9889),\
    $(call ipq-wifi-install-one-to,$(1),$(2),QCA9887/hw1.0),\
  $(if $(filter $(suffix $(1)),.QCA9984 .qca9984),\
    $(call ipq-wifi-install-one-to,$(1),$(2),QCA9984/hw1.0),\
  $(if $(filter $(suffix $(1)),.QCA99X0 .qca99x0),\
    $(call ipq-wifi-install-one-to,$(1),$(2),QCA99X0/hw2.0),\
  $(if $(filter $(suffix $(1)),.IPQ5018 .ipq5018),\
    $(call ipq-wifi-install-ath11-one-to,$(1),$(2),IPQ5018/hw1.0),\
  $(if $(filter $(suffix $(1)),.IPQ6018 .ipq6018),\
    $(call ipq-wifi-install-ath11-one-to,$(1),$(2),IPQ6018/hw1.0),\
  $(if $(filter $(suffix $(1)),.IPQ8074 .ipq8074),\
    $(call ipq-wifi-install-ath11-one-to,$(1),$(2),IPQ8074/hw2.0),\
  $(if $(filter $(suffix $(1)),.QCN6122 .qcn6122),\
    $(call ipq-wifi-install-ath11-one-to,$(1),$(2),QCN6122/hw1.0),\
  $(if $(filter $(suffix $(1)),.QCN9074 .qcn9074),\
    $(call ipq-wifi-install-ath11-one-to,$(1),$(2),QCN9074/hw1.0),\
  $(if $(filter $(suffix $(1)),.QCN9274 .qcn9274),\
    $(call ipq-wifi-install-ath12-one-to,$(1),$(2),QCN9274/hw2.0),\
    $(error Unrecognized board-file suffix '$(suffix $(1))' for '$(1)')\
  )))))))))))

endef
# Blank line required at end of above define due to foreach context

define generate-ipq-wifi-package
  define Package/ipq-wifi-$(1)
    $(call Package/ipq-wifi-default)
    TITLE:=board-2.bin Overrides for $(2)
    CONFLICTS:=$(PREV_BOARD)
  endef

  define Package/ipq-wifi-$(1)/description
The $(2) requires board-specific, reference ("cal") data
that is not yet present in the upstream wireless firmware distribution.

This package supplies board-2.bin file(s) that, in the interim,
overwrite those supplied by the ath10k-firmware-* packages.

This is package is only necessary for the $(2).

Do not install it for any other device!
  endef

  define Package/ipq-wifi-$(1)/install-overlay
    $$$$(foreach IPQ_WIFI_BOARD_FILE,$$$$(wildcard $(PKG_BUILD_DIR)/board-$(1).*),\
      $$$$(call ipq-wifi-install-one,$$$$(IPQ_WIFI_BOARD_FILE),$$(1)))
  endef

  PREV_BOARD+=ipq-wifi-$(1)
endef

# To add local files for testing:
# 1. create a new directory in the ipq-wifi package directory called "files".
# 2. place there the needed board files.
#
# To send a board file upstream:
# 1. create a pull request in https://github.com/openwrt/firmware_qca-wireless or
#    send a patch to the mailing list adding the tag firmware/qca-wireless before
#     the PATCH tag.
# 2. create a pull request in the main openwrt repository bumping the ipq-wifi
#    package to the new version and adding the required lines to add the board file.
#
# Changes needed to the ipq-wifi Makefile:
# 1. Add board name to ALLWIFIBOARDS
# 2. Add $(eval $(call generate-ipq-wifi-package,<devicename>,<display name>))
#
# Board files should follow this name structure:
#   board-<devicename>.<qca4019|qca9888|qca9889|qca9984|qca99x0|ipq6018|ipq8074>

$(eval $(call generate-ipq-wifi-package,8devices_kiwi,8devices Kiwi))
$(eval $(call generate-ipq-wifi-package,8devices_mango,8devices Mango))
$(eval $(call generate-ipq-wifi-package,alfa-network_ap120c-ax,ALFA Network AP120C-AX))
$(eval $(call generate-ipq-wifi-package,aliyun_ap8220,Aliyun AP8220))
$(eval $(call generate-ipq-wifi-package,arcadyan_aw1000,Arcadyan AW1000))
$(eval $(call generate-ipq-wifi-package,asus_rt-ax89x,Asus RT-AX89X))
$(eval $(call generate-ipq-wifi-package,buffalo_wxr-5950ax12,Buffalo WXR-5950AX12))
$(eval $(call generate-ipq-wifi-package,cambiumnetworks_xe34,Cambium Networks XE3-4))
$(eval $(call generate-ipq-wifi-package,cmcc_rm2-6,CMCC RM2-6))
$(eval $(call generate-ipq-wifi-package,compex_wpq873,Compex WPQ-873))
$(eval $(call generate-ipq-wifi-package,dynalink_dl-wrx36,Dynalink DL-WRX36))
$(eval $(call generate-ipq-wifi-package,edgecore_eap102,Edgecore EAP102))
$(eval $(call generate-ipq-wifi-package,edimax_cax1800,Edimax CAX1800))
$(eval $(call generate-ipq-wifi-package,elecom_wrc-x3000gs2,ELECOM WRC-X3000GS2))
$(eval $(call generate-ipq-wifi-package,glinet_gl-ax1800,GL.iNet GL-AX1800))
$(eval $(call generate-ipq-wifi-package,glinet_gl-axt1800,GL.iNet GL-AXT1800))
$(eval $(call generate-ipq-wifi-package,glinet_gl-b3000,GL.iNet GL-B3000))
$(eval $(call generate-ipq-wifi-package,ignitenet_ss-w2-ac2600,Ignitenet SS-W2-AC2600))
$(eval $(call generate-ipq-wifi-package,iodata_wn-dax3000gr,I-O DATA WN-DAX3000GR))
$(eval $(call generate-ipq-wifi-package,linksys_homewrk,Linksys HomeWRK))
$(eval $(call generate-ipq-wifi-package,linksys_mr5500,Linksys MR5500))
$(eval $(call generate-ipq-wifi-package,linksys_mr7350,Linksys MR7350))
$(eval $(call generate-ipq-wifi-package,linksys_mr7500,Linksys MR7500))
$(eval $(call generate-ipq-wifi-package,linksys_mx2000,Linksys MX2000))
$(eval $(call generate-ipq-wifi-package,linksys_mx4200,Linksys MX4200))
$(eval $(call generate-ipq-wifi-package,linksys_mx5300,Linksys MX5300))
$(eval $(call generate-ipq-wifi-package,linksys_mx5500,Linksys MX5500))
$(eval $(call generate-ipq-wifi-package,linksys_mx8500,Linksys MX8500))
$(eval $(call generate-ipq-wifi-package,linksys_spnmx56,Linksys SPNMX56))
$(eval $(call generate-ipq-wifi-package,linksys_whw03,Linksys WHW03))
$(eval $(call generate-ipq-wifi-package,netgear_lbr20,Netgear LBR20))
$(eval $(call generate-ipq-wifi-package,netgear_rax120v2,Netgear RAX120v2))
$(eval $(call generate-ipq-wifi-package,netgear_sxk80,Netgear SXK80))
$(eval $(call generate-ipq-wifi-package,netgear_wax214,Netgear WAX214))
$(eval $(call generate-ipq-wifi-package,netgear_wax218,Netgear WAX218))
$(eval $(call generate-ipq-wifi-package,netgear_wax610,Netgear WAX610))
$(eval $(call generate-ipq-wifi-package,netgear_wax610y,Netgear WAX610Y))
$(eval $(call generate-ipq-wifi-package,netgear_wax620,Netgear WAX620))
$(eval $(call generate-ipq-wifi-package,netgear_wax630,Netgear WAX630))
$(eval $(call generate-ipq-wifi-package,qihoo_360v6,Qihoo 360V6))
$(eval $(call generate-ipq-wifi-package,qnap_301w,QNAP 301w))
$(eval $(call generate-ipq-wifi-package,prpl_haze,prpl Haze))
$(eval $(call generate-ipq-wifi-package,redmi_ax6,Redmi AX6))
$(eval $(call generate-ipq-wifi-package,skspruce_wia3300-20,SKSpruce WIA3300-20))
$(eval $(call generate-ipq-wifi-package,spectrum_sax1v1k,Spectrum SAX1V1K))
$(eval $(call generate-ipq-wifi-package,tplink_deco-x80-5g,TP-Link Deco X80-5G))
$(eval $(call generate-ipq-wifi-package,tplink_eap610od,TP-Link EAP610-Outdoor))
$(eval $(call generate-ipq-wifi-package,tplink_eap620hd-v1,TP-Link EAP620 HD v1))
$(eval $(call generate-ipq-wifi-package,tplink_eap623od-hd-v1,TP-Link EAP623-Outdoor HD v1))
$(eval $(call generate-ipq-wifi-package,tplink_eap625od-hd-v1,TP-Link EAP625-Outdoor HD v1))
$(eval $(call generate-ipq-wifi-package,tplink_eap660hd-v1,TP-Link EAP660 HD v1))
$(eval $(call generate-ipq-wifi-package,tplink_archer-c6-v2,TP-Link Archer C6 V2))
$(eval $(call generate-ipq-wifi-package,wallys_dr40x9,Wallys DR40X9))
$(eval $(call generate-ipq-wifi-package,xiaomi_ax3600,Xiaomi AX3600))
$(eval $(call generate-ipq-wifi-package,xiaomi_ax6000,Xiaomi AX6000))
$(eval $(call generate-ipq-wifi-package,xiaomi_ax9000,Xiaomi AX9000))
$(eval $(call generate-ipq-wifi-package,yyets_le1,YYeTs LE1))
$(eval $(call generate-ipq-wifi-package,yuncore_ax830,Yuncore AX830))
$(eval $(call generate-ipq-wifi-package,yuncore_ax880,Yuncore AX880))
$(eval $(call generate-ipq-wifi-package,yuncore_fap650,Yuncore FAP650))
$(eval $(call generate-ipq-wifi-package,zbtlink_zbt-z800ax,Zbtlink ZBT-Z800AX))
$(eval $(call generate-ipq-wifi-package,zte_mf269,ZTE MF269))
$(eval $(call generate-ipq-wifi-package,zte_mf286ar,ZTE MF286A/R))
$(eval $(call generate-ipq-wifi-package,zte_mf286c,ZTE MF286C))
$(eval $(call generate-ipq-wifi-package,zte_mf287,ZTE MF287))
$(eval $(call generate-ipq-wifi-package,zte_mf287plus,ZTE MF287Plus))
$(eval $(call generate-ipq-wifi-package,zyxel_nbg7815,Zyxel NBG7815))
$(eval $(call generate-ipq-wifi-package,anysafe_e1,AnySafe E1))
$(eval $(call generate-ipq-wifi-package,cmiot_ax18,CMIOT AX18))
$(eval $(call generate-ipq-wifi-package,jdcloud_re-ss-01,JDCloud RE-SS-01))
$(eval $(call generate-ipq-wifi-package,jdcloud_re-cs-02,JDCloud RE-CS-02))
$(eval $(call generate-ipq-wifi-package,jdcloud_re-cs-03,JDCloud RE-CS-03))
$(eval $(call generate-ipq-wifi-package,link_nn6000,Link NN6000))
$(eval $(call generate-ipq-wifi-package,redmi_ax5,Redmi AX5))
$(eval $(call generate-ipq-wifi-package,redmi_ax5-jdcloud,Redmi AX5 JDCloud))
$(eval $(call generate-ipq-wifi-package,verizon_cr1000a,Verizon CR1000A))
$(eval $(call generate-ipq-wifi-package,xiaomi_ax1800,Xiaomi AX1800))
$(eval $(call generate-ipq-wifi-package,zn_m2,ZN M2))

$(foreach PACKAGE,$(ALLWIFIPACKAGES),$(eval $(call BuildPackage,$(PACKAGE))))
