# adler32-simd

This package implements Adler32 hashing with SIMD acceleration for improved performance on modern processors.

## Overview

Adler32 is a common checksum algorithm. This implementation uses SIMD instructions to parallelize computations and achieve significantly faster hashing speeds on supported hardware (amd64 CPUs with at least SSE3 support and arm64 CPUs with NEON) compared to golang's standard library.

The implementation is based on the zlib code in Chromium and has been transpiled to Go assembly using gocc.

## Features

- SIMD-accelerated Adler32 hashing for supported processors
- Fallback to standard Go implementation for CPUs without SIMD support
- Easy-to-use API that matches the standard library's `hash/adler32` package

## Performance

Benchmarks were performed on various CPU architectures. The following results show the performance of the SIMD-accelerated implementation compared to the standard library implementation for hashing a 1kB buffer:

| CPU                                | Standard Library  | SIMD-accelerated  | Speedup |
|------------------------------------|-------------------|-------------------|---------|
| Intel Core i7-8565U                | 2213.71 MB/s      | 26709.75 MB/s     | 12.07x  |
| Intel Xeon Platinum 8375C          | 2895.98 MB/s      | 31288.46 MB/s     | 10.80x  |
| AMD EPYC 9R14                      | 3596.89 MB/s      | 45258.16 MB/s     | 12.58x  |
| AWS Graviton2                      | 1682.56 MB/s      | 12801.97 MB/s     | 7.61x   |
| AWS Graviton3                      | 2204.88 MB/s      | 19564.81 MB/s     | 8.87x   |
| AWS Graviton4                      | 2598.37 MB/s      | 22169.60 MB/s     | 8.53x   |
| Apple M1                           | 3007.11 MB/s      | 35972.47 MB/s     | 11.96x  |
| Apple M1 (amd64 via Rosetta)       | 2849.05 MB/s      | 6287.86 MB/s      | 2.21x   |

## Usage

```go
import "github.com/mhr3/adler32-simd"

data := []byte("Hello, World!")
checksum := adler32.Checksum(data)
```
