#!make
PACKAGES = dart_naver_clova_face_recognition dart_naver_papago dart_naver_without_login_common
all: $(PACKAGES)

.PHONY: $(PACKAGES)
$(PACKAGES):
	echo "Building $@"
	cd ./packages/$@ && \
	dart pub get && \
	cd ..