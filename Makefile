PACKAGES := dart_naver_without_login_common dart_naver_papago dart_naver_clova_face_recognition
GENERATED_PACKAGES := dart_naver_papago dart_naver_clova_face_recognition

.PHONY: get generate format analyze test check publish-dry-run

get:
	dart pub get

generate:
	@for package in $(GENERATED_PACKAGES); do \
		(cd packages/$$package && dart run build_runner build) || exit $$?; \
	done

format:
	dart format --output=none --set-exit-if-changed .

analyze:
	dart analyze

test:
	@for package in $(PACKAGES); do \
		(cd packages/$$package && dart test) || exit $$?; \
	done

check: format analyze test

publish-dry-run:
	@for package in $(PACKAGES); do \
		(cd packages/$$package && dart pub publish --dry-run) || exit $$?; \
	done
