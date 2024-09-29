# adler32-simd

This package implements Adler32 hashing with SIMD acceleration for improved performance on modern processors.

## Overview

Adler32 is a common checksum algorithm. This implementation uses SIMD instructions to parallelize computations and achieve significantly faster hashing speeds on supported hardware (amd64 CPUs with SSE3 support and arm64 CPUs with NEON) compared to golang's standard library.

The implementation is based on the zlib code in Chromium and has been transpiled to Go assembly using gocc.

## Features

- SIMD-accelerated Adler32 hashing for supported processors
- Fallback to standard Go implementation for CPUs without SIMD support
- Easy-to-use API that matches the standard library's `hash/adler32` package

## Performance

Benchmarks were performed on various CPU architectures. The following results show the performance of the SIMD-accelerated implementation compared to the standard library implementation for hashing a 1KB buffer:

| CPU                                | Standard Library  | SIMD-accelerated  | Speedup |
|------------------------------------|-------------------|-------------------|---------|
| Intel Xeon Platinum 8375C          | 2894.57 MB/s      | 19306.97 MB/s     | 6.67x   |
| AMD EPYC 9R14                      | 3597.58 MB/s      | 28613.05 MB/s     | 7.95x   |
| AWS Graviton2                      | 1682.56 MB/s      | 12801.97 MB/s     | 7.61x   |
| AWS Graviton3                      | 2204.88 MB/s      | 19564.81 MB/s     | 8.87x   |
| Apple M1                           | 3007.11 MB/s      | 35972.47 MB/s     | 11.96x  |

## Usage

```go
import "github.com/mhr3/adler32-simd"

data := []byte("Hello, World!")
checksum := adler32.Checksum(data)
```
