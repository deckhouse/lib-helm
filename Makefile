.PHONY : doc/build

doc/build:
	go run tools/build-doc.go

doc/diff:
	go run tools/build-doc.go --diff
