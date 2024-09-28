//go:generate go run github.com/mhr3/gocc/cmd/gocc@v0.9.3 c/adler32_neon.c -l -p adler32 -o ../ -a arm64 -O3

package codegen
