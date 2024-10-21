//go:generate go run github.com/mhr3/goruntool@v0.1.1 github.com/mhr3/gocc/cmd/gocc@v0.16.0 csrc/adler32_neon.c -l -p adler32 -o ./ -a arm64 -O3
//go:generate go run github.com/mhr3/goruntool@v0.1.1 github.com/mhr3/gocc/cmd/gocc@v0.16.0 csrc/adler32_sve2.c -l -p adler32 -o ./ -a sve2 -O1
//go:generate go run github.com/mhr3/goruntool@v0.1.1 github.com/mhr3/gocc/cmd/gocc@v0.16.0 csrc/adler32_sse3.c -l -p adler32 -o ./ -a amd64 -m ssse3 -O3
//go:generate go run github.com/mhr3/goruntool@v0.1.1 github.com/mhr3/gocc/cmd/gocc@v0.16.0 csrc/adler32_avx2.c -l -p adler32 -o ./ -a avx2 -O3

package adler32
