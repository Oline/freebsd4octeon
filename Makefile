all:
	sudo HTTP_PROXY="http://vm-http-proxy.services.showroom.nss.thales:3128" portsnap fetch update && sudo pkg version -IvL=
	sudo HTTP_PROXY="http://vm-http-proxy.services.showroom.nss.thales:3128" portmaster -ad --delete-build-only --packages-build

